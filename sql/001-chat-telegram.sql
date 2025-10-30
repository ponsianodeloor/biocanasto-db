-- Basic schema to capture Telegram chat interactions
CREATE SCHEMA IF NOT EXISTS chat;

-- Telegram user profile data (human or bot).
CREATE TABLE IF NOT EXISTS chat.telegram_users (
    telegram_user_id BIGINT PRIMARY KEY,
    is_bot           BOOLEAN NOT NULL DEFAULT FALSE,
    first_name       TEXT,
    last_name        TEXT,
    username         TEXT,
    language_code    TEXT,
    created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at       TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Chats represent either private users, groups or channels.
CREATE TABLE IF NOT EXISTS chat.telegram_chats (
    chat_id    BIGINT PRIMARY KEY,
    type       TEXT NOT NULL CHECK (type IN ('private', 'group', 'supergroup', 'channel')),
    title      TEXT,
    first_name TEXT,
    last_name  TEXT,
    username   TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Incoming updates coming from Telegram's webhook/getUpdates pipeline.
CREATE TABLE IF NOT EXISTS chat.telegram_incoming_updates (
    update_id      BIGINT PRIMARY KEY,
    message_id     BIGINT,
    chat_id        BIGINT REFERENCES chat.telegram_chats(chat_id),
    from_user_id   BIGINT REFERENCES chat.telegram_users(telegram_user_id),
    message_date   TIMESTAMPTZ,
    message_text   TEXT,
    raw_payload    JSONB NOT NULL,
    received_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Individual incoming messages, separated from updates for easy querying.
CREATE TABLE IF NOT EXISTS chat.telegram_incoming_messages (
    chat_id        BIGINT NOT NULL REFERENCES chat.telegram_chats(chat_id),
    message_id     BIGINT NOT NULL,
    from_user_id   BIGINT REFERENCES chat.telegram_users(telegram_user_id),
    message_date   TIMESTAMPTZ NOT NULL,
    message_text   TEXT,
    raw_message    JSONB,
    PRIMARY KEY (chat_id, message_id)
);

-- Messages that our bot sends back to Telegram users.
CREATE TABLE IF NOT EXISTS chat.telegram_outgoing_messages (
    chat_id        BIGINT NOT NULL REFERENCES chat.telegram_chats(chat_id),
    message_id     BIGINT NOT NULL,
    bot_id         BIGINT NOT NULL REFERENCES chat.telegram_users(telegram_user_id),
    reply_to       BIGINT,
    message_date   TIMESTAMPTZ NOT NULL,
    message_text   TEXT,
    raw_payload    JSONB,
    PRIMARY KEY (chat_id, message_id)
);

CREATE INDEX IF NOT EXISTS telegram_incoming_updates_chat_idx
    ON chat.telegram_incoming_updates (chat_id);

CREATE INDEX IF NOT EXISTS telegram_incoming_messages_user_idx
    ON chat.telegram_incoming_messages (from_user_id, message_date DESC);

CREATE INDEX IF NOT EXISTS telegram_outgoing_messages_chat_idx
    ON chat.telegram_outgoing_messages (chat_id, message_date DESC);
