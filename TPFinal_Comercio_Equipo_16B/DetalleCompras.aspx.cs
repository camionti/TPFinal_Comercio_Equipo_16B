using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPFinal_Comercio_Equipo_16B
{
    public partial class DetalleCompras : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                CargarCompras();
        }

        private void CargarCompras()
        {
            CompraNegocio negocio = new CompraNegocio();
            gvCompras.DataSource = negocio.Listar(); // <-- necesitás implementar Listar()
            gvCompras.DataBind();
        }

        protected void gvCompras_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int idCompra = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "VerDetalles")
            {
                DetalleCompraNegocio detalleNegocio = new DetalleCompraNegocio();
                gvDetalleCompra.DataSource = detalleNegocio.ListarPorCompra(idCompra);
                gvDetalleCompra.DataBind();

                ScriptManager.RegisterStartupScript(this, GetType(), "modal",
                    "$('#modalDetalles').modal('show');", true);
            }

            if (e.CommandName == "DarBaja")
            {
                hfIdCompraBaja.Value = idCompra.ToString();
                ScriptManager.RegisterStartupScript(this, GetType(), "modal",
                    "$('#modalBaja').modal('show');", true);
            }
        }

        protected void btnConfirmarBaja_Click(object sender, EventArgs e)
        {
            int id = int.Parse(hfIdCompraBaja.Value);
            string motivo = txtMotivoBaja.Text;

            CompraNegocio negocio = new CompraNegocio();
            negocio.DarDeBaja(id, motivo);

            CargarCompras();
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("Administrador.aspx");
        }
        protected void regCompra_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegistroCompras.aspx");
        }
    }
}