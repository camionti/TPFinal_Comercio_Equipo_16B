using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPFinal_Comercio_Equipo_16B
{
    public partial class EleccionPerfil : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnAdministrador_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoginAdministrador.aspx");
        }
        protected void btnVendedor_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoginVendedor.aspx");
        }
    }
}