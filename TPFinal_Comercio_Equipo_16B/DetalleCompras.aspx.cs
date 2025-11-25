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
            {
                CargarCompras(true);
                CargarFiltros();
            }
        }

        private void CargarCompras(bool? activas = null)
        {
            CompraNegocio negocio = new CompraNegocio();
            gvCompras.DataSource = negocio.Listar(activas);
            gvCompras.DataBind();
        }

        private void CargarFiltros()
        {
            ddlFiltros.Items.Clear();

            ddlFiltros.Items.Add(new ListItem("Activas", "1"));
            ddlFiltros.Items.Add(new ListItem("Inactivas", "0"));
            ddlFiltros.Items.Add(new ListItem("Todas", ""));
        }

        protected void gvCompras_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int idCompra = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "VerDetalles")
            {
                divMotivoBaja.Visible = false;
                lblMotivoBaja.Visible = true;
                DetalleCompraNegocio detalleNegocio = new DetalleCompraNegocio();
                gvDetalleCompra.DataSource = detalleNegocio.ListarPorCompra(idCompra);
                gvDetalleCompra.DataBind();

                ScriptManager.RegisterStartupScript(this, GetType(), "modal",
                    "$('#modalDetalles').modal('show');", true);
            }

            if (e.CommandName == "DarBaja")
            {
                divMotivoBaja.Visible = false;
                lblMotivoBaja.Visible = true;
                hfIdCompraBaja.Value = idCompra.ToString();
                ScriptManager.RegisterStartupScript(this, GetType(), "modal",
                    "$('#modalBaja').modal('show');", true);
            }

            if (e.CommandName == "MotivoBaja")
            {
                DetalleCompraNegocio detalleNegocio = new DetalleCompraNegocio();
                gvDetalleCompra.DataSource = detalleNegocio.ListarPorCompra(idCompra);
                gvDetalleCompra.DataBind();

                CompraNegocio compraNegocio = new CompraNegocio();
                var compra = compraNegocio.BuscarPorId(idCompra);
                lblMotivoBaja.Text = compra.MotivoBaja;
                lblMotivoBaja.Visible = true;
                divMotivoBaja.Visible = true;

                ScriptManager.RegisterStartupScript(this, GetType(), "modal",
                    "$('#modalDetalles').modal('show');", true);
            }
        }

        protected void lblFiltrarCompras_SelectedIndexChanged(object sender, EventArgs e)
        {
            bool? activo = null;

            switch (ddlFiltros.SelectedValue)
            {
                case "1": // Solo activas
                    activo = true;
                    break;
                case "0": // Solo inactivas
                    activo = false;
                    break;
                case "":  // Todas
                    activo = null;
                    break;
            }

            CargarCompras(activo);
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