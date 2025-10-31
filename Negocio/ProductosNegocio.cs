using Dominio;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.Net.Mime.MediaTypeNames;

namespace Negocio
{
    public class ProductosNegocio
    {
        public List<Producto> Listar()
        {
            List<Producto> lista = new List<Producto>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT P.IdProducto, P.Nombre, P.IdMarca, P.IdCategoria, P.Precio, P.StockActual, P.StockMinimo, P.PorcentajeGanancia, C.Descripcion Categoria, M.Nombre Marca FROM Productos P LEFT JOIN Categorias C on C.IdCategoria = P.IdCategoria LEFT JOIN Marcas M ON M.IdMarca = P.IdMarca LEFT JOIN Imagenes I ON I.IdProducto = P.IdProducto;");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    int id = (int)datos.Lector["IdProducto"];
                    Producto aux = lista.Find(producto => producto.IdProducto == id);


                    if (aux == null)
                    {
                        aux = new Producto();
                        aux.IdProducto = (int)datos.Lector["IdProducto"];
                        aux.Nombre = (string)datos.Lector["Nombre"];
                        aux.Precio = (decimal)datos.Lector["Precio"];
                        aux.Categoria = new Categoria();
                        aux.Categoria.IdCategoria = (int)datos.Lector["IdCategoria"];
                        aux.Categoria.Descripcion = (string)datos.Lector["Categoria"];
                        aux.Marca = new Dominio.Marca();
                        aux.Marca.IdMarca = (int)datos.Lector["IdMarca"];
                        aux.Marca.Nombre = (string)datos.Lector["Marca"];
                        aux.StockActual = (int)datos.Lector["StockActual"];
                        aux.StockMinimo = (int)datos.Lector["StockMinimo"];
                        aux.PorcentajeGanancia = (decimal)datos.Lector["PorcentajeGanancia"];


                        lista.Add(aux);

                    }




                }

                return lista;
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

        public List<Producto> buscar(string nombre = null, int? IdMarca = null, int? IdCategoria = null, decimal? precioMinimo = null, decimal? precioMaximo = null)
        {

            List<Producto> productos = new List<Producto>();

            AccesoDatos datos = new AccesoDatos();

            string consulta = "SELECT * FROM Productos WHERE 1=1";

            try
            {
                datos.setearConsulta("SELECT P.IdProducto, P.Nombre, P.IdMarca, P.IdCategoria, C.Descripcion Categoria, M.Nombre Marca " +
                                     "From Productos P" +
                                     "LEFT JOIN Categorias C ON C.IdCategoria = P.IdCategoria " +
                                     "LEFT JOIN Marcas M ON M.IdMarca = P.IdMarca " +
                                     "WHERE 1=1");

                if (!string.IsNullOrEmpty(nombre))
                    consulta += " AND Nombre LIKE @nombre";
                if (IdMarca != null)
                    consulta += " AND IdMarca = @IdMarca";
                if (IdCategoria != null)
                    consulta += " AND IdCategoria = @IdCategoria";
                if (precioMinimo != null)
                    consulta += " AND Precio >= @precioMinimo";
                if (precioMaximo != null)
                    consulta += " AND Precio <= @precioMaximo";

                datos.setearConsulta(consulta);

                if (!string.IsNullOrEmpty(nombre))
                    datos.setearParametro("@Nombre", "%" + nombre + "%");
                if (IdMarca != null)
                    datos.setearParametro("@IdMarca", IdMarca);
                if (IdCategoria != null)
                    datos.setearParametro("@IdCategoria", IdCategoria);
                if (precioMinimo != null)
                    datos.setearParametro("@precioMinimo", precioMinimo);
                if (precioMaximo != null)
                    datos.setearParametro("@precioMaximo", precioMaximo);

                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    int id = (int)datos.Lector["Id"];
                    Producto aux = productos.Find(a => a.IdProducto == id);

                    if (aux == null)
                    {
                        aux = new Producto();
                        aux.IdProducto = id;
                        aux.Nombre = (string)datos.Lector["Nombre"];

                        aux.Precio = (decimal)datos.Lector["Precio"];
                        aux.Marca = new Dominio.Marca { Nombre = (string)datos.Lector["Marca"] };
                        aux.Categoria = new Categoria { Descripcion = (string)datos.Lector["Categoria"] };

                        aux.Imagenes = new List<Imagen>();

                        productos.Add(aux);
                    }

                }

                return productos;
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

        public void agregar(Producto nuevo)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {

                datos.setearConsulta("INSERT INTO Productos (Nombre, IdMarca, IdCategoria, StockActual, StockMinimo, PorcentajeGanancia, Precio) " +
                    "VALUES (@Nombre, @IdMarca, @IdCategoria, @StockActual, @StockMinimo, @PorcentajeGanancia, @Precio)");

                datos.setearParametro("@Nombre", nuevo.Nombre);
                datos.setearParametro("@IdMarca", nuevo.Marca.IdMarca);
                datos.setearParametro("@IdCategoria", nuevo.Categoria.IdCategoria);
                datos.setearParametro("@StockActual", nuevo.StockActual);
                datos.setearParametro("@StockMinimo", nuevo.StockMinimo);
                datos.setearParametro("@PorcentajeGanancia", nuevo.PorcentajeGanancia);
                datos.setearParametro("@Precio", nuevo.Precio);
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

        public void modificar(Producto producto)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("UPDATE Productos SET Nombre = @Nombre, IdMarca = @IdMarca, IdCategoria = @IdCategoria, StockActual = @StockActual, StockMinimo = @StockMinimo, PorcentajeGanancia = @PorcentajeGanancia, Precio = @Precio");

                datos.setearParametro("@Nombre", producto.Nombre);
                datos.setearParametro("@IdMarca", producto.Marca.IdMarca);
                datos.setearParametro("@IdCategoria", producto.Categoria.IdCategoria);
                datos.setearParametro("@StockActual", producto.StockActual);
                datos.setearParametro("@StockMinimo", producto.StockMinimo);
                datos.setearParametro("@PorcentajeGanancia", producto.PorcentajeGanancia);
                datos.setearParametro("@Precio", producto.Precio);
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

        public void eliminar(int IdProducto)
        {
            try
            {
                AccesoDatos datos = new AccesoDatos();
                datos.setearConsulta("DELETE FROM Productos where IdProducto = @IdProducto");
                datos.setearParametro("@IdProducto", IdProducto);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


    }
}
