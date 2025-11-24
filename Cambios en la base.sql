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
--Nuevo
ALTER TABLE Productos ADD Activo BIT NOT NULL DEFAULT 1;
ALTER TABLE Usuarios ADD Activo BIT NOT NULL DEFAULT 1;
ALTER TABLE Ventas ADD Activo BIT NOT NULL DEFAULT 1;
ALTER TABLE DetalleVenta ADD Activo BIT NOT NULL DEFAULT 1;
ALTER TABLE Imagenes ADD Activo BIT NOT NULL DEFAULT 1;



--MOTIVO DE BAJA COMPRAS--
ALTER TABLE DetalleCompra
ADD MotivoBaja NVARCHAR(255) NULL;
ALTER TABLE Compras ADD Activo BIT NOT NULL DEFAULT 1;
ALTER TABLE DetalleCompra ADD Activo BIT NOT NULL DEFAULT 1;
GO


--Baja productos
CREATE TRIGGER TR_BAJA_PRODUCTO ON Productos
INSTEAD OF DELETE
AS
BEGIN
    BEGIN TRY
        DECLARE @IDProducto INT;

        SELECT @IDProducto = IdProducto FROM Deleted

        IF EXISTS( SELECT 1 FROM Productos WHERE IdProducto = @IDProducto AND Activo = 0 )
            THROW 50021, 'El producto ya fue dado de baja', 1

        UPDATE Productos SET Activo = 0 WHERE IdProducto = @IDProducto
        IF @@ROWCOUNT = 0
            THROW 50021, 'Error al dar de baja al producto', 1;
    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END

GO
--Baja usuarios
CREATE TRIGGER TR_BAJA_USUARIOS ON Usuarios
INSTEAD OF DELETE
AS
BEGIN
    BEGIN TRY
        DECLARE @IDUsuario INT;

        SELECT @IDUsuario = IdUsuario FROM Deleted

        IF EXISTS( SELECT 1 FROM Usuarios WHERE IdUsuario = @IDUsuario AND Activo = 0 )
            THROW 50021, 'El usuario ya fue dado de baja', 1

        UPDATE Usuarios SET Activo = 0 WHERE IdUsuario = @IDUsuario
        IF @@ROWCOUNT = 0
            THROW 50021, 'Error al dar de baja al usuario', 1;
    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END

GO
--Baja ventas
CREATE TRIGGER TR_BAJA_VENTAS ON Ventas
INSTEAD OF DELETE
AS
BEGIN
    BEGIN TRY
        DECLARE @IDVenta INT;

        SELECT @IDVenta = IdVenta FROM Deleted

        IF EXISTS( SELECT 1 FROM Ventas WHERE IdVenta = @IDVenta AND Activo = 0 )
            THROW 50021, 'La venta ya fue dada de baja', 1

        UPDATE Ventas SET Activo = 0 WHERE IdVenta = @IDVenta
        IF @@ROWCOUNT = 0
            THROW 50021, 'Error al dar de baja la venta', 1;

        UPDATE DetalleVenta SET Activo = 0 WHERE IdVenta = @IDVenta;

    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END

GO
--Baja imagenes
CREATE TRIGGER TR_BAJA_IMAGENES ON Imagenes
INSTEAD OF DELETE
AS
BEGIN
    BEGIN TRY
        DECLARE @IdImagen INT;

        SELECT @IdImagen = IdImagen FROM Deleted

        IF EXISTS( SELECT 1 FROM Imagenes WHERE IdImagen = @IdImagen AND Activo = 0 )
            THROW 50021, 'La imagen ya fue dada de baja', 1

        UPDATE Imagenes SET Activo = 0 WHERE IdImagen = @IdImagen
        IF @@ROWCOUNT = 0
            THROW 50021, 'Error al dar de baja la imagen', 1;
    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END
-- Tipo de tabla para enviar a sp_Ventas_Crear
-- Representa el detalle de una venta (lista de productos, cantidades y precios)
-- Se usa para que el procedure pueda obtener una lista de DetallesVenta
GO
CREATE TYPE dbo.TipoDetalleVenta AS TABLE
(
    IdProducto     INT             NOT NULL,
    Cantidad       INT             NOT NULL,
    PrecioUnitario DECIMAL(10, 2)  NOT NULL
);
GO
CREATE PROCEDURE dbo.sp_Ventas_Crear
(
    @IdCliente INT,
    @IdUsuario INT,
    @Fecha     DATETIME = NULL,
    @Detalles  dbo.TipoDetalleVenta READONLY
)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    IF @Fecha IS NULL
        SET @Fecha = GETDATE();
    DECLARE @IdVenta INT;
    BEGIN TRY
        BEGIN TRAN;

        IF NOT EXISTS (SELECT 1 FROM @Detalles)
            THROW 50001, 'La venta debe tener al menos un producto en el detalle.', 1;

        IF EXISTS (SELECT 1 FROM @Detalles WHERE Cantidad <= 0 OR PrecioUnitario <= 0)
            THROW 50002, 'Cantidad y precio unitario deben ser mayores a cero.', 1;

        IF NOT EXISTS (SELECT 1 FROM dbo.Clientes WHERE IdCliente = @IdCliente AND Activo = 1)
            THROW 50003, 'El cliente no existe o está inactivo.', 1;

        IF NOT EXISTS (SELECT 1 FROM dbo.Usuarios WHERE IdUsuario = @IdUsuario)
            THROW 50004, 'El usuario que registra la venta no existe.', 1;

        IF EXISTS (
            SELECT d.IdProducto
            FROM @Detalles d
            LEFT JOIN dbo.Productos p ON p.IdProducto = d.IdProducto
            WHERE p.IdProducto IS NULL OR p.Activo = 0
        )
            THROW 50005, 'Hay productos inexistentes o inactivos en el detalle.', 1;

        IF EXISTS (
            SELECT IdProducto
            FROM @Detalles
            GROUP BY IdProducto
            HAVING COUNT(*) > 1
        )
            THROW 50006, 'Hay productos repetidos en el detalle de la venta.', 1;

        IF EXISTS (
            SELECT 1
            FROM (
                SELECT IdProducto,
                    SUM(Cantidad) AS CantidadTotal
                FROM @Detalles
                GROUP BY IdProducto
            ) DetalleAgrupado
            JOIN dbo.Productos p ON p.IdProducto = DetalleAgrupado.IdProducto
            WHERE DetalleAgrupado.CantidadTotal > p.StockActual
        )
            THROW 50007, 'No hay stock suficiente para uno o más productos.', 1;

        DECLARE @Total DECIMAL(10, 2);

        SELECT @Total = SUM(d.Cantidad * d.PrecioUnitario)
        FROM @Detalles d;

        INSERT INTO dbo.Ventas (Fecha, IdCliente, IdUsuario, Total, Activo)
        VALUES (@Fecha, @IdCliente, @IdUsuario, @Total, 1);

        SET @IdVenta = SCOPE_IDENTITY();

        INSERT INTO dbo.DetalleVenta (IdVenta, IdProducto, Cantidad, PrecioUnitario, Activo)
        SELECT @IdVenta,
               d.IdProducto,
               d.Cantidad,
               d.PrecioUnitario,
               1
        FROM @Detalles d;

        ;WITH DetalleAgrupado AS
        (
            SELECT IdProducto,
                   SUM(Cantidad) AS CantidadTotal
            FROM @Detalles
            GROUP BY IdProducto
        )
        UPDATE p
            SET p.StockActual = p.StockActual - da.CantidadTotal
        FROM dbo.Productos p
        JOIN DetalleAgrupado da ON da.IdProducto = p.IdProducto;

        IF EXISTS (SELECT 1 FROM dbo.Productos WHERE StockActual < 0)
            THROW 50008, 'El stock de uno o más productos quedó negativo.', 1;

        COMMIT TRAN;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;

        THROW;
    END CATCH;
END;
GO
