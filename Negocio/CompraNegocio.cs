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
                //INSERTA LA COMPRA
                datos.setearConsulta("INSERT INTO Compras (Fecha, IdProveedor) OUTPUT INSERTED.IdCompra VALUES (@Fecha, @IdProveedor)");
                datos.setearParametro("@Fecha", compra.Fecha);
                datos.setearParametro("@IdProveedor", compra.Proveedor.IdProveedor);

                int idCompra = (int)datos.ejecutarScalar();

                //INSRTA LOS DETALLES
                foreach (var detalle in compra.Detalles)
                {
                    datos.setearConsulta(@"INSERT INTO DetalleCompra (IdCompra, IdProducto, Cantidad, PrecioUnitario) 
                                            VALUES (@IdCompra, @IdProducto, @Cantidad, @PrecioUnitario)");
                    datos.setearParametro("@IdCompra", idCompra);
                    datos.setearParametro("@IdProducto", detalle.Producto.IdProducto);
                    datos.setearParametro("@Cantidad", detalle.Cantidad);
                    datos.setearParametro("@PrecioUnitario", detalle.PrecioUnitario);
                    datos.ejecutarAccion();

                    //ACTUALIZA STOCK
                    datos.setearConsulta(@"UPDATE Productos 
                                           SET StockActual = StockActual + @Cantidad,
                                           WHERE IdProducto = @IdProducto");
                    datos.setearParametro("@Cantidad", detalle.Cantidad);
                    datos.setearParametro("@IdProducto", detalle.Producto.IdProducto);
                    datos.ejecutarAccion();
                }
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
