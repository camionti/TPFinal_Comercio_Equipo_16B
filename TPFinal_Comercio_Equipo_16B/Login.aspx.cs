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
            Usuario logueado = negocio.Loguear(usuario);

            if (logueado != null)
            {
                Session["usuario"] = logueado;
                Session["id"] = logueado.IdUsuario;
                Session["rol"] = logueado.Rol == Rol.Administrador ? "admin" : "vendedor";

                if (logueado.Rol == Rol.Administrador)
                    Response.Redirect("Administrador.aspx");
                else
                    Response.Redirect("Vendedor.aspx");
            }
            else
            {
                lblMensaje.Text = "Usuario o contraseña incorrectos.";
            }
        }
    }
}