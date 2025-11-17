USE ComercioDB;
GO

-- =====================
-- CATEGORÍAS
-- =====================
INSERT INTO Categorias (Descripcion) VALUES
('Sedán'),
('SUV'),
('Pickup'),
('Deportivo'),
('Hatchback');

-- =====================
-- MARCAS
-- =====================
INSERT INTO Marcas (Nombre) VALUES
('Toyota'),
('Volkswagen'),
('Ford'),
('Chevrolet'),
('BMW');

-- =====================
-- PROVEEDORES
-- =====================
INSERT INTO Proveedores (Nombre, Telefono, Email) VALUES
('Toyota Argentina S.A.', 1145557788, 'contacto@toyota.com.ar'),
('Volkswagen Group Argentina', 1142223344, 'ventas@vw.com.ar'),
('Ford Motor Argentina', 1133335566, 'info@ford.com.ar'),
('Chevrolet Motors Argentina', 1122224455, 'proveedores@chevrolet.com.ar'),
('BMW Group Argentina', 1155556677, 'ventas@bmw.com.ar');

-- =====================
-- USUARIOS
-- =====================
INSERT INTO Usuarios (Nombre, Contrasenia, Rol) VALUES
('Camila', 'ontivero', 1),
('Renzo', 'marangon', 1),
('vendedor2', 'autos2025', 2);

-- =====================
-- CLIENTES
-- =====================
INSERT INTO Clientes (Nombre, Telefono, Email) VALUES
('Juan Pérez', '1122334455', 'juan.perez@gmail.com'),
('María Gómez', '1133445566', 'maria.gomez@hotmail.com'),
('Carlos Rodríguez', '1144556677', 'carlosr@outlook.com'),
('Lucía Fernández', '1155667788', 'luciaf@gmail.com'),
('Martín López', '1166778899', 'martin.lopez@yahoo.com');

-- =====================
-- PRODUCTOS (VEHÍCULOS)
-- =====================
INSERT INTO Productos (Nombre, idMarca, idCategoria, stockActual, stockMinimo, PorcentajeGanancia, idProveedoresProductos)
VALUES
('Toyota Corolla XEI 2.0', 1, 1, 5, 1, 20.00, 1),
('Toyota Hilux 4x4 SRV', 1, 3, 3, 1, 25.00, 1),
('Volkswagen T-Cross Comfortline', 2, 2, 4, 1, 22.00, 2),
('Ford Ranger Limited 4x4', 3, 3, 2, 1, 25.00, 3),
('Chevrolet Onix LTZ', 4, 5, 6, 2, 18.00, 4),
('BMW Serie 3 320i', 5, 1, 1, 1, 30.00, 5),
('Volkswagen Golf GTI', 2, 4, 2, 1, 28.00, 2),
('Toyota RAV4 Hybrid', 1, 2, 3, 1, 26.00, 1);

-- =====================
-- IMÁGENES
-- =====================
INSERT INTO Imagenes (idProducto, ImagenUrl) VALUES
(1, 'https://acroadtrip.blob.core.windows.net/catalogo-imagenes/s/RT_V_5f198c2718fb4374894a07d61d75e053.webp'),
(1, 'https://www.podersa.com.ar/plantilla/assets/vehiculos2/COROLLA.jpg'),
(2, 'https://cdn.motor1.com/images/mgl/pEw1b/s1/toyota-hilux-2021.jpg'),
(3, 'https://cdn.motor1.com/images/mgl/3oJm1/s1/vw-t-cross.jpg'),
(4, 'https://cdn.motor1.com/images/mgl/3JmmR/s1/ford-ranger-limited.jpg'),
(5, 'https://cdn.motor1.com/images/mgl/0xKkY/s1/chevrolet-onix-2021.jpg'),
(6, 'https://cdn.motor1.com/images/mgl/RAqz1/s1/bmw-320i.jpg'),
(7, 'https://cdn.motor1.com/images/mgl/z0PP9/s1/vw-golf-gti.jpg'),
(8, 'https://cdn.motor1.com/images/mgl/1Z3g1/s1/toyota-rav4-hybrid.jpg');

-- =====================
-- PROVEEDORESPRODUCTOS
-- =====================
INSERT INTO ProveedoresProductos (idProveedor, idProducto) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(4, 5),
(5, 6),
(2, 7),
(1, 8);

-- =====================
-- COMPRAS
-- =====================
INSERT INTO Compras (Fecha, idProveedor, Total, idUsuario) VALUES
('2025-01-10', 1, 12000000.00, 1),
('2025-02-15', 2, 8500000.00, 1),
('2025-03-05', 3, 9200000.00, 1),
('2025-03-18', 4, 6700000.00, 2),
('2025-04-02', 5, 15000000.00, 1);

-- =====================
-- DETALLECOMPRA
-- =====================
INSERT INTO DetalleCompra (idCompra, idProducto, Cantidad, PrecioUnitario) VALUES
(1, 1, 3, 3500000.00),
(1, 2, 2, 4500000.00),
(2, 3, 3, 2800000.00),
(3, 4, 2, 4600000.00),
(4, 5, 4, 1600000.00),
(5, 6, 1, 12000000.00),
(2, 7, 2, 3500000.00),
(1, 8, 2, 3800000.00);

-- =====================
-- VENTAS
-- =====================
INSERT INTO Ventas (Fecha, idCliente, idUsuario, Total) VALUES
('2025-05-12', 1, 2, 3800000.00),
('2025-06-03', 2, 2, 4500000.00),
('2025-06-15', 3, 2, 1600000.00),
('2025-07-01', 4, 1, 12000000.00),
('2025-07-20', 5, 2, 2800000.00);

-- =====================
-- DETALLEVENTA
-- =====================
INSERT INTO DetalleVenta (idVenta, idProducto, Cantidad, PrecioUnitario) VALUES
(1, 1, 1, 3800000.00),
(2, 2, 1, 4500000.00),
(3, 5, 1, 1600000.00),
(4, 6, 1, 12000000.00),
(5, 3, 1, 2800000.00);

--AGREGAR UNA IMAGEN POR AUTO
UPDATE Productos SET idImagen = 1 WHERE idProducto = 1;  
UPDATE Productos SET idImagen = 3 WHERE idProducto = 2;
UPDATE Productos SET idImagen = 4 WHERE idProducto = 3; 
UPDATE Productos SET idImagen = 5 WHERE idProducto = 4; 
UPDATE Productos SET idImagen = 6 WHERE idProducto = 5; 
UPDATE Productos SET idImagen = 7 WHERE idProducto = 6;  
UPDATE Productos SET idImagen = 8 WHERE idProducto = 7;  
UPDATE Productos SET idImagen = 2 WHERE idProducto = 8; 