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
        public List<Producto> Listar(bool? estado = null)
        {
            List<Producto> lista = new List<Producto>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                string consulta = @"SELECT P.IdProducto, P.Nombre, P.IdMarca, P.IdCategoria, P.StockActual, P.StockMinimo, P.Precio, P.PorcentajeGanancia, P.Activo, C.Descripcion Categoria, M.Nombre Marca FROM Productos P LEFT JOIN Categorias C on C.IdCategoria = P.IdCategoria LEFT JOIN Marcas M ON M.IdMarca = P.IdMarca LEFT JOIN Imagenes I ON I.IdProducto = P.IdProducto WHERE 1 = 1 ";

                if (estado == true)
                    consulta += " AND P.Activo = 1";

                if (estado == false)
                    consulta += " AND P.Activo = 0";

                datos.setearConsulta(consulta);
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
                        aux.Precio = (int)datos.Lector["Precio"];
                        aux.Categoria = new Categoria();
                        aux.Categoria.IdCategoria = (int)datos.Lector["IdCategoria"];
                        aux.Categoria.Descripcion = (string)datos.Lector["Categoria"];
                        aux.Marca = new Dominio.Marca();
                        aux.Marca.IdMarca = (int)datos.Lector["IdMarca"];
                        aux.Marca.Nombre = (string)datos.Lector["Marca"];
                        aux.StockActual = (int)datos.Lector["StockActual"];
                        aux.StockMinimo = (int)datos.Lector["StockMinimo"];
                        aux.PorcentajeGanancia = (decimal)datos.Lector["PorcentajeGanancia"];
                        aux.Activo = (bool)datos.Lector["Activo"];



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

        public List<Producto> BuscarPorProveedor(int IdProveedor)
        {
            List<Producto> productos = new List<Producto>();

            AccesoDatos datos = new AccesoDatos();

            try
            {
                string consulta = "SELECT IdProducto, Nombre, StockActual, StockMinimo, PorcentajeGanancia, Precio, Activo FROM Productos WHERE IdProveedor = @IdProveedor";
                datos.setearConsulta(consulta);
                datos.setearParametro("@IdProveedor", IdProveedor);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    int id = (int)datos.Lector["IdProducto"];
                    Producto aux = productos.Find(a => a.IdProducto == id);

                    if (aux == null)
                    {
                        aux = new Producto();
                        aux.IdProducto = (int)datos.Lector["IdProducto"]; ;
                        aux.Nombre = (string)datos.Lector["Nombre"];
                        aux.StockActual = (int)datos.Lector["StockActual"];
                        aux.StockMinimo = (int)datos.Lector["StockMinimo"];
                        aux.PorcentajeGanancia = (decimal)datos.Lector["PorcentajeGanancia"];
                        aux.Precio = (int)datos.Lector["Precio"];
                        aux.Activo = (bool)datos.Lector["Activo"];
                        productos.Add(aux);
                    }

                }

                return productos;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public List<Producto> buscar(int IdProducto = 0, string nombreMarcaCategoria = null, decimal? precioMinimo = null, decimal? precioMaximo = null)
        {

            List<Producto> productos = new List<Producto>();

            AccesoDatos datos = new AccesoDatos();

            string consulta = "SELECT P.IdProducto, P.Nombre, P.IdMarca, P.IdCategoria, P.StockActual, P.StockMinimo, P.PorcentajeGanancia, P.Precio, P.Activo, " +
                                     " C.Descripcion Categoria, M.Nombre Marca" +
                                     " From Productos P" +
                                     " LEFT JOIN Categorias C ON C.IdCategoria = P.IdCategoria" +
                                     " LEFT JOIN Marcas M ON M.IdMarca = P.IdMarca" +
                                     " WHERE 1=1 AND P.Activo = 1 ";
            try
            {

                if (IdProducto > 0)
                    consulta += " AND P.IdProducto = @IdProducto";
                if (!string.IsNullOrWhiteSpace(nombreMarcaCategoria))
                    consulta += " AND (P.Nombre LIKE @nombreMarcaCategoria OR C.Descripcion LIKE @nombreMarcaCategoria OR M.Nombre LIKE @nombreMarcaCategoria)";
                if (precioMinimo != null)
                    consulta += " AND P.Precio >= @precioMinimo";
                if (precioMaximo != null)
                    consulta += " AND P.Precio <= @precioMaximo";

                datos.setearConsulta(consulta);

                if (IdProducto > 0)
                    datos.setearParametro("@IdProducto", IdProducto);
                if (!string.IsNullOrWhiteSpace(nombreMarcaCategoria))
                    datos.setearParametro("@nombreMarcaCategoria", "%" + nombreMarcaCategoria + "%");
                if (precioMinimo != null)
                    datos.setearParametro("@precioMinimo", precioMinimo);
                if (precioMaximo != null)
                    datos.setearParametro("@precioMaximo", precioMaximo);

                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    int id = (int)datos.Lector["IdProducto"];
                    Producto aux = productos.Find(a => a.IdProducto == id);

                    if (aux == null)
                    {
                        aux = new Producto();
                        aux.IdProducto = (int)datos.Lector["IdProducto"]; ;
                        aux.Nombre = (string)datos.Lector["Nombre"];
                        aux.StockActual = (int)datos.Lector["StockActual"];
                        aux.StockMinimo = (int)datos.Lector["StockMinimo"];
                        aux.PorcentajeGanancia = (decimal)datos.Lector["PorcentajeGanancia"];
                        aux.Precio = (int)datos.Lector["Precio"];
                        aux.Marca = new Dominio.Marca { Nombre = (string)datos.Lector["Marca"] };
                        aux.Categoria = new Categoria { Descripcion = (string)datos.Lector["Categoria"] };
                        aux.Imagenes = new List<Imagen>();
                        aux.Activo = (bool)datos.Lector["Activo"];

                        productos.Add(aux);
                    }

                }

                return productos;
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

        public void agregar(Producto nuevo)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {

                datos.setearConsulta(
                     "INSERT INTO Productos (Nombre, IdMarca, IdCategoria, StockActual, StockMinimo, PorcentajeGanancia, Precio, IdProveedor, Activo) " +
                     "VALUES (@Nombre, @IdMarca, @IdCategoria, @StockActual, @StockMinimo, @PorcentajeGanancia, @Precio, @IdProveedor, 1)"
                 );

                datos.setearParametro("@IdProveedor", nuevo.Proveedor.IdProveedor);
                datos.setearParametro("@Nombre", nuevo.Nombre);
                datos.setearParametro("@IdMarca", nuevo.Marca.IdMarca);
                datos.setearParametro("@IdCategoria", nuevo.Categoria.IdCategoria);
                datos.setearParametro("@StockActual", nuevo.StockActual);
                datos.setearParametro("@StockMinimo", nuevo.StockMinimo);
                datos.setearParametro("@PorcentajeGanancia", nuevo.PorcentajeGanancia);
                datos.setearParametro("@Precio", nuevo.Precio);
                datos.setearParametro("@Activo", nuevo.Activo);

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
                datos.setearConsulta("UPDATE Productos SET Nombre = @Nombre, IdMarca = @IdMarca, IdCategoria = @IdCategoria, StockActual = @StockActual, StockMinimo = @StockMinimo, PorcentajeGanancia = @PorcentajeGanancia, Precio = @Precio WHERE IdProducto = @IdProducto");

                datos.setearParametro("@IdProducto", producto.IdProducto);
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

        public void DescontarStock(int IdProducto, int cantidad)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("UPDATE Productos SET StockActual = StockActual - @Cantidad WHERE IdProducto = @IdProducto");
                datos.setearParametro("IdProducto", IdProducto);
                datos.setearParametro("@Cantidad", cantidad);
                datos.ejecutarAccion();

            }
            catch (Exception)
            {
                throw;
            }
        }

        public void AgregarStock(int IdProducto, int cantidad)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("UPDATE Productos SET StockActual = StockActual + @Cantidad WHERE IdProducto = @IdProducto");
                datos.setearParametro("IdProducto", IdProducto);
                datos.setearParametro("@Cantidad", cantidad);
                datos.ejecutarAccion();

            }
            catch (Exception)
            {
                throw;
            }
        }

        public void DarDeBaja(int IdProducto)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("UPDATE Productos SET Activo = 0 FROM Productos WHERE IdProducto = @IdProducto");
                datos.setearParametro("@IdProducto", IdProducto);
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

        public void DarDeAlta(int IdProducto)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("UPDATE Productos SET Activo = 1 FROM Productos WHERE IdProducto = @IdProducto");
                datos.setearParametro("@IdProducto", IdProducto);
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

        public List<Producto> ListarPorMarcaCategoria(int idMarca, int idCategoria)
        {
            List<Producto> lista = new List<Producto>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                string consulta = @"
            SELECT P.IdProducto, P.Nombre, P.Activo 
            FROM Productos P
            INNER JOIN Marcas M ON P.IdMarca = M.IdMarca
            INNER JOIN Categorias C ON P.IdCategoria = C.IdCategoria
            WHERE P.IdMarca = @idMarca AND P.IdCategoria = @idCategoria";

                datos.setearConsulta(consulta);
                datos.setearParametro("@idMarca", idMarca);
                datos.setearParametro("@idCategoria", idCategoria);

                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Producto prod = new Producto();
                    prod.IdProducto = (int)datos.Lector["IdProducto"];
                    prod.Nombre = (string)datos.Lector["Nombre"];
                    prod.Activo = (bool)datos.Lector["Activo"];

                    lista.Add(prod);
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
        public Producto BuscarPorId(int id)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT IdProducto, Nombre, Activo, StockActual FROM Productos WHERE IdProducto = @id");
                datos.setearParametro("@id", id);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    Producto aux = new Producto();

                    aux.IdProducto = (int)datos.Lector["IdProducto"];
                    aux.Activo = (bool)datos.Lector["Activo"];
                    aux.Nombre = datos.Lector["Nombre"].ToString();
                    aux.StockActual = (int)datos.Lector["StockActual"];


                    return aux;
                }

                return null;
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
