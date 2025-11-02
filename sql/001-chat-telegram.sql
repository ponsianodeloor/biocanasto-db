-- Minimal Telegram conversational storage
CREATE SCHEMA IF NOT EXISTS chat;

DROP TABLE IF EXISTS chat.messages;
DROP TABLE IF EXISTS chat.users;

-- Single source of truth for Telegram users (humans and bots)
CREATE TABLE chat.users (
    id BIGSERIAL PRIMARY KEY,
    telegram_user_id BIGINT NOT NULL UNIQUE,
    is_bot BOOLEAN NOT NULL DEFAULT FALSE,
    first_name TEXT,
    last_name TEXT,
    username TEXT,
    language_code TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Conversation log between a human user and the bot
CREATE TABLE chat.messages (
    id BIGSERIAL PRIMARY KEY,
    conversation_user_id BIGINT NOT NULL REFERENCES chat.users(id) ON DELETE CASCADE,
    sender_user_id BIGINT NOT NULL REFERENCES chat.users(id) ON DELETE CASCADE,
    telegram_chat_id BIGINT,
    telegram_message_id BIGINT,
    reply_to_message_id BIGINT,
    message_date TIMESTAMPTZ NOT NULL,
    message_text TEXT,
    raw_payload JSONB,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX chat_messages_conversation_idx
    ON chat.messages (conversation_user_id, message_date DESC);

CREATE OR REPLACE FUNCTION chat.touch_users_updated_at()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_chat_users_touch ON chat.users;
CREATE TRIGGER trg_chat_users_touch
BEFORE UPDATE ON chat.users
FOR EACH ROW
EXECUTE FUNCTION chat.touch_users_updated_at();

-- Persist a message sent by a human user.
CREATE OR REPLACE PROCEDURE chat.save_user_message(
    p_telegram_user_id BIGINT,
    p_first_name TEXT,
    p_last_name TEXT,
    p_username TEXT,
    p_language_code TEXT,
    p_telegram_chat_id BIGINT,
    p_telegram_message_id BIGINT,
    p_message_date TIMESTAMPTZ,
    p_message_text TEXT,
    p_raw_payload JSONB
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_user_id BIGINT;
BEGIN
    INSERT INTO chat.users (
        telegram_user_id,
        is_bot,
        first_name,
        last_name,
        username,
        language_code
    ) VALUES (
        p_telegram_user_id,
        FALSE,
        p_first_name,
        p_last_name,
        p_username,
        p_language_code
    )
    ON CONFLICT (telegram_user_id) DO UPDATE
    SET first_name = EXCLUDED.first_name,
        last_name = EXCLUDED.last_name,
        username = EXCLUDED.username,
        language_code = EXCLUDED.language_code,
        updated_at = NOW()
    RETURNING id INTO v_user_id;

    INSERT INTO chat.messages (
        conversation_user_id,
        sender_user_id,
        telegram_chat_id,
        telegram_message_id,
        reply_to_message_id,
        message_date,
        message_text,
        raw_payload
    ) VALUES (
        v_user_id,
        v_user_id,
        p_telegram_chat_id,
        p_telegram_message_id,
        NULL,
        COALESCE(p_message_date, NOW()),
        p_message_text,
        p_raw_payload
    );
END;
$$;

-- Persist a message sent by the bot to a human user.
CREATE OR REPLACE PROCEDURE chat.save_bot_response(
    p_user_telegram_id BIGINT,
    p_user_first_name TEXT,
    p_user_last_name TEXT,
    p_user_username TEXT,
    p_bot_telegram_id BIGINT,
    p_bot_first_name TEXT,
    p_bot_last_name TEXT,
    p_bot_username TEXT,
    p_telegram_chat_id BIGINT,
    p_telegram_message_id BIGINT,
    p_reply_to_message_id BIGINT,
    p_message_date TIMESTAMPTZ,
    p_message_text TEXT,
    p_raw_payload JSONB
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_user_id BIGINT;
    v_bot_id BIGINT;
BEGIN
    INSERT INTO chat.users (
        telegram_user_id,
        is_bot,
        first_name,
        last_name,
        username,
        language_code
    ) VALUES (
        p_user_telegram_id,
        FALSE,
        p_user_first_name,
        p_user_last_name,
        p_user_username,
        NULL
    )
    ON CONFLICT (telegram_user_id) DO UPDATE
    SET first_name = COALESCE(EXCLUDED.first_name, chat.users.first_name),
        last_name = COALESCE(EXCLUDED.last_name, chat.users.last_name),
        username = COALESCE(EXCLUDED.username, chat.users.username),
        updated_at = NOW()
    RETURNING id INTO v_user_id;

    INSERT INTO chat.users (
        telegram_user_id,
        is_bot,
        first_name,
        last_name,
        username,
        language_code
    ) VALUES (
        p_bot_telegram_id,
        TRUE,
        p_bot_first_name,
        p_bot_last_name,
        p_bot_username,
        NULL
    )
    ON CONFLICT (telegram_user_id) DO UPDATE
    SET first_name = COALESCE(EXCLUDED.first_name, chat.users.first_name),
        last_name = COALESCE(EXCLUDED.last_name, chat.users.last_name),
        username = COALESCE(EXCLUDED.username, chat.users.username),
        updated_at = NOW()
    RETURNING id INTO v_bot_id;

    INSERT INTO chat.messages (
        conversation_user_id,
        sender_user_id,
        telegram_chat_id,
        telegram_message_id,
        reply_to_message_id,
        message_date,
        message_text,
        raw_payload
    ) VALUES (
        v_user_id,
        v_bot_id,
        p_telegram_chat_id,
        p_telegram_message_id,
        p_reply_to_message_id,
        COALESCE(p_message_date, NOW()),
        p_message_text,
        p_raw_payload
    );
END;
$$;
