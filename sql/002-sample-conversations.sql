-- Sample data: three independent conversations using the stored procedures.

-- Conversation 1: Ana López
CALL chat.save_user_message(
    5256593353,
    'Ana',
    'López',
    'ana_lopez',
    'es',
    6001001,
    101,
    TIMESTAMPTZ '2024-11-01 10:00:00+00',
    'Hola, ¿pueden contarme las ofertas de la semana?',
    '{"update_id":900001, "message":{"text":"Hola, ¿pueden contarme las ofertas de la semana?"}}'::jsonb
);

CALL chat.save_bot_response(
    5256593353,
    'Ana',
    'López',
    'ana_lopez',
    999000001,
    'CanastaSmartBot',
    NULL,
    'CanastaSmartBot',
    6001001,
    102,
    101,
    TIMESTAMPTZ '2024-11-01 10:00:05+00',
    '¡Hola Ana! Esta semana tenemos combos de frutas con 10% de descuento.',
    '{"message":{"text":"¡Hola Ana! Esta semana tenemos combos de frutas con 10% de descuento."}}'::jsonb
);

CALL chat.save_user_message(
    5256593353,
    'Ana',
    'López',
    'ana_lopez',
    'es',
    6001001,
    103,
    TIMESTAMPTZ '2024-11-01 10:00:20+00',
    'Genial, ¿me agregas uno al carrito?',
    '{"update_id":900002, "message":{"text":"Genial, ¿me agregas uno al carrito?"}}'::jsonb
);

CALL chat.save_bot_response(
    5256593353,
    'Ana',
    'López',
    'ana_lopez',
    999000001,
    'CanastaSmartBot',
    NULL,
    'CanastaSmartBot',
    6001001,
    104,
    103,
    TIMESTAMPTZ '2024-11-01 10:00:26+00',
    'Ya lo agregué, recibirás una confirmación en tu correo.',
    '{"message":{"text":"Ya lo agregué, recibirás una confirmación en tu correo."}}'::jsonb
);

-- Conversation 2: Bruno Pérez
CALL chat.save_user_message(
    5256593354,
    'Bruno',
    'Pérez',
    'bruno_p',
    'es',
    6002002,
    201,
    TIMESTAMPTZ '2024-11-02 15:30:00+00',
    'Buenas, necesito cambiar la dirección de entrega.',
    '{"update_id":910001, "message":{"text":"Buenas, necesito cambiar la dirección de entrega."}}'::jsonb
);

CALL chat.save_bot_response(
    5256593354,
    'Bruno',
    'Pérez',
    'bruno_p',
    999000001,
    'CanastaSmartBot',
    NULL,
    'CanastaSmartBot',
    6002002,
    202,
    201,
    TIMESTAMPTZ '2024-11-02 15:30:06+00',
    'Claro Bruno, ¿cuál es la nueva dirección?',
    '{"message":{"text":"Claro Bruno, ¿cuál es la nueva dirección?"}}'::jsonb
);

CALL chat.save_user_message(
    5256593354,
    'Bruno',
    'Pérez',
    'bruno_p',
    'es',
    6002002,
    203,
    TIMESTAMPTZ '2024-11-02 15:30:20+00',
    'Es Av. Amazonas N34-120, Quito.',
    '{"update_id":910002, "message":{"text":"Es Av. Amazonas N34-120, Quito."}}'::jsonb
);

CALL chat.save_bot_response(
    5256593354,
    'Bruno',
    'Pérez',
    'bruno_p',
    999000001,
    'CanastaSmartBot',
    NULL,
    'CanastaSmartBot',
    6002002,
    204,
    203,
    TIMESTAMPTZ '2024-11-02 15:30:28+00',
    'Perfecto, ya actualicé tu dirección para el próximo pedido.',
    '{"message":{"text":"Perfecto, ya actualicé tu dirección para el próximo pedido."}}'::jsonb
);

-- Conversation 3: Carla Mena
CALL chat.save_user_message(
    5256593355,
    'Carla',
    'Mena',
    'carla_m',
    'es',
    6003003,
    301,
    TIMESTAMPTZ '2024-11-03 08:45:00+00',
    'Hola, ¿cuándo llega mi pedido?',
    '{"update_id":920001, "message":{"text":"Hola, ¿cuándo llega mi pedido?"}}'::jsonb
);

CALL chat.save_bot_response(
    5256593355,
    'Carla',
    'Mena',
    'carla_m',
    999000001,
    'CanastaSmartBot',
    NULL,
    'CanastaSmartBot',
    6003003,
    302,
    301,
    TIMESTAMPTZ '2024-11-03 08:45:05+00',
    'Hola Carla, tu pedido está en camino y llegará hoy entre 11h00 y 12h00.',
    '{"message":{"text":"Hola Carla, tu pedido está en camino y llegará hoy entre 11h00 y 12h00."}}'::jsonb
);

CALL chat.save_user_message(
    5256593355,
    'Carla',
    'Mena',
    'carla_m',
    'es',
    6003003,
    303,
    TIMESTAMPTZ '2024-11-03 08:45:20+00',
    'Gracias, ¿pueden avisarme cuando llegue?',
    '{"update_id":920002, "message":{"text":"Gracias, ¿pueden avisarme cuando llegue?"}}'::jsonb
);

CALL chat.save_bot_response(
    5256593355,
    'Carla',
    'Mena',
    'carla_m',
    999000001,
    'CanastaSmartBot',
    NULL,
    'CanastaSmartBot',
    6003003,
    304,
    303,
    TIMESTAMPTZ '2024-11-03 08:45:28+00',
    '¡Listo! Te enviaremos una notificación cuando el repartidor esté en tu puerta.',
    '{"message":{"text":"¡Listo! Te enviaremos una notificación cuando el repartidor esté en tu puerta."}}'::jsonb
);
