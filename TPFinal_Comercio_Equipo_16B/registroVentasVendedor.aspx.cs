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
                CargarVentas();
                DataBind();
            }

        }

        private void CargarVentas()
        {
            List<Venta> listaVenta = new List<Venta>();
            int IdVendedor = 0;

            if (int.TryParse(Session["id"]?.ToString(), out var idVendedor))
                IdVendedor = idVendedor;

            try
            {
                VentaNegocio conexionVenta = new VentaNegocio();
                listaVenta = conexionVenta.Listar(IdVendedor);

                gvVentas.DataSource = listaVenta;
                gvVentas.DataBind();
            }
            catch (Exception)
            {

                Response.Redirect("~/Error.aspx");
            }

        }

        protected void btnBuscar_Click( object sender, EventArgs e)
        {

        }
    }
}