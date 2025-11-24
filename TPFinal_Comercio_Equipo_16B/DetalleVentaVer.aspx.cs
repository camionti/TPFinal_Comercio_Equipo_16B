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
    public partial class DetalleVentaVer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                CargarDetalles();
            }

        }

        private void CargarDetalles()
        {
            var detalles = ObtenerDetallesEnDB();
            repDetalles.DataSource = detalles;
            repDetalles.DataBind();
        }

        private List<DetalleVenta> ObtenerDetallesEnDB()
        {
            try
            {
                var detallesVentaConexion = new DetalleVentaNegocio();
                int IdVenta = ObtenerIdParametro();
                return detallesVentaConexion.ListarPorVenta(IdVenta);
            }
            catch (Exception)
            {
                throw;
            }
        }

        protected int ObtenerIdParametro()
        {
            string idStr = Request.QueryString["id"];

            if (!int.TryParse(idStr, out int id))
            {
                //Si no puede parsear el ID vuelve a la pagina anterior del historial
                ScriptManager.RegisterStartupScript(this, GetType(), "historyBack", "history.back();", true);
            }

            return id;
        }
    }
}