using Dominio;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class VentaNegocio
    {

        public List<Venta> Listar(int? IdUsuario = null, bool? activo = null)
        {
            List<Venta> lista = new List<Venta>();
            AccesoDatos datos = new AccesoDatos();
            string consulta = @"
                        SELECT V.IdVenta, V.Fecha, V.Total, V.MotivoBaja, V.Activo, 
                               C.IdCliente, C.Nombre AS NombreCliente,
                               U.IdUsuario, U.NombreUsuario
                        FROM Ventas V
                        INNER JOIN Clientes C ON V.IdCliente = C.IdCliente
                        INNER JOIN Usuarios U ON U.IdUsuario = V.IdUsuario
                        WHERE 1=1 
                    ";
            try
            {
                //Seteo consulta
                if (IdUsuario.HasValue)
                {
                    consulta += " AND U.IdUsuario = @IdVendedor";
                }

                if (activo.HasValue)
                {
                    consulta += " AND V.Activo = @Activo";
                }

                datos.setearConsulta(consulta);

                //seteo parametros
                if (IdUsuario.HasValue)
                    datos.setearParametro("@IdVendedor", IdUsuario.Value);

                if (activo.HasValue)
                    datos.setearParametro("@Activo", activo.Value);

                datos.ejecutarLectura();


                while (datos.Lector.Read())
                {
                    Venta venta = new Venta();
                    venta.IdVenta = (int)datos.Lector["IdVenta"];
                    venta.Fecha = (DateTime)datos.Lector["Fecha"];
                    venta.Total = (decimal)datos.Lector["Total"];
                    venta.MotivoBaja = datos.Lector["MotivoBaja"] == DBNull.Value
                            ? null
                            : (string)datos.Lector["MotivoBaja"];
                    venta.Activo = (bool)datos.Lector["Activo"];

                    //venta.NumeroFactura = (string)datos.Lector["NumeroFactura"];

                    venta.Cliente = new Cliente
                    {
                        IdCliente = (int)datos.Lector["IdCliente"],
                        Nombre = (string)datos.Lector["NombreCliente"]
                    };

                    venta.Usuario = new Usuario
                    {
                        IdUsuario = (int)datos.Lector["IdUsuario"],
                        NombreUsuario = (string)datos.Lector["NombreUsuario"]
                    };

                    lista.Add(venta);
                }

                return lista;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

       
        public List<Venta> Buscar(int IdVenta = 0, string nombreUsuario = null, string nombreCliente = null, int? numeroFactura = 0 )
        {
            List<Venta> ventas = new List<Venta>();
            AccesoDatos datos = new AccesoDatos();

            string consulta = "SELECT V.IdVenta, V.IdCliente, V.IdUsuario, V.Fecha, V.MotivoBaja, V.Activo , U.NombreUsuario, C.Nombre NombreCliente FROM Ventas V" +
                              " LEFT JOIN Clientes C ON C.IdCliente = V.IdCliente" +
                              " LEFT JOIN Usuarios U ON U.IdUsuario = V.IdUsuario" +
                              " WHERE 1=1 ";
            try
            {
                //Pregunto cosas, idventa, idcliente etc
                if (IdVenta > 0)
                    consulta += " AND V.IdVenta = @IdVenta";
                if (!string.IsNullOrWhiteSpace(nombreUsuario))
                    consulta += " AND U.NombreUsuario LIKE @NombreUsuario";
                if(!string.IsNullOrWhiteSpace(nombreCliente))
                    consulta += " AND C.NombreCliente LIKE @nombreCliente";
                if (numeroFactura > 0)
                    consulta += " AND V.NumeroFactura = @numeroFactura";

                datos.setearConsulta(consulta);

                if (IdVenta > 0)
                    datos.setearParametro("@IdVenta", IdVenta);
                if (!string.IsNullOrWhiteSpace(nombreUsuario))
                    datos.setearParametro("@NombreUsuario", "%" + nombreUsuario + "%");
                if (!string.IsNullOrWhiteSpace(nombreCliente))
                    datos.setearParametro("@NombreCliente", "%" + nombreCliente + "%");
                if (numeroFactura > 0)
                    datos.setearParametro("@NumeroFactura", numeroFactura);

                datos.ejecutarLectura();

                while(datos.Lector.Read())
                {
                    int id = (int)datos.Lector["IdVenta"];
                    Venta aux = ventas.Find(x => x.IdVenta == id);

                    if(aux == null)
                    {
                        aux = new Venta();
                        aux.IdVenta = (int)datos.Lector["IdVenta"];
                        aux.Cliente = new Cliente();
                        aux.Cliente.IdCliente = (int)datos.Lector["IdCliente"];
                        aux.Cliente.Nombre = (string)datos.Lector["NombreCliente"];
                        aux.Usuario = new Usuario();
                        aux.Usuario.IdUsuario = (int)datos.Lector["IdUsuario"];
                        aux.Usuario.NombreUsuario = (string)datos.Lector["NombreUsuario"];
                        //aux.NumeroFactura = (string)datos.Lector["NumeroFactura"];
                        aux.Fecha = (DateTime)datos.Lector["Fecha"];
                        aux.MotivoBaja = datos.Lector["MotivoBaja"] == DBNull.Value
                                            ? null
                                            : (string)datos.Lector["MotivoBaja"];
                        aux.Activo = (bool)datos.Lector["Activo"];
                        ventas.Add(aux);
                    }
                }
                return ventas;
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

        public void Agregar(Venta venta, List<DetalleVenta> detalles)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                // Seteo procedure
                datos.setearProcedure("sp_Ventas_Crear");

                // Seteo parametros
                datos.setearParametro("@IdCliente", venta.Cliente.IdCliente);
                datos.setearParametro("@IdUsuario", venta.Usuario.IdUsuario);
                datos.setearParametro("@Fecha", venta.Fecha);


                // Armo la tabla Detalles para enviar a la DB
                DataTable tablaDetalles = new DataTable();
                tablaDetalles.Columns.Add("IdProducto", typeof(int));
                tablaDetalles.Columns.Add("Cantidad", typeof(int));
                tablaDetalles.Columns.Add("PrecioUnitario", typeof(decimal));

                foreach (DetalleVenta det in detalles)
                {
                    tablaDetalles.Rows.Add(
                        det.Producto.IdProducto,
                        det.Cantidad,
                        det.PrecioUnitario
                    );
                }

                // Seteo la tabla Detalles
                datos.setearParametroTabla("@Detalles", tablaDetalles, "dbo.TipoDetalleVenta");


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

        public void Modificar(Venta venta)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("UPDATE Ventas SET Fecha = @Fecha, IdCliente = @IdCliente, IdUsuario = @IdUsuario, Total = @Total WHERE IdVenta = @IdVenta");

                datos.setearParametro("@IdVenta", venta.IdVenta);
                datos.setearParametro("@Fecha", venta.Fecha);
                datos.setearParametro("@IdCliente", venta.Cliente.IdCliente);
                datos.setearParametro("@IdUsuario", venta.Usuario.IdUsuario);
                //datos.setearParametro("@NumeroFactura", venta.NumeroFactura);
                datos.setearParametro("@Total", venta.Total);

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

        public void DarDeBaja(int idVenta, string motivo)
        {
            AccesoDatos datos = new AccesoDatos();

            datos.setearConsulta("UPDATE Ventas SET Activo = 0, MotivoBaja = @motivo WHERE IdVenta = @id");
            datos.setearParametro("@id", idVenta);
            datos.setearParametro("@motivo", motivo);
            datos.ejecutarAccion();
        }

        public void Eliminar(int IdVenta)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("DELETE FROM Ventas where IdVenta = @IdVenta");
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
