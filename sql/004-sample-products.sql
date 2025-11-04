-- Sample catalog entries to complement 003-catalog-products.sql

WITH pk AS (
    SELECT code, id FROM catalog.product_kinds WHERE code IN ('SERVICE', 'VEGETABLE', 'FRUIT')
), st AS (
    SELECT code, id FROM catalog.sale_types WHERE code IN ('POUND', 'UNIT')
)
INSERT INTO catalog.products (
    external_code,
    name,
    description,
    product_kind_id,
    sale_type_id,
    price,
    available_quantity,
    available,
    metadata
)
VALUES
    (
        'SERV-DEL-001',
        'Delivery Express',
        'Same-day delivery service within Quito.',
        (SELECT id FROM pk WHERE code = 'SERVICE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        3.50,
        999.00,
        TRUE,
        '{"coverage":"Quito Metro","sla_hours":4}'::jsonb
    )
ON CONFLICT (name, product_kind_id) DO NOTHING;

WITH pk AS (
    SELECT code, id FROM catalog.product_kinds WHERE code = 'VEGETABLE'
), st AS (
    SELECT code, id FROM catalog.sale_types WHERE code IN ('POUND', 'UNIT')
)
INSERT INTO catalog.products (
    external_code,
    name,
    description,
    product_kind_id,
    sale_type_id,
    price,
    available_quantity,
    available,
    metadata
)
VALUES
    (
        'VEG-ACEL-001',
        'Acelga',
        'Acelga fresca cultivada en fincas locales.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        1.10,
        60,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-AJOM-001',
        'Ajo molido',
        'Ajo molido artesanal listo para cocinar.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        1.75,
        120,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-AJOP-001',
        'Ajo pelado',
        'Dientes de ajo pelado envasados al vacío.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'POUND'),
        3.80,
        45,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-APIO-001',
        'Apio',
        'Apio crujiente ideal para caldos y ensaladas.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        0.95,
        80,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-ARVT-001',
        'Arveja tierna',
        'Arveja tierna seleccionada lista para cocinar.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'POUND'),
        2.90,
        70,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-BERE-001',
        'Berenjena',
        'Berenjena morada de textura suave.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        1.30,
        65,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-BROC-001',
        'Brócoli',
        'Brócoli compacto y fresco de producción local.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        1.50,
        90,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-CABA-001',
        'Cabeza de ajo',
        'Cabezas de ajo secadas al sol.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        0.55,
        150,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-CAMO-001',
        'Camote',
        'Camote dulce cosechado en la Costa ecuatoriana.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'POUND'),
        1.40,
        110,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-CAF1-001',
        'Cafe agroecológico molido de Pacto',
        'Cafe agroecológico molido de Pacto - Quito - Ec (100% orgánico).',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        9.00,
        200,
        TRUE,
        '{"category":"Verdura","presentacion":"molido"}'::jsonb
    ),
    (
        'VEG-CAF2-001',
        'Cafe agroecológico en grano de Pacto',
        'Cafe agroecológico en grano de Pacto - Quito - Ec (100% orgánico).',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        9.00,
        180,
        TRUE,
        '{"category":"Verdura","presentacion":"grano"}'::jsonb
    ),
    (
        'VEG-CEBL-001',
        'Cebolla larga o blanca',
        'Cebolla blanca tierna para sofritos y caldos.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        0.80,
        140,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-CEBP-001',
        'Cebolla paiteña',
        'Cebolla roja paiteña de sabor intenso.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'POUND'),
        1.10,
        120,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-CEBR-001',
        'Cebolla perla',
        'Cebolla perla ideal para encurtidos.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'POUND'),
        1.60,
        90,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-CHOH-001',
        'Chocho',
        'Chocho precocido tradicional andino.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'POUND'),
        2.40,
        85,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-CILA-001',
        'Cilantro',
        'Racimos de cilantro recién cosechados.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        0.50,
        150,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-COLB-001',
        'Col blanca',
        'Col blanca crujiente lista para ensaladas.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        1.00,
        70,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-COLM-001',
        'Col morada',
        'Col morada rica en antioxidantes.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        1.20,
        65,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-COLF-001',
        'Coliflor',
        'Cabezas de coliflor compactas y frescas.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        1.60,
        75,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-CHOS-001',
        'Choclo (sierra)',
        'Mazorcas de choclo tierno de la Sierra.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        0.90,
        130,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-CHOD-001',
        'Choclo (sierra) desgranado',
        'Choclo serrano desgranado listo para cocinar.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'POUND'),
        1.80,
        60,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-ESPA-001',
        'Esparragos',
        'Manojos de espárragos tiernos.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        2.20,
        55,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-PIMC-001',
        'Pimiento rojo, verde y amarillo (combo)',
        'Combo tricolor de pimientos frescos.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        2.50,
        90,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-ESPI-001',
        'Espinaca',
        'Hojas de espinaca tierna listas para batidos.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        0.95,
        110,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-FREC-001',
        'Fréjol canario',
        'Fréjol canario seco de primera selección.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'POUND'),
        2.30,
        75,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-GARB-001',
        'Garbanzo',
        'Garbanzo seco rico en proteína vegetal.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'POUND'),
        2.10,
        90,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-HABA-001',
        'Habas tiernas',
        'Habas tiernas seleccionadas a mano.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'POUND'),
        2.60,
        70,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-HIER-001',
        'Hierbabuena',
        'Hierbabuena aromática ideal para infusiones.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        0.60,
        160,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-HUEV-001',
        'Huevos',
        'Huevos frescos de gallinas camperas.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        3.40,
        200,
        TRUE,
        '{"category":"Verdura","presentacion":"docena"}'::jsonb
    ),
    (
        'VEG-HUEC-001',
        'Huevos cubeta',
        'Cubeta de 30 huevos de producción local.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        9.80,
        80,
        TRUE,
        '{"category":"Verdura","presentacion":"cubeta"}'::jsonb
    ),
    (
        'VEG-HUEM-001',
        'Huevos media cubeta',
        'Media cubeta de huevos frescos.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        5.20,
        120,
        TRUE,
        '{"category":"Verdura","presentacion":"media_cubeta"}'::jsonb
    ),
    (
        'VEG-LECC-001',
        'Lechuga crespa',
        'Lechuga crespa verde de cultivo hidropónico.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        1.10,
        95,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-LECR-001',
        'Lechuga criolla',
        'Lechuga criolla tierna y crujiente.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        0.90,
        100,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-LECH-001',
        'Lechuga roja',
        'Lechuga roja con hojas suaves y dulces.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        1.20,
        85,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-LERO-001',
        'Lechuga romana',
        'Lechuga romana ideal para ensaladas César.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        1.15,
        90,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-LENT-001',
        'Lenteja',
        'Lenteja seca lista para sopas y guisos.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'POUND'),
        1.90,
        140,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-MELL-001',
        'Melloco',
        'Melloco andino ideal para locro.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'POUND'),
        1.85,
        80,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-OCAA-001',
        'Oca',
        'Oca tradicional de la Sierra ecuatoriana.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'POUND'),
        1.70,
        75,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-PAPC-001',
        'Papa capira',
        'Papa capira para hornos y purés.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'POUND'),
        0.95,
        200,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-PAPH-001',
        'Papa chaucha',
        'Papa chaucha pequeña y sabrosa.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'POUND'),
        1.05,
        160,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-PACH-001',
        'Papa chola',
        'Papa chola amarilla de textura cremosa.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'POUND'),
        1.00,
        210,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-PEPI-001',
        'Pepino',
        'Pepino verde crujiente ideal para ensaladas.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        0.70,
        130,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-PERE-001',
        'Perejil',
        'Perejil fresco para sazonar platillos.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        0.55,
        150,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-PIMA-001',
        'Pimiento amarillo',
        'Pimiento amarillo dulce y carnoso.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        1.10,
        80,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-PIMR-001',
        'Pimiento rojo',
        'Pimiento rojo ideal para asar o rellenar.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        1.05,
        90,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-PIMV-001',
        'Pimiento verde',
        'Pimiento verde fresco y crocante.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        0.95,
        100,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-QUES-001',
        'Queso fresco',
        'Queso fresco artesanal de leche pasteurizada.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        3.80,
        60,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-QMAN-001',
        'Queso manaba',
        'Queso manaba con sello artesanal.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        4.20,
        55,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-QMOZ-001',
        'Queso mozzarella',
        'Queso mozzarella ideal para pizzas y lasañas.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        4.60,
        65,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-RABA-001',
        'Rábano',
        'Racimos de rábano crocante.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        0.80,
        140,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-REMO-001',
        'Remolacha',
        'Remolacha dulce perfecta para ensaladas.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        1.00,
        100,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-TOMC-001',
        'Tomate cherry',
        'Tomate cherry dulce empacado en bandejas.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        2.20,
        85,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-TOMR-001',
        'Tomate riñón',
        'Tomate riñón rojo intenso para ensaladas.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'POUND'),
        1.25,
        180,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-VAIN-001',
        'Vainita',
        'Vainita tierna ideal para salteados.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'POUND'),
        2.10,
        70,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-YUCA-001',
        'Yuca',
        'Yuca blanca harinosa para frituras y caldos.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'POUND'),
        1.30,
        120,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-ZAMB-001',
        'Zambo',
        'Zambo tierno para sopas tradicionales.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        1.50,
        45,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-ZANA-001',
        'Zanahoria',
        'Zanahoria anaranjada rica en betacarotenos.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'POUND'),
        0.85,
        210,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-ZANB-001',
        'Zanahoria blanca',
        'Zanahoria blanca tierna de sabor suave.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'POUND'),
        0.95,
        95,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-ZAPA-001',
        'Zapallo',
        'Zapallo amarillo para cremas y panes.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        2.30,
        60,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    ),
    (
        'VEG-ZUCC-001',
        'Zucchini',
        'Zucchini verde versátil para salteados.',
        (SELECT id FROM pk WHERE code = 'VEGETABLE'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        1.40,
        80,
        TRUE,
        '{"category":"Verdura"}'::jsonb
    )
ON CONFLICT (name, product_kind_id) DO NOTHING;

WITH pk AS (
    SELECT code, id FROM catalog.product_kinds WHERE code = 'FRUIT'
), st AS (
    SELECT code, id FROM catalog.sale_types WHERE code IN ('POUND', 'UNIT')
)
INSERT INTO catalog.products (
    external_code,
    name,
    description,
    product_kind_id,
    sale_type_id,
    price,
    available_quantity,
    available,
    metadata
)
VALUES
    (
        'FRU-AGUF-001',
        'Aguacate fuerte (sierra)',
        'Aguacate fuerte cultivado en la Sierra.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        1.50,
        90,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-AGUH-001',
        'Aguacate hass',
        'Aguacate hass cremoso de temporada.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        1.80,
        120,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-AGUT-001',
        'Aguacate típico (costa)',
        'Aguacate típico cosechado en la Costa.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        1.40,
        110,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-ARAN-001',
        'Arandanos',
        'Arandanos frescos empacados en bandeja.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        3.90,
        75,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-BABA-001',
        'Babaco',
        'Babaco dulce ideal para jugos.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        2.10,
        65,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-BANA-001',
        'Banano',
        'Banano de exportación listo para consumo.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'POUND'),
        0.65,
        220,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-BANR-001',
        'Banano orito',
        'Banano orito dulce en racimos pequeños.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        1.20,
        130,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-BANS-001',
        'Banano seda',
        'Banano seda de textura delicada.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'POUND'),
        0.80,
        180,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-CIRU-001',
        'Ciruela',
        'Ciruelas moradas maduras listas para comer.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'POUND'),
        2.20,
        60,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-DURA-001',
        'Durazno',
        'Durazno amarillo jugoso.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'POUND'),
        1.90,
        95,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-DURN-001',
        'Durazno nectar',
        'Durazno nectar dulce y aromático.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'POUND'),
        2.10,
        80,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-GRAN-001',
        'Granada',
        'Granadas grandes con arilos jugosos.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        2.80,
        55,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-GRAD-001',
        'Granadilla',
        'Granadilla dulce de la Sierra ecuatoriana.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        1.00,
        140,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-GUAN-001',
        'Guanábana',
        'Guanábana grande perfecta para jugos.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        3.50,
        45,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-GUAY-001',
        'Guayaba',
        'Guayaba rosada aromática.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'POUND'),
        1.70,
        120,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-LIMA-001',
        'Lima',
        'Limas frescas para bebidas y postres.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        0.70,
        140,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-LIMS-001',
        'Limón sutil',
        'Limón sutil recién cosechado.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'POUND'),
        1.10,
        160,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-LIMT-001',
        'Limón tahití',
        'Limón tahití de tamaño grande.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'POUND'),
        1.30,
        150,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-MAND-001',
        'Mandarina',
        'Mandarina dulce y fácil de pelar.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'POUND'),
        1.60,
        190,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-MANI-001',
        'Mandarina injerta',
        'Mandarina injerta de sabor intenso.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'POUND'),
        1.80,
        120,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-MANC-001',
        'Mango de chupar',
        'Mango de chupar jugoso y dulce.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        1.40,
        110,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-MANT-001',
        'Mango Tommy Atkins',
        'Mango Tommy Atkins de pulpa firme.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        1.70,
        100,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-MANM-001',
        'Mango de mantequilla',
        'Mango de mantequilla muy aromático.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        1.60,
        95,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-MANG-001',
        'Manzana gala',
        'Manzana gala crujiente y dulce.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'POUND'),
        2.30,
        130,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-MANL-001',
        'Manzana golden',
        'Manzana golden de pulpa jugosa.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'POUND'),
        2.20,
        110,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-MANS-001',
        'Manzana granny smith (verde)',
        'Manzana verde granny smith crujiente.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'POUND'),
        2.40,
        90,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-MANR-001',
        'Manzana red delicius ec',
        'Manzana red delicious ecuatoriana.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'POUND'),
        2.10,
        100,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-MANV-001',
        'Manzana verde',
        'Manzana verde fresca de temporada.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'POUND'),
        2.20,
        95,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-MARA-001',
        'Maracuyá',
        'Maracuyá amarillo para jugos y postres.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'POUND'),
        1.50,
        150,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-MELN-001',
        'Melón',
        'Melón cantalupo de pulpa dulce.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        2.60,
        70,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-MORA-001',
        'Moras',
        'Moras andinas listas para postres.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'POUND'),
        2.80,
        65,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-NARA-001',
        'Naranja',
        'Naranja jugosa rica en vitamina C.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'POUND'),
        1.40,
        210,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-NARJ-001',
        'Naranjilla',
        'Naranjilla andina perfecta para refrescos.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'POUND'),
        1.90,
        80,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-PAPN-001',
        'Papaya nacional',
        'Papaya nacional madura y aromática.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        2.40,
        60,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-PAPH-001',
        'Papaya hawaiana',
        'Papaya hawaiana de pulpa rosada.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        2.80,
        55,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-PAPM-001',
        'Papaya maradol',
        'Papaya maradol grande y dulce.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        3.00,
        50,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-PEPD-001',
        'Pepino dulce',
        'Pepino dulce de la Sierra ecuatoriana.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        1.10,
        95,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-PERB-001',
        'Pera blanca',
        'Pera blanca jugosa y aromática.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'POUND'),
        2.00,
        100,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-PERC-001',
        'Pera café',
        'Pera café dulce y de piel suave.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'POUND'),
        2.10,
        95,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-PERP-001',
        'Pera piña',
        'Pera piña de textura crocante.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'POUND'),
        2.20,
        90,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-PINA-001',
        'Piña',
        'Piña dulce cosechada en la Costa.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        2.50,
        85,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-PITA-001',
        'Pitahaya amarilla',
        'Pitahaya amarilla de pulpa suave.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        3.80,
        60,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-PITR-001',
        'Pitahaya roja',
        'Pitahaya roja rica en antioxidantes.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        3.80,
        60,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-PLAM-001',
        'Plátano maduro',
        'Plátano maduro para asados o frituras.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'POUND'),
        0.90,
        150,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-PLAV-001',
        'Plátano verde',
        'Plátano verde ideal para patacones.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'POUND'),
        0.80,
        170,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-SAND-001',
        'Sandía',
        'Sandía grande y refrescante.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        3.20,
        45,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-TOMA-001',
        'Tomate de árbol',
        'Tomate de árbol para jugos energéticos.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'POUND'),
        1.60,
        120,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-TORO-001',
        'Toronja',
        'Toronja rosada rica en vitamina C.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'UNIT'),
        1.30,
        85,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-UVAN-001',
        'Uvas negras',
        'Uvas negras sin semillas.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'POUND'),
        3.20,
        70,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-UVAR-001',
        'Uvas rojas',
        'Uvas rojas dulces y jugosas.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'POUND'),
        3.00,
        75,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-UVAV-001',
        'Uvas verdes',
        'Uvas verdes crujientes sin semillas.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'POUND'),
        3.00,
        75,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    ),
    (
        'FRU-UVIL-001',
        'Uvilla',
        'Uvillas doradas con sabor tropical.',
        (SELECT id FROM pk WHERE code = 'FRUIT'),
        (SELECT id FROM st WHERE code = 'POUND'),
        3.10,
        65,
        TRUE,
        '{"category":"Fruta"}'::jsonb
    )
ON CONFLICT (name, product_kind_id) DO NOTHING;
