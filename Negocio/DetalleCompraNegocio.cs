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
        public List<DetalleCompra> ListarPorCompra(int idCompra)
        {
            List<DetalleCompra> lista = new List<DetalleCompra>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT IdDetalleCompra, IdCompra, IdProducto, Cantidad, PrecioCompra FROM DetalleCompra WHERE IdCompra = @IdCompra");
                datos.setearParametro("@IdCompra", idCompra);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    DetalleCompra aux = new DetalleCompra();
                    aux.IdDetalleCompra = (int)datos.Lector["IdDetalleCompra"];
                    aux.IdCompra = (int)datos.Lector["IdCompra"];
                    aux.IdProducto = (int)datos.Lector["IdProducto"];
                    aux.Cantidad = (int)datos.Lector["Cantidad"];
                    aux.PrecioCompra = (decimal)datos.Lector["PrecioCompra"];
                    lista.Add(aux);
                }

                return lista;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void Agregar(DetalleCompra detalle)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("INSERT INTO DetalleCompra (IdCompra, IdProducto, Cantidad, PrecioCompra) VALUES (@IdCompra, @IdProducto, @Cantidad, @PrecioCompra)");
                datos.setearParametro("@IdCompra", detalle.IdCompra);
                datos.setearParametro("@IdProducto", detalle.IdProducto);
                datos.setearParametro("@Cantidad", detalle.Cantidad);
                datos.setearParametro("@PrecioCompra", detalle.PrecioCompra);
                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
