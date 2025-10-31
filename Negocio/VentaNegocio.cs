using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Negocio
{
    public class VentaNegocio
    {
        public List<Venta> Listar()
        {
            List<Venta> lista = new List<Venta>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
                    SELECT V.IdVenta, V.Fecha, V.NumeroFactura,
                           C.IdCliente, C.Nombre AS NombreCliente,
                           U.IdUsuario, U.NombreUsuario
                    FROM Ventas V
                    INNER JOIN Clientes C ON V.IdCliente = C.IdCliente
                    INNER JOIN Usuarios U ON V.IdUsuario = U.IdUsuario
                ");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Venta venta = new Venta();
                    venta.IdVenta = (int)datos.Lector["IdVenta"];
                    venta.Fecha = (DateTime)datos.Lector["Fecha"];
                    venta.NumeroFactura = (string)datos.Lector["NumeroFactura"];

                  
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

        public void Agregar(Venta nueva)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("INSERT INTO Ventas (Fecha, IdCliente, IdUsuario, NumeroFactura) VALUES (@Fecha, @IdCliente, @IdUsuario, @NumeroFactura)");
                datos.setearParametro("@Fecha", nueva.Fecha);
                datos.setearParametro("@IdCliente", nueva.Cliente.IdCliente);
                datos.setearParametro("@IdUsuario", nueva.Usuario.IdUsuario);
                datos.setearParametro("@NumeroFactura", nueva.NumeroFactura);
                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
