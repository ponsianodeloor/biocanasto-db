-- Product catalog schema covering services and tangible products.
CREATE SCHEMA IF NOT EXISTS catalog;

DROP TABLE IF EXISTS catalog.products CASCADE;
DROP TABLE IF EXISTS catalog.sale_types CASCADE;
DROP TABLE IF EXISTS catalog.product_kinds CASCADE;

DROP FUNCTION IF EXISTS catalog.touch_products_updated_at() CASCADE;

-- Defines high level product kinds such as services, vegetables, or fruits.
CREATE TABLE catalog.product_kinds (
    id SMALLSERIAL PRIMARY KEY,
    code TEXT NOT NULL UNIQUE CHECK (char_length(code) > 0),
    name TEXT NOT NULL,
    description TEXT,
    is_service BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Enumerates how items are sold (per pound, per unit, etc.).
CREATE TABLE catalog.sale_types (
    id SMALLSERIAL PRIMARY KEY,
    code TEXT NOT NULL UNIQUE CHECK (char_length(code) > 0),
    name TEXT NOT NULL,
    unit_label TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Core product table used for services and tangible products.
CREATE TABLE catalog.products (
    id BIGSERIAL PRIMARY KEY,
    external_code TEXT,
    name TEXT NOT NULL,
    description TEXT,
    product_kind_id SMALLINT NOT NULL REFERENCES catalog.product_kinds(id),
    sale_type_id SMALLINT NOT NULL REFERENCES catalog.sale_types(id),
    price NUMERIC(12, 2) NOT NULL DEFAULT 0 CHECK (price >= 0),
    available_quantity NUMERIC(12, 2) NOT NULL DEFAULT 0 CHECK (available_quantity >= 0),
    available BOOLEAN NOT NULL DEFAULT TRUE,
    metadata JSONB,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (name, product_kind_id)
);

CREATE INDEX catalog_products_available_idx
    ON catalog.products (available);

CREATE INDEX catalog_products_kind_sale_type_idx
    ON catalog.products (product_kind_id, sale_type_id);

-- Maintains updated_at on product changes.
CREATE OR REPLACE FUNCTION catalog.touch_products_updated_at()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_catalog_products_touch ON catalog.products;
CREATE TRIGGER trg_catalog_products_touch
BEFORE UPDATE ON catalog.products
FOR EACH ROW
EXECUTE FUNCTION catalog.touch_products_updated_at();

-- Seed catalog dimensions.
INSERT INTO catalog.product_kinds (code, name, description, is_service)
VALUES
    ('SERVICE', 'Service', 'Intangible services such as delivery or subscription plans.', TRUE),
    ('VEGETABLE', 'Vegetable', 'Fresh vegetables offered in the marketplace.', FALSE),
    ('FRUIT', 'Fruit', 'Seasonal or imported fruits ready for sale.', FALSE)
ON CONFLICT (code) DO NOTHING;

INSERT INTO catalog.sale_types (code, name, unit_label)
VALUES
    ('POUND', 'Per pound', 'lb'),
    ('UNIT', 'Per unit', 'unit')
ON CONFLICT (code) DO NOTHING;
