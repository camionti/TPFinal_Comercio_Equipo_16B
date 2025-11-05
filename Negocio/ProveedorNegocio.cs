using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class ProveedorNegocio
    {
        public List<Proveedor> Listar()
        {
            List<Proveedor> lista = new List<Proveedor>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT IdProveedor, Nombre, Telefono, Email FROM Proveedores");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Proveedor aux = new Proveedor();
                    aux.IdProveedor = (int)datos.Lector["IdProveedor"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Telefono = (string)datos.Lector["Telefono"];
                    aux.Email = (string)datos.Lector["Email"];

                    lista.Add(aux);
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

        public void Agregar(Proveedor nuevo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("INSERT INTO Proveedores (Nombre, Telefono, Email) VALUES (@Nombre, @Telefono, @Email)");
                datos.setearParametro("@Nombre", nuevo.Nombre);
                datos.setearParametro("@Telefono", nuevo.Telefono);
                datos.setearParametro("@Email", nuevo.Email);
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

        public void Modificar(Proveedor proveedor)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("UPDATE Proveedores SET Nombre = @Nombre, Telefono = @Telefono, Email = @Email WHERE IdProveedor = @IdProveedor");
                datos.setearParametro("@Nombre", proveedor.Nombre);
                datos.setearParametro("@Telefono", proveedor.Telefono);
                datos.setearParametro("@Email", proveedor.Email);
                datos.setearParametro("@IdProveedor", proveedor.IdProveedor);
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

        public Proveedor ObtenerProveedorPorID(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            Proveedor aux = null;

            try
            {
                datos.setearConsulta("SELECT IdProveedor, Nombre, Telefono, Email FROM Proveedores WHERE IdProveedor = @IdProveedor");
                datos.setearParametro("@IdProveedor", id);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    aux = new Proveedor();
                    aux.IdProveedor = (int)datos.Lector["IdProveedor"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Telefono = (string)datos.Lector["Telefono"];
                    aux.Email = (string)datos.Lector["Email"];
                }

                return aux;
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

        public void Eliminar(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("DELETE FROM Proveedores WHERE IdProveedor = @id");
                datos.setearParametro("@id", id);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                if (ex.Message.Contains("REFERENCE constraint"))
                    throw new Exception("No se puede eliminar el proveedor porque tiene productos asociados");
                else
                    throw;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
