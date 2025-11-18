using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class DetalleCompraNegocio
    {
     
        public void Agregar(DetalleCompra detalle)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("INSERT INTO DetalleCompra (IdCompra, IdProducto, Cantidad, PrecioCompra) VALUES (@IdCompra, @IdProducto, @Cantidad, @PrecioCompra)");
                datos.setearParametro("@IdCompra", detalle.IdCompra);
                datos.setearParametro("@IdProducto", detalle.IdProducto);
                datos.setearParametro("@Cantidad", detalle.Cantidad);
                datos.setearParametro("@PrecioCompra", detalle.PrecioUnitario);
                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
