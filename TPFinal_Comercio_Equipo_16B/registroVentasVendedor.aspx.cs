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
    public partial class registroVentasVendedor : System.Web.UI.Page
    {
        public List<Venta> listaVenta { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarVentas(true);
                CargarFiltros();
                DataBind();
            }

        }

        private void CargarFiltros()
        {
            ddlFiltros.Items.Clear();

            ddlFiltros.Items.Add(new ListItem("Activas", "1"));
            ddlFiltros.Items.Add(new ListItem("Inactivas", "0"));
            ddlFiltros.Items.Add(new ListItem("Todas", ""));
        }

        private void CargarVentas(bool? activas = null)
        {
            List<Venta> listaVenta = new List<Venta>();

            try
            {
                VentaNegocio conexionVenta = new VentaNegocio();

                string rol = Session["rol"] as string;

                int id = Convert.ToInt32(Session["id"]);

                if (rol == "admin")
                {
                    listaVenta = conexionVenta.Listar(null, activas);
                }
                else if (rol == "vendedor")
                {
                    listaVenta = conexionVenta.Listar(id, activas);
                }


                gvVentas.DataSource = listaVenta;
                gvVentas.DataBind();


            }
            catch (Exception)
            {

                throw;
            }

        }

        protected void gvVentas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int idVenta = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "VerDetalles")
            {
                divMotivoBaja.Visible = false;
                lblMotivoBaja.Visible = true;
                DetalleVentaNegocio detalleNegocio = new DetalleVentaNegocio();
                gvDetalleVenta.DataSource = detalleNegocio.ListarPorVenta(idVenta);
                gvDetalleVenta.DataBind();

                ScriptManager.RegisterStartupScript(this, GetType(), "modal",
                    "$('#modalDetalles').modal('show');", true);
            }

            if (e.CommandName == "MotivoBaja")
            {
                DetalleVentaNegocio detalleNegocio = new DetalleVentaNegocio();
                gvDetalleVenta.DataSource = detalleNegocio.ListarPorVenta(idVenta);
                gvDetalleVenta.DataBind();

                VentaNegocio ventaNegocio = new VentaNegocio();
                var venta = ventaNegocio.Buscar(idVenta)[0];
                lblMotivoBaja.Text = venta.MotivoBaja;
                lblMotivoBaja.Visible = true;
                divMotivoBaja.Visible = true;

                ScriptManager.RegisterStartupScript(this, GetType(), "modal",
                    "$('#modalDetalles').modal('show');", true);
            }
        }

        protected void lblFiltrarVentas_SelectedIndexChanged(object sender, EventArgs e)
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

            CargarVentas(activo);
        }
        protected void btnBuscar_Click( object sender, EventArgs e)
        {

        }
    }
}