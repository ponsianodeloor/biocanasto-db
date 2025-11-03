-- Sample catalog entries to complement 003-catalog-products.sql
WITH pk AS (
    SELECT code, id FROM catalog.product_kinds WHERE code IN ('SERVICE', 'VEGETABLE', 'FRUIT')
),
st AS (
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
