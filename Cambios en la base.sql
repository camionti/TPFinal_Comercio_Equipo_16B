--ARREGLOS EN LA BASE DE DATOS TP FINAL--

USE ComercioDB
GO

--PRODUCTOS--
ALTER TABLE Productos
DROP CONSTRAINT FK_ProductosidIma_45F365D3;

ALTER TABLE Productos
DROP COLUMN IdImagen;

ALTER TABLE Productos
ADD Precio INT

UPDATE Productos SET Precio = 14000000 WHERE IdProducto = 1
UPDATE Productos SET Precio = 18000000 WHERE IdProducto = 2
UPDATE Productos SET Precio = 20000000 WHERE IdProducto = 3
UPDATE Productos SET Precio = 17950000 WHERE IdProducto = 3
UPDATE Productos SET Precio = 16500000 WHERE IdProducto = 5
UPDATE Productos SET Precio = 22250000 WHERE IdProducto = 6
UPDATE Productos SET Precio = 9500000 WHERE IdProducto = 7
UPDATE Productos SET Precio = 18250000 WHERE IdProducto = 8


--NOMBRES DE TABLAS--
EXEC sp_rename 'Usuarios.Nombre', 'NombreUsuario', 'COLUMN';
EXEC sp_rename 'Usuarios.idUsuarios', 'IdUsuario', 'COLUMN';
EXEC sp_rename 'Categorias.idCategoria', 'IdCategoria', 'COLUMN';
EXEC sp_rename 'Marcas.idMarca', 'IdMarca', 'COLUMN';
EXEC sp_rename 'Clientes.idCliente', 'IdCliente', 'COLUMN';
EXEC sp_rename 'Proveedores.idProveedor', 'IdProveedor', 'COLUMN';
EXEC sp_rename 'Imagenes.idImagen', 'IdImagen', 'COLUMN';
EXEC sp_rename 'Imagenes.idProducto', 'IdProducto', 'COLUMN';
EXEC sp_rename 'Productos.idProducto', 'IdProducto', 'COLUMN';
EXEC sp_rename 'Productos.idMarca', 'IdMarca', 'COLUMN';
EXEC sp_rename 'Productos.idCategoria', 'IdCategoria', 'COLUMN';
EXEC sp_rename 'Productos.idProveedoresProductos', 'IdProveedor', 'COLUMN';
EXEC sp_rename 'Productos.idImagen', 'IdImagen', 'COLUMN';
EXEC sp_rename 'ProveedoresProductos.idProveedor', 'IdProveedor', 'COLUMN';
EXEC sp_rename 'ProveedoresProductos.idProducto', 'IdProducto', 'COLUMN';
EXEC sp_rename 'Compras.idCompra', 'IdCompra', 'COLUMN';
EXEC sp_rename 'Compras.idProveedor', 'IdProveedor', 'COLUMN';
EXEC sp_rename 'Compras.idUsuario', 'IdUsuario', 'COLUMN';
EXEC sp_rename 'DetalleCompra.idDetalleCompra', 'IdDetalleCompra', 'COLUMN';
EXEC sp_rename 'DetalleCompra.idCompra', 'IdCompra', 'COLUMN';
EXEC sp_rename 'DetalleCompra.idProducto', 'IdProducto', 'COLUMN';
EXEC sp_rename 'Ventas.idVenta', 'IdVenta', 'COLUMN';
EXEC sp_rename 'Ventas.idCliente', 'IdCliente', 'COLUMN';
EXEC sp_rename 'Ventas.idUsuario', 'IdUsuario', 'COLUMN';
EXEC sp_rename 'DetalleVenta.idDetalleVenta', 'IdDetalleVenta', 'COLUMN';
EXEC sp_rename 'DetalleVenta.idVenta', 'IdVenta', 'COLUMN';
EXEC sp_rename 'DetalleVenta.idProducto', 'IdProducto', 'COLUMN';

--AGREGAR UNA TABLA PARA BAJA LOGICA--

ALTER TABLE Proveedores ADD Activo BIT NOT NULL DEFAULT 1;
ALTER TABLE Marcas ADD Activo BIT NOT NULL DEFAULT 1;
ALTER TABLE Clientes ADD Activo BIT NOT NULL DEFAULT 1;
ALTER TABLE Categorias ADD Activo BIT NOT NULL DEFAULT 1;



--MOTIVO DE BAJA COMPRAS--
ALTER TABLE DetalleCompra
ADD MotivoBaja NVARCHAR(255) NULL;
ALTER TABLE Compras ADD Activo BIT NOT NULL DEFAULT 1;
ALTER TABLE DetalleCompra ADD Activo BIT NOT NULL DEFAULT 1;