-- Inventory control for catalog products (alta y baja management).

-- Records every stock adjustment made via stored procedures.
CREATE TABLE IF NOT EXISTS catalog.product_movements (
    id BIGSERIAL PRIMARY KEY,
    product_id BIGINT NOT NULL REFERENCES catalog.products(id) ON DELETE CASCADE,
    movement_type TEXT NOT NULL CHECK (movement_type IN ('ALTA', 'BAJA')),
    requested_quantity_delta NUMERIC(12, 2) NOT NULL,
    applied_quantity_delta NUMERIC(12, 2) NOT NULL,
    previous_quantity NUMERIC(12, 2) NOT NULL,
    new_quantity NUMERIC(12, 2) NOT NULL,
    previous_price NUMERIC(12, 2) NOT NULL,
    new_price NUMERIC(12, 2) NOT NULL,
    note TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS catalog_product_movements_product_id_idx
    ON catalog.product_movements (product_id, created_at DESC);

-- Stored procedure to adjust stock and price using the product external code.
CREATE OR REPLACE PROCEDURE catalog.adjust_product_inventory(
    p_external_code TEXT,
    p_quantity_delta NUMERIC,
    p_new_price NUMERIC,
    p_note TEXT DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_product_id BIGINT;
    v_current_quantity NUMERIC(12, 2);
    v_current_price NUMERIC(12, 2);
    v_new_quantity NUMERIC(12, 2);
    v_applied_delta NUMERIC(12, 2);
    v_new_price NUMERIC(12, 2);
    v_movement_type TEXT;
BEGIN
    IF p_external_code IS NULL OR trim(p_external_code) = '' THEN
        RAISE EXCEPTION 'El código externo del producto no puede ser nulo.';
    END IF;

    IF p_quantity_delta IS NULL THEN
        RAISE EXCEPTION 'La variación de cantidad es obligatoria.';
    END IF;

    SELECT id, available_quantity, price
    INTO v_product_id, v_current_quantity, v_current_price
    FROM catalog.products
    WHERE external_code = p_external_code
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró un producto con el código externo %.', p_external_code;
    END IF;

    v_movement_type := CASE
        WHEN p_quantity_delta >= 0 THEN 'ALTA'
        ELSE 'BAJA'
    END;

    v_new_quantity := v_current_quantity + p_quantity_delta;
    IF v_new_quantity < 0 THEN
        v_new_quantity := 0;
    END IF;

    v_applied_delta := v_new_quantity - v_current_quantity;

    IF p_new_price IS NULL THEN
        v_new_price := v_current_price;
    ELSIF p_new_price < 0 THEN
        RAISE EXCEPTION 'El nuevo precio no puede ser negativo.';
    ELSE
        v_new_price := p_new_price;
    END IF;

    UPDATE catalog.products
    SET available_quantity = v_new_quantity,
        price = v_new_price,
        available = (v_new_quantity > 0)
    WHERE id = v_product_id;

    INSERT INTO catalog.product_movements (
        product_id,
        movement_type,
        requested_quantity_delta,
        applied_quantity_delta,
        previous_quantity,
        new_quantity,
        previous_price,
        new_price,
        note
    ) VALUES (
        v_product_id,
        v_movement_type,
        p_quantity_delta,
        v_applied_delta,
        v_current_quantity,
        v_new_quantity,
        v_current_price,
        v_new_price,
        p_note
    );
END;
$$;
