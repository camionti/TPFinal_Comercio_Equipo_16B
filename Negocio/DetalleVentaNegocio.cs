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
                datos.setearConsulta("SELECT DV.IdDetalleVenta, DV.IdVenta, DV.IdProducto, DV.Cantidad, DV.PrecioUnitario, P.Nombre FROM DetalleVenta DV JOIN Productos P ON P.IdProducto = DV.IdProducto WHERE IdVenta = @IdVenta");
                datos.setearParametro("@IdVenta", IdVenta);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    DetalleVenta aux = new DetalleVenta();


                    aux.IdDetalleVenta = (int)datos.Lector["IdDetalleVenta"];
                    aux.IdVenta = (int)datos.Lector["IdVenta"];
                    aux.Producto = new Producto();
                    aux.Producto.IdProducto = (int)datos.Lector["IdProducto"];
                    aux.Producto.Nombre = (string)datos.Lector["Nombre"];
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

        public void Eliminar(int IdVenta)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("DELETE FROM DetalleVenta where IdVenta = @IdVenta");
                datos.setearParametro("@IdVenta", IdVenta);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
