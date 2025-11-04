-- Ejemplos de uso para catalog.adjust_product_inventory

-- Incrementa stock (alta) y actualiza el precio.
CALL catalog.adjust_product_inventory(
    'VEG-ACEL-001',    -- p_external_code
    25.5,              -- p_quantity_delta
    1.25,              -- p_new_price
    'cajero@biocanasto', -- p_performed_by
    'Reposición semanal de acelga'
);

-- Ajuste negativo (baja) con nuevo precio.
CALL catalog.adjust_product_inventory(
    'FRU-AGUH-001',    -- Aguacate hass
    -15,               -- Restar unidades
    2.10,              -- Precio actualizado
    'supervisor@biocanasto',
    'Merma por productos dañados'
);

-- Baja dejando el stock en cero; available pasa a false automáticamente.
CALL catalog.adjust_product_inventory(
    'FRU-PINA-001',    -- Piña
    -999,              -- Intento de baja mayor que el stock actual
    NULL,              -- Mantener precio actual
    'cajero@biocanasto',
    'Sin inventario temporalmente'
);

-- Ajuste solo de precio sin variar cantidad.
CALL catalog.adjust_product_inventory(
    'SERV-DEL-001',    -- Servicio de delivery
    0,                 -- Sin cambio de cantidad
    3.75,              -- Nuevo precio
    'coordinador@biocanasto',
    'Ajuste tarifario por combustible'
);
