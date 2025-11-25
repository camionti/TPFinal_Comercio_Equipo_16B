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


        public List<DetalleCompra> ListarPorCompra(int idCompra)
        {
            List<DetalleCompra> lista = new List<DetalleCompra>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"SELECT D.IdDetalleCompra, D.Cantidad, D.PrecioUnitario, 
                               P.IdProducto, P.Nombre  
                               FROM DetalleCompra D 
                               INNER JOIN Productos P ON D.IdProducto = P.IdProducto 
                               WHERE D.IdCompra = @id");

                datos.setearParametro("@id", idCompra);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    DetalleCompra d = new DetalleCompra();

                    d.IdDetalleCompra = (int)datos.Lector["IdDetalleCompra"];
                    d.Cantidad = (int)datos.Lector["Cantidad"];
                    d.PrecioUnitario = (decimal)datos.Lector["PrecioUnitario"];
                    d.Producto = new Producto
                    {
                        IdProducto = (int)datos.Lector["IdProducto"],
                        Nombre = datos.Lector["Nombre"].ToString()
                    };

                    lista.Add(d);
                }

                return lista;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

    }
}
