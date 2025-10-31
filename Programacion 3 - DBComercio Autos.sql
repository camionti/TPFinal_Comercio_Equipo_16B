CREATE DATABASE ComercioDB;
GO
USE ComercioDB;
GO
CREATE TABLE Usuarios (
IdUsuario INT IDENTITY(1,1) PRIMARY KEY,
NombreUsuario VARCHAR(50) NOT NULL,
Contrasenia VARCHAR(50) NOT NULL,
Rol VARCHAR(20) CHECK (Rol IN ('Administrador', 'Vendedor'))
);
GO
CREATE TABLE Clientes (
IdCliente INT IDENTITY(1,1) PRIMARY KEY,
Nombre VARCHAR(100),
Telefono VARCHAR(50),
Email VARCHAR(100)
);
GO
CREATE TABLE Proveedores (
IdProveedor INT IDENTITY(1,1) PRIMARY KEY,
Nombre VARCHAR(100),
Telefono VARCHAR(50),
Email VARCHAR(100)
);
GO
CREATE TABLE Marcas (
IdMarca INT IDENTITY(1,1) PRIMARY KEY,
Nombre VARCHAR(100)
);
GO
CREATE TABLE Categorias (
IdCategoria INT IDENTITY(1,1) PRIMARY KEY,
Descripcion VARCHAR(100)
);
GO
CREATE TABLE Productos (
IdProducto INT IDENTITY(1,1) PRIMARY KEY,
Nombre VARCHAR(100),
IdMarca INT,
IdCategoria INT,
StockActual INT DEFAULT 0,
StockMinimo INT DEFAULT 0,
PorcentajeGanancia DECIMAL(5,2),
Precio MONEY,
FOREIGN KEY (IdMarca) REFERENCES Marcas(IdMarca),
FOREIGN KEY (IdCategoria) REFERENCES Categorias(IdCategoria)
);
GO
CREATE TABLE ProveedoresProductos (
IdProveedor INT,
IdProducto INT,
PRIMARY KEY (IdProveedor, IdProducto),
FOREIGN KEY (IdProveedor) REFERENCES Proveedores(IdProveedor),
FOREIGN KEY (IdProducto) REFERENCES Productos(IdProducto)
);
GO
CREATE TABLE Compras (
IdCompra INT IDENTITY(1,1) PRIMARY KEY,
Fecha DATE,
IdProveedor INT,
FOREIGN KEY (IdProveedor) REFERENCES Proveedores(IdProveedor)
);
GO
CREATE TABLE DetalleCompra (
IdDetalleCompra INT IDENTITY(1,1) PRIMARY KEY,
IdCompra INT,
IdProducto INT,
Cantidad INT,
PrecioCompra DECIMAL(10,2),
FOREIGN KEY (IdCompra) REFERENCES Compras(IdCompra),
FOREIGN KEY (IdProducto) REFERENCES Productos(IdProducto)
);
GO
CREATE TABLE Ventas (
IdVenta INT IDENTITY(1,1) PRIMARY KEY,
Fecha DATE,
IdCliente INT,
IdUsuario INT,
NumeroFactura VARCHAR(50) UNIQUE,
FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente),
FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario)
);
GO
CREATE TABLE DetalleVenta (
IdDetalleVenta INT IDENTITY(1,1) PRIMARY KEY,
IdVenta INT,
IdProducto INT,
Cantidad INT,
PrecioUnitario DECIMAL(10,2),
FOREIGN KEY (IdVenta) REFERENCES Ventas(IdVenta),
FOREIGN KEY (IdProducto) REFERENCES Productos(IdProducto)
);
GO
CREATE TABLE Imagenes(
    IdImagen INT IDENTITY(1,1) PRIMARY KEY,
    IdProducto INT,
    ImagenUrl VARCHAR(1000) NOT NULL,
    FOREIGN KEY (IdProducto) REFERENCES Productos(IdProducto)
)




-- =========================
-- USUARIOS
-- =========================
INSERT INTO Usuarios (NombreUsuario, Contrasenia, Rol) VALUES
('admin',    'admin', 'Administrador'),

-- =========================
-- CLIENTES
-- =========================
INSERT INTO Clientes (Nombre, Telefono, Email) VALUES
('Juan Pérez',       '+54 9 11 5555-0001', 'juan.perez@example.com'),
('María Gómez',      '+54 9 11 5555-0002', 'maria.gomez@example.com'),
('Carlos Rodríguez', '+54 9 11 5555-0003', 'carlos.rodri@example.com'),
('Lucía Fernández',  '+54 9 11 5555-0004', 'lucifer@example.com');

-- =========================
-- PROVEEDORES (terminales / mayoristas)
-- =========================
INSERT INTO Proveedores (Nombre, Telefono, Email) VALUES
('Toyota Argentina S.A.',          '+54 11 4321-1000', 'fleet@toyota.com.ar'),
('Volkswagen Argentina S.A.',      '+54 11 4321-2000', 'ventas@vw.com.ar'),
('Ford Argentina S.A.',            '+54 11 4321-3000', 'comercial@ford.com.ar'),
('General Motors Argentina SRL',   '+54 11 4321-4000', 'ventas@gm.com.ar'),
('Renault Argentina S.A.',         '+54 11 4321-5000', 'clientes@renault.com.ar'),
('Stellantis Argentina S.A.',      '+54 11 4321-6000', 'ventas@stellantis.com'); -- Peugeot/Citroën

-- =========================
-- MARCAS
-- =========================
INSERT INTO Marcas (Nombre) VALUES
('Toyota'),
('Volkswagen'),
('Ford'),
('Chevrolet'),
('Renault'),
('Peugeot');

-- =========================
-- CATEGORÍAS (segmentos)
-- =========================
INSERT INTO Categorias (Descripcion) VALUES
('Sedán'),
('Hatchback'),
('SUV'),
('Pickup'),
('Crossover');

-- =========================
-- PRODUCTOS (Autos como productos)
-- StockActual arranca en 0; luego se ajusta con Compras/Ventas
-- =========================
INSERT INTO Productos (Nombre, IdMarca, IdCategoria, StockActual, StockMinimo, PorcentajeGanancia)
VALUES
('Toyota Corolla XEi 2.0 AT 2023',
    (SELECT IdMarca FROM Marcas WHERE Nombre='Toyota'),
    (SELECT IdCategoria FROM Categorias WHERE Descripcion='Sedán'),
    0, 1, 12.50),
('Volkswagen Polo Highline 1.6 2022',
    (SELECT IdMarca FROM Marcas WHERE Nombre='Volkswagen'),
    (SELECT IdCategoria FROM Categorias WHERE Descripcion='Hatchback'),
    0, 1, 15.00),
('Ford Ranger XLT 3.2 4x4 2021',
    (SELECT IdMarca FROM Marcas WHERE Nombre='Ford'),
    (SELECT IdCategoria FROM Categorias WHERE Descripcion='Pickup'),
    0, 1, 10.00),
('Chevrolet Tracker Premier 1.2T 2024',
    (SELECT IdMarca FROM Marcas WHERE Nombre='Chevrolet'),
    (SELECT IdCategoria FROM Categorias WHERE Descripcion='SUV'),
    0, 1, 14.00),
('Renault Sandero 1.6 2021',
    (SELECT IdMarca FROM Marcas WHERE Nombre='Renault'),
    (SELECT IdCategoria FROM Categorias WHERE Descripcion='Hatchback'),
    0, 1, 13.00),
('Peugeot 208 Active 1.2 2023',
    (SELECT IdMarca FROM Marcas WHERE Nombre='Peugeot'),
    (SELECT IdCategoria FROM Categorias WHERE Descripcion='Hatchback'),
    0, 1, 16.00);

-- =====================================================================
-- SCRIPT DE DATOS - Comercio de AUTOS (modelos reales, AR)
-- Requiere el esquema ya creado (tablas del mensaje anterior)
-- =====================================================================

BEGIN TRAN;

-- =========================
-- USUARIOS
-- =========================
INSERT INTO Usuarios (NombreUsuario, Contrasenia, Rol) VALUES
('admin',    'admin', 'Administrador');

-- =========================
-- CLIENTES
-- =========================
INSERT INTO Clientes (Nombre, Telefono, Email) VALUES
('Juan Pérez',       '+54 9 11 5555-0001', 'juan.perez@example.com'),
('María Gómez',      '+54 9 11 5555-0002', 'maria.gomez@example.com'),
('Carlos Rodríguez', '+54 9 11 5555-0003', 'carlos.rodri@example.com'),
('Lucía Fernández',  '+54 9 11 5555-0004', 'lucia.fer@example.com');

-- =========================
-- PROVEEDORES (terminales / mayoristas)
-- =========================
INSERT INTO Proveedores (Nombre, Telefono, Email) VALUES
('Toyota Argentina S.A.',          '+54 11 4321-1000', 'fleet@toyota.com.ar'),
('Volkswagen Argentina S.A.',      '+54 11 4321-2000', 'ventas@vw.com.ar'),
('Ford Argentina S.A.',            '+54 11 4321-3000', 'comercial@ford.com.ar'),
('General Motors Argentina SRL',   '+54 11 4321-4000', 'ventas@gm.com.ar'),
('Renault Argentina S.A.',         '+54 11 4321-5000', 'clientes@renault.com.ar'),
('Stellantis Argentina S.A.',      '+54 11 4321-6000', 'ventas@stellantis.com'); -- Peugeot/Citroën

-- =========================
-- MARCAS
-- =========================
INSERT INTO Marcas (Nombre) VALUES
('Toyota'),
('Volkswagen'),
('Ford'),
('Chevrolet'),
('Renault'),
('Peugeot');

-- =========================
-- CATEGORÍAS (segmentos)
-- =========================
INSERT INTO Categorias (Descripcion) VALUES
('Sedán'),
('Hatchback'),
('SUV'),
('Pickup'),
('Crossover');

-- =========================
-- PRODUCTOS (Autos como productos)
-- StockActual arranca en 0; luego se ajusta con Compras/Ventas
-- =========================
INSERT INTO Productos (Nombre, IdMarca, IdCategoria, StockActual, StockMinimo, PorcentajeGanancia)
VALUES
('Toyota Corolla XEi 2.0 AT 2023',
    (SELECT IdMarca FROM Marcas WHERE Nombre='Toyota'),
    (SELECT IdCategoria FROM Categorias WHERE Descripcion='Sedán'),
    0, 1, 12.50),
('Volkswagen Polo Highline 1.6 2022',
    (SELECT IdMarca FROM Marcas WHERE Nombre='Volkswagen'),
    (SELECT IdCategoria FROM Categorias WHERE Descripcion='Hatchback'),
    0, 1, 15.00),
('Ford Ranger XLT 3.2 4x4 2021',
    (SELECT IdMarca FROM Marcas WHERE Nombre='Ford'),
    (SELECT IdCategoria FROM Categorias WHERE Descripcion='Pickup'),
    0, 1, 10.00),
('Chevrolet Tracker Premier 1.2T 2024',
    (SELECT IdMarca FROM Marcas WHERE Nombre='Chevrolet'),
    (SELECT IdCategoria FROM Categorias WHERE Descripcion='SUV'),
    0, 1, 14.00),
('Renault Sandero 1.6 2021',
    (SELECT IdMarca FROM Marcas WHERE Nombre='Renault'),
    (SELECT IdCategoria FROM Categorias WHERE Descripcion='Hatchback'),
    0, 1, 13.00),
('Peugeot 208 Active 1.2 2023',
    (SELECT IdMarca FROM Marcas WHERE Nombre='Peugeot'),
    (SELECT IdCategoria FROM Categorias WHERE Descripcion='Hatchback'),
    0, 1, 16.00);

UPDATE Productos SET Precio = 12000 WHERE IdProducto=6

-- =========================
-- PROVEEDORES x PRODUCTOS (quién provee cada modelo)
-- =========================
INSERT INTO ProveedoresProductos (IdProveedor, IdProducto)
SELECT p.IdProveedor, pr.IdProducto FROM Proveedores p JOIN Productos pr
  ON (p.Nombre='Toyota Argentina S.A.' AND pr.Nombre LIKE 'Toyota Corolla%')
UNION ALL
SELECT p.IdProveedor, pr.IdProducto FROM Proveedores p JOIN Productos pr
  ON (p.Nombre='Volkswagen Argentina S.A.' AND pr.Nombre LIKE 'Volkswagen Polo%')
UNION ALL
SELECT p.IdProveedor, pr.IdProducto FROM Proveedores p JOIN Productos pr
  ON (p.Nombre='Ford Argentina S.A.' AND pr.Nombre LIKE 'Ford Ranger%')
UNION ALL
SELECT p.IdProveedor, pr.IdProducto FROM Proveedores p JOIN Productos pr
  ON (p.Nombre='General Motors Argentina SRL' AND pr.Nombre LIKE 'Chevrolet Tracker%')
UNION ALL
SELECT p.IdProveedor, pr.IdProducto FROM Proveedores p JOIN Productos pr
  ON (p.Nombre='Renault Argentina S.A.' AND pr.Nombre LIKE 'Renault Sandero%')
UNION ALL
SELECT p.IdProveedor, pr.IdProducto FROM Proveedores p JOIN Productos pr
  ON (p.Nombre='Stellantis Argentina S.A.' AND pr.Nombre LIKE 'Peugeot 208%');

-- =========================
-- COMPRAS (ingreso de unidades)
-- =========================
INSERT INTO Compras (Fecha, IdProveedor) VALUES
('2025-09-01', (SELECT IdProveedor FROM Proveedores WHERE Nombre='Toyota Argentina S.A.')),
('2025-09-05', (SELECT IdProveedor FROM Proveedores WHERE Nombre='Volkswagen Argentina S.A.')),
('2025-09-10', (SELECT IdProveedor FROM Proveedores WHERE Nombre='Ford Argentina S.A.')),
('2025-09-12', (SELECT IdProveedor FROM Proveedores WHERE Nombre='General Motors Argentina SRL')),
('2025-09-15', (SELECT IdProveedor FROM Proveedores WHERE Nombre='Renault Argentina S.A.')),
('2025-09-18', (SELECT IdProveedor FROM Proveedores WHERE Nombre='Stellantis Argentina S.A.'));

-- Detalle de Compras (precios de compra estimados en ARS)
INSERT INTO DetalleCompra (IdCompra, IdProducto, Cantidad, PrecioCompra) VALUES
-- Compra 1: Toyota
((SELECT IdCompra FROM Compras WHERE Fecha='2025-09-01' AND IdProveedor=(SELECT IdProveedor FROM Proveedores WHERE Nombre='Toyota Argentina S.A.')),
 (SELECT IdProducto FROM Productos WHERE Nombre LIKE 'Toyota Corolla%'), 2, 18000000.00),

-- Compra 2: VW
((SELECT IdCompra FROM Compras WHERE Fecha='2025-09-05' AND IdProveedor=(SELECT IdProveedor FROM Proveedores WHERE Nombre='Volkswagen Argentina S.A.')),
 (SELECT IdProducto FROM Productos WHERE Nombre LIKE 'Volkswagen Polo%'), 3, 13000000.00),

-- Compra 3: Ford
((SELECT IdCompra FROM Compras WHERE Fecha='2025-09-10' AND IdProveedor=(SELECT IdProveedor FROM Proveedores WHERE Nombre='Ford Argentina S.A.')),
 (SELECT IdProducto FROM Productos WHERE Nombre LIKE 'Ford Ranger%'), 1, 25000000.00),

-- Compra 4: Chevrolet
((SELECT IdCompra FROM Compras WHERE Fecha='2025-09-12' AND IdProveedor=(SELECT IdProveedor FROM Proveedores WHERE Nombre='General Motors Argentina SRL')),
 (SELECT IdProducto FROM Productos WHERE Nombre LIKE 'Chevrolet Tracker%'), 2, 21000000.00),

-- Compra 5: Renault
((SELECT IdCompra FROM Compras WHERE Fecha='2025-09-15' AND IdProveedor=(SELECT IdProveedor FROM Proveedores WHERE Nombre='Renault Argentina S.A.')),
 (SELECT IdProducto FROM Productos WHERE Nombre LIKE 'Renault Sandero%'), 2, 10000000.00),

-- Compra 6: Peugeot (Stellantis)
((SELECT IdCompra FROM Compras WHERE Fecha='2025-09-18' AND IdProveedor=(SELECT IdProveedor FROM Proveedores WHERE Nombre='Stellantis Argentina S.A.')),
 (SELECT IdProducto FROM Productos WHERE Nombre LIKE 'Peugeot 208%'), 3, 14000000.00);

-- Ajuste de stock por compras (sumar)
UPDATE p
SET p.StockActual = p.StockActual + ISNULL(dc.TotalComprado,0)
FROM Productos p
LEFT JOIN (
    SELECT IdProducto, SUM(Cantidad) AS TotalComprado
    FROM DetalleCompra
    GROUP BY IdProducto
) dc ON dc.IdProducto = p.IdProducto;

-- =========================
-- VENTAS (salida de unidades)
-- =========================
INSERT INTO Ventas (Fecha, IdCliente, IdUsuario, NumeroFactura) VALUES
('2025-10-01',
    (SELECT IdCliente FROM Clientes WHERE Nombre='Juan Pérez'),
    (SELECT IdUsuario FROM Usuarios WHERE NombreUsuario='meli'),
    'A-0001-00001234'),
('2025-10-05',
    (SELECT IdCliente FROM Clientes WHERE Nombre='María Gómez'),
    (SELECT IdUsuario FROM Usuarios WHERE NombreUsuario='nico'),
    'A-0001-00001235'),
('2025-10-07',
    (SELECT IdCliente FROM Clientes WHERE Nombre='Carlos Rodríguez'),
    (SELECT IdUsuario FROM Usuarios WHERE NombreUsuario='meli'),
    'A-0001-00001236'),
('2025-10-10',
    (SELECT IdCliente FROM Clientes WHERE Nombre='Lucía Fernández'),
    (SELECT IdUsuario FROM Usuarios WHERE NombreUsuario='nico'),
    'A-0001-00001237');

-- Detalle de Ventas (precios de venta estimados en ARS)
INSERT INTO DetalleVenta (IdVenta, IdProducto, Cantidad, PrecioUnitario) VALUES
-- Venta 1: 1 Corolla
((SELECT IdVenta FROM Ventas WHERE NumeroFactura='A-0001-00001234'),
 (SELECT IdProducto FROM Productos WHERE Nombre LIKE 'Toyota Corolla%'), 1, 23000000.00),

-- Venta 2: 1 Polo
((SELECT IdVenta FROM Ventas WHERE NumeroFactura='A-0001-00001235'),
 (SELECT IdProducto FROM Productos WHERE Nombre LIKE 'Volkswagen Polo%'), 1, 16500000.00),

-- Venta 3: 1 Tracker
((SELECT IdVenta FROM Ventas WHERE NumeroFactura='A-0001-00001236'),
 (SELECT IdProducto FROM Productos WHERE Nombre LIKE 'Chevrolet Tracker%'), 1, 25500000.00),

-- Venta 4: 2 unidades de 208
((SELECT IdVenta FROM Ventas WHERE NumeroFactura='A-0001-00001237'),
 (SELECT IdProducto FROM Productos WHERE Nombre LIKE 'Peugeot 208%'), 2, 17500000.00);

-- Ajuste de stock por ventas (restar)
UPDATE p
SET p.StockActual = p.StockActual - ISNULL(dv.TotalVendido,0)
FROM Productos p
LEFT JOIN (
    SELECT IdProducto, SUM(Cantidad) AS TotalVendido
    FROM DetalleVenta
    GROUP BY IdProducto
) dv ON dv.IdProducto = p.IdProducto;


-- =========================
-- Imagenes
-- =========================
insert into Imagenes (IdProducto, ImagenUrl) VALUES 
    (1,'https://acroadtrip.blob.core.windows.net/catalogo-imagenes/s/RT_V_5f198c2718fb4374894a07d61d75e053.webp' ),
    (1,'https://www.podersa.com.ar/plantilla/assets/vehiculos2/COROLLA.jpg' ),
    (2,'https://www.alravw.com/files/modelos/1726497141_polotrack-1.png' ),
    (2,'https://www.alravw.com/files/modelos/1726497074_polomsi-1.png' ),
    (3,'https://www.ford.com.ar/content/dam/Ford/website-assets/latam/ar/nameplate/Nueva-ranger/2023/models/xlt-4x4/colorizer/blanco-oxford/far-nueva-ranger-color-xlt-4x4-blanco-oxford.jpg.dam.full.high.jpg/1687455611914.jpg' ),
    (3,'https://www.ford.com.ar/content/dam/Ford/website-assets/latam/ar/nameplate/Nueva-ranger/2023/models/xlt-4x2/colorizer/azul-belice/far-nueva-ranger-color-xlt-4x2-azul-belice.jpg.dam.full.high.jpg/1687455572485.jpg' ),
    (4,'https://www.carone.com.ar/wp-content/uploads/2021/09/che-tracker-2021.png' ),
    (4,'https://acroadtrip.blob.core.windows.net/catalogo-imagenes/xl/RT_V_5c588c88124a40df8564e369a4a3f84c.webp' ),
    (5,'https://www.carone.com.ar/wp-content/uploads/2021/12/renault-2022-sandero-intens-blanco.png' ),
    (5,'https://www.carone.com.ar/wp-content/uploads/2021/12/renault-2022-sandero-intens-negro.png' ),
    (6,'https://f.fcdn.app/imgs/6b7f14/motorlider.com.uy/motouy/8b16/original/blog/226/760x0/208-frente.jpeg' ),
    (6,'https://f.fcdn.app/imgs/88d789/motorlider.com.uy/motouy/9aa3/original/wysiwyg/1/1280x0/1-208-trasero.jpeg' ),
    (6,'https://centralpeugeot.dexst.com.ar/wp-content/uploads/2024/10/Peugeot-208-Active-negro-perla.png' )