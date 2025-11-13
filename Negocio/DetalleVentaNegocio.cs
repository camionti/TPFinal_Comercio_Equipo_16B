using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class DetalleVentaNegocio
    {
        public List<DetalleVenta> ListarPorVenta(int IdVenta)
        {
            List<DetalleVenta> lista = new List<DetalleVenta>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT IdDetalleVenta, IdVenta, IdProducto, Cantidad, PrecioUnitario FROM DetalleVenta WHERE IdVenta = @IdVenta");
                datos.setearParametro("@IdVenta", IdVenta);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    DetalleVenta aux = new DetalleVenta();


                    aux.IdDetalleVenta = (int)datos.Lector["IdDetalleVenta"];
                    aux.IdVenta = (int)datos.Lector["IdVenta"];
                    aux.Producto.IdProducto = (int)datos.Lector["IdProducto"];
                    aux.Cantidad = (int)datos.Lector["Cantidad"];
                    aux.PrecioUnitario = (decimal)datos.Lector["PrecioUnitario"];
                    lista.Add(aux);
                }

                return lista;
            } catch (Exception)
            {
                throw;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void Agregar(DetalleVenta detalle)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("INSERT INTO DetalleVenta (IdVenta, IdProducto, Cantidad, PrecioUnitario) VALUES (@IdVenta, @IdProducto, @Cantidad, @PrecioUnitario)");
                datos.setearParametro("@IdVenta", detalle.IdVenta);
                datos.setearParametro("@IdProducto", detalle.Producto.IdProducto);
                datos.setearParametro("@Cantidad", detalle.Cantidad);
                datos.setearParametro("@PrecioUnitario", detalle.PrecioUnitario);
                datos.ejecutarAccion();
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
