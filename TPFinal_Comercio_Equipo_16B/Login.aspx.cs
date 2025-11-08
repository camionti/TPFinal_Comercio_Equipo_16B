using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Negocio;

namespace TPFinal_Comercio_Equipo_16B
{
    public partial class LoginVendedor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnInicio_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }
        protected void btnIniciarSesion_Click(object sender, EventArgs e)
        {

            Usuario usuario = new Usuario();
            usuario.NombreUsuario = txtUsuario.Text;
            usuario.Contrasenia = txtPassword.Text;

            UsuarioNegocio negocio = new UsuarioNegocio();

            try
            {
                bool logueado = negocio.Loguear(usuario); 

                if (logueado)
                {
                    Session.Add("rol", usuario.Rol);
                    Session.Add("id", usuario.IdUsuario);

                    // Redirige segun el rol
                    if (usuario.Rol == Rol.Administrador)
                    {
                        Response.Redirect("Administrador.aspx");
                    }
                    else if (usuario.Rol == Rol.Vendedor)
                    {
                        Response.Redirect("Vendedor.aspx");
                    }
                }
                else
                {
                 
                    lblMensaje.Text = "Usuario o contraseña incorrectos.";
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al iniciar sesión: " + ex.Message;
            }
        }
    }
}