using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class CompraNegocio
    {
        public void AgregarCompra(Compra compra)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                // VALIDACIONES
                if (compra.Proveedor == null || compra.Proveedor.IdProveedor <= 0)
                    throw new Exception("Debe seleccionar un proveedor.");

                if (compra.Detalles == null || compra.Detalles.Count == 0)
                    throw new Exception("La compra debe tener al menos un detalle.");

                foreach (var d in compra.Detalles)
                {
                    if (d.Cantidad <= 0)
                        throw new Exception("La cantidad debe ser mayor a cero.");
                    if (d.PrecioUnitario <= 0)
                        throw new Exception("El precio unitario debe ser mayor a cero.");
                }

                // INSERTA COMPRA Y OBTIENE ID
                datos.setearConsulta(
                    "INSERT INTO Compras (Fecha, IdProveedor, Total, IdUsuario) " +
                    "OUTPUT INSERTED.IdCompra VALUES (@Fecha, @IdProveedor, 0, @IdUsuario)"
                );

                datos.setearParametro("@Fecha", compra.Fecha);
                datos.setearParametro("@IdProveedor", compra.Proveedor.IdProveedor);
                datos.setearParametro("@IdUsuario", compra.IdUsuario);

                int idCompra = (int)datos.ejecutarScalar();

                decimal totalCompra = 0;

                //  DETALLE
                foreach (var detalle in compra.Detalles)
                {
                    // INSERTA DETALLE
                    datos.setearConsulta(
                        @"INSERT INTO DetalleCompra (IdCompra, IdProducto, Cantidad, PrecioUnitario) 
                  VALUES (@IdCompra, @IdProducto, @Cantidad, @PrecioUnitario)"
                    );

                    datos.setearParametro("@IdCompra", idCompra);
                    datos.setearParametro("@IdProducto", detalle.Producto.IdProducto);
                    datos.setearParametro("@Cantidad", detalle.Cantidad);
                    datos.setearParametro("@PrecioUnitario", detalle.PrecioUnitario);

                    datos.ejecutarAccion();

                    // CALCULA TOTAL
                    totalCompra += detalle.Cantidad * detalle.PrecioUnitario;

                    // ACTUALIZA STOCK
                    datos.setearConsulta(
                        @"UPDATE Productos
                  SET StockActual = StockActual + @Cantidad
                  WHERE IdProducto = @IdProducto"
                    );

                    datos.setearParametro("@Cantidad", detalle.Cantidad);
                    datos.setearParametro("@IdProducto", detalle.Producto.IdProducto);

                    datos.ejecutarAccion();
                }

                // ACTUALIZA TOTAL DE LA COMPRA
                datos.setearConsulta(
                    "UPDATE Compras SET Total = @Total WHERE IdCompra = @IdCompra"
                );

                datos.setearParametro("@Total", totalCompra);
                datos.setearParametro("@IdCompra", idCompra);

                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
