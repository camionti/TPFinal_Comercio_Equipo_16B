using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPFinal_Comercio_Equipo_16B
{
    public partial class LoginAdministrador : System.Web.UI.Page
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
            Response.Redirect("Administrador.aspx"); ///faltan validaciones con la DB (es una prueba para navegar entre pantallas)
        }
    }
}