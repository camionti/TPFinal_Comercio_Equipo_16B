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
    }
}