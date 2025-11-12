--BASE DE DATOS TP PROGRAMACION FINAL--

CREATE DATABASE ComercioDB;
GO
USE ComercioDB;
GO

--categorias--
CREATE TABLE Categorias (
    idCategoria INT IDENTITY(1,1) PRIMARY KEY,
    Descripcion VARCHAR(200) NOT NULL,
);

--marcas--
CREATE TABLE Marcas (
    idMarca INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50)NOT NULL,
);

--Clientes---
CREATE TABLE Clientes
(
    idCliente INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(255)NOT NULL,
    Telefono VARCHAR(255),
    Email VARCHAR(255)
);

--Proveedores--
CREATE TABLE Proveedores (
    idProveedor INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(255)NOT NULL,
    Telefono INT,
    Email VARCHAR(255)
);

--Usuarios--
CREATE TABLE Usuarios (
    idUsuarios INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(255)NOT NULL,
    Contrasenia VARCHAR(255)NOT NULL,
    Rol INT NOT NULL,
);

--imagenes--
CREATE TABLE Imagenes (
    idImagen INT IDENTITY(1,1) PRIMARY KEY,
    ImagenUrl VARCHAR(255),
    idProducto INT
);

--Productos--

CREATE TABLE Productos (
    idProducto INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(255)NOT NULL,
    idMarca INT NOT NULL,
    idCategoria INT,
    stockActual INT,
    stockMinimo INT,
    PorcentajeGanancia DECIMAL(10,2) NOT NULL,
    idProveedoresProductos INT, 
    idImagen INT NULL,

    FOREIGN KEY (idMarca) REFERENCES Marcas(idMarca),
    FOREIGN KEY (idCategoria) REFERENCES Categorias(idCategoria),
    FOREIGN KEY (idProveedoresProductos) REFERENCES Proveedores(idProveedor),
    FOREIGN KEY (idImagen) REFERENCES Imagenes(idImagen)
);

--ProveedoresProductos--
CREATE TABLE ProveedoresProductos (
    idProveedor INT,
    idProducto INT,
    PRIMARY KEY (idProveedor, idProducto),
    FOREIGN KEY (idProveedor) REFERENCES Proveedores(idProveedor),
    FOREIGN KEY (idProducto) REFERENCES Productos(idProducto)
);

--compras--

CREATE TABLE Compras (
    idCompra INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATE,
    idProveedor INT,
    Total DECIMAL(10,2),
    idUsuario INT,

    FOREIGN KEY (idProveedor) REFERENCES Proveedores(idProveedor),
    FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuarios)
);

--DetalleCompra--

CREATE TABLE DetalleCompra (
    idDetalleCompra INT IDENTITY(1,1) PRIMARY KEY,
    idCompra INT,
    idProducto INT,
    Cantidad INT,
    PrecioUnitario DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (idCompra) REFERENCES Compras(idCompra),
    FOREIGN KEY (idProducto) REFERENCES Productos(idProducto)
);

--Venta--

CREATE TABLE Ventas (
    idVenta INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATE,
    idCliente INT,
    idUsuario INT,
    Total DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente),
    FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuarios)
);

--Detalle Venta--

CREATE TABLE DetalleVenta (
    idDetalleVenta INT IDENTITY(1,1) PRIMARY KEY,
    idVenta INT,
    idProducto INT,
    Cantidad INT,
    PrecioUnitario DECIMAL(10,2),

    FOREIGN KEY (idVenta) REFERENCES Ventas(idVenta),
    FOREIGN KEY (idProducto) REFERENCES Productos(idProducto)
);