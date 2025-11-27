using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;
namespace Negocio
{
    public class UsuarioNegocio
    {
        public Usuario Loguear(Usuario usuario)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("SELECT IdUsuario, NombreUsuario, Contrasenia, Rol FROM Usuarios WHERE NombreUsuario = @NombreUsuario AND Contrasenia = @Contrasenia");
                datos.setearParametro("@NombreUsuario", usuario.NombreUsuario);
                datos.setearParametro("@Contrasenia", usuario.Contrasenia);

                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Usuario u = new Usuario();
                    u.IdUsuario = (int)datos.Lector["IdUsuario"];
                    u.NombreUsuario = (string)datos.Lector["NombreUsuario"];
                    u.Contrasenia = (string)datos.Lector["Contrasenia"];

                    int rol = (int)datos.Lector["Rol"];


                    u.Rol = rol == 1 ? Rol.Administrador : Rol.Vendedor;

                    return u; 
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

        public Usuario BuscarPorId(int id)
        {
            Usuario usuario = null;

            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("SELECT IdUsuario, NombreUsuario FROM Usuarios WHERE IdUsuario = @IdUsuario");
                datos.setearParametro("@IdUsuario", id);
                datos.ejecutarLectura();

                if(datos.Lector.Read())
                {
                    usuario = new Usuario();
                    usuario.IdUsuario = (int)datos.Lector["IdUsuario"];
                    usuario.NombreUsuario = (string)datos.Lector["NombreUsuario"];
                }

                return usuario;
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

        public void Agregar(Usuario usuario)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(
                    "INSERT INTO Usuarios (NombreUsuario, Contrasenia, Rol, Activo) " +
                    "VALUES (@NombreUsuario, @Contrasenia, @Rol, 1)");

                datos.setearParametro("@NombreUsuario", usuario.NombreUsuario);
                datos.setearParametro("@Contrasenia", usuario.Contrasenia);
                datos.setearParametro("@Rol", (int)usuario.Rol);

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

        public void Modificar(Usuario usuario)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(
                    "UPDATE Usuarios SET NombreUsuario = @NombreUsuario, " +
                    "Contrasenia = @Contrasenia, Rol = @Rol " +
                    "WHERE IdUsuario = @IdUsuario");

                datos.setearParametro("@NombreUsuario", usuario.NombreUsuario);
                datos.setearParametro("@Contrasenia", usuario.Contrasenia);
                datos.setearParametro("@Rol", (int)usuario.Rol);
                datos.setearParametro("@IdUsuario", usuario.IdUsuario);

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

 
        public void Eliminar(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(
                    "UPDATE Usuarios SET Activo = 0 WHERE IdUsuario = @IdUsuario");

                datos.setearParametro("@IdUsuario", id);

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

        public List<Usuario> Listar()
        {
            List<Usuario> lista = new List<Usuario>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT IdUsuario, NombreUsuario, Contrasenia, Rol, Activo FROM Usuarios WHERE Activo = 1");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Usuario u = new Usuario();
                    u.IdUsuario = (int)datos.Lector["IdUsuario"];
                    u.NombreUsuario = (string)datos.Lector["NombreUsuario"];
                    u.Contrasenia = (string)datos.Lector["Contrasenia"];
                    u.Rol = (Rol)(int)datos.Lector["Rol"];
                    u.Activo = (bool)datos.Lector["Activo"];

                    lista.Add(u);
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