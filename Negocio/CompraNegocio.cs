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
        public List<Compra> Listar()
        {
            List<Compra> lista = new List<Compra>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT IdCompra, Fecha, IdProveedor FROM Compras");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Compra aux = new Compra();
                    aux.IdCompra = (int)datos.Lector["IdCompra"];
                    aux.Fecha = (DateTime)datos.Lector["Fecha"];
                    aux.IdProveedor = (int)datos.Lector["IdProveedor"];
                    lista.Add(aux);
                }

                return lista;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void Agregar(Compra nueva)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("INSERT INTO Compras (Fecha, IdProveedor) VALUES (@Fecha, @IdProveedor)");
                datos.setearParametro("@Fecha", nueva.Fecha);
                datos.setearParametro("@IdProveedor", nueva.IdProveedor);
                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
