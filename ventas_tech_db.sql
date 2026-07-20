CREATE DATABASE ventas_tech_db;

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;

CREATE TABLE categorias (
    id_categoria INTEGER PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200)
);

CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    ciudad VARCHAR(50),
    fecha_registro DATE NOT NULL
);

CREATE TABLE productos (
    id_producto INTEGER PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    id_categoria INTEGER NOT NULL,
    precio DECIMAL(10,2) NOT NULL CHECK (precio >= 0),
    stock INTEGER DEFAULT 0 CHECK (stock >= 0),
    activo BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_productos_categorias
        FOREIGN KEY (id_categoria)
        REFERENCES categorias(id_categoria)
);

CREATE TABLE ventas (
    id_venta INTEGER PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10,2) NOT NULL CHECK (precio_unitario >= 0),
    fecha_venta DATE NOT NULL,
    CONSTRAINT fk_ventas_clientes
        FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente),
    CONSTRAINT fk_ventas_productos
        FOREIGN KEY (id_producto)
        REFERENCES productos(id_producto)
);

-- Categorías
INSERT INTO categorias
    (id_categoria, nombre_categoria, descripcion)
VALUES
    (1, 'Computación', 'Laptops, PCs y monitores'),
    (2, 'Accesorios', 'Periféricos y complementos'),
    (3, 'Audio', 'Auriculares y parlantes'),
    (4, 'Almacenamiento', 'Discos y memorias');

-- Clientes
INSERT INTO clientes
    (id_cliente, nombre, email, ciudad, fecha_registro)
VALUES
    (1, 'María López',  'maria@mail.com',  'Buenos Aires', DATE '2024-01-05'),
    (2, 'Carlos Ruiz',  'carlos@mail.com', 'Córdoba',      DATE '2024-01-10'),
    (3, 'Ana Gómez',    'ana@mail.com',    'Rosario',      DATE '2024-02-01'),
    (4, 'Pedro Sanz',   'pedro@mail.com',  'Mendoza',      DATE '2024-02-15'),
    (5, 'Laura Torres', 'laura@mail.com',  'Tucumán',      DATE '2024-03-01');

-- Productos
INSERT INTO productos
    (id_producto, nombre_producto, id_categoria, precio, stock, activo)
VALUES
    (1, 'Laptop Pro 15',      1, 1200.00, 15, TRUE),
    (2, 'Mouse Inalámbrico',  2,   28.00, 80, TRUE),
    (3, 'Monitor 4K 27"',     1,  450.00, 12, TRUE),
    (4, 'Auriculares BT Pro', 3,  120.00, 35, TRUE),
    (5, 'SSD Externo 1TB',    4,  130.00, 18, TRUE),
    (6, 'Teclado Mecánico',   2,   95.00, 40, TRUE);

-- Ventas
INSERT INTO ventas
    (id_venta, id_cliente, id_producto, cantidad, precio_unitario, fecha_venta)
VALUES
    (1,  1, 1, 2, 1200.00, DATE '2024-03-05'),
    (2,  2, 2, 5,   28.00, DATE '2024-03-06'),
    (3,  3, 3, 1,  450.00, DATE '2024-03-07'),
    (4,  1, 4, 2,  120.00, DATE '2024-03-08'),
    (5,  4, 5, 3,  130.00, DATE '2024-03-10'),
    (6,  2, 6, 4,   95.00, DATE '2024-03-11'),
    (7,  5, 1, 1, 1200.00, DATE '2024-03-12'),
    (8,  3, 2, 8,   28.00, DATE '2024-03-13'),
    (9,  4, 4, 1,  120.00, DATE '2024-03-14'),
    (10, 5, 3, 2,  450.00, DATE '2024-03-15');

SELECT * FROM categorias ORDER BY id_categoria;
SELECT * FROM clientes ORDER BY id_cliente;
SELECT * FROM productos ORDER BY id_producto;
SELECT * FROM ventas ORDER BY id_venta;


SELECT 'categorias' AS tabla, COUNT(*) AS cantidad FROM categorias
UNION ALL
SELECT 'clientes', COUNT(*) FROM clientes
UNION ALL
SELECT 'productos', COUNT(*) FROM productos
UNION ALL
SELECT 'ventas', COUNT(*) FROM ventas;


SELECT
    v.id_venta,
    v.fecha_venta,
    c.nombre AS cliente,
    p.nombre_producto AS producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario AS total_venta
FROM ventas AS v
INNER JOIN clientes AS c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos AS p
    ON v.id_producto = p.id_producto
INNER JOIN categorias AS cat
    ON p.id_categoria = cat.id_categoria
ORDER BY v.id_venta;
