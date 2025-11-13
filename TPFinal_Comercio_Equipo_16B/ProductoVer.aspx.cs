using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPFinal_Comercio_Equipo_16B
{
    public partial class ProductoVer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (IsPostBack) return;

            // 1) Obtener el id desde la ruta
            var idStr = Page.RouteData.Values["id"] as string;

            if (!int.TryParse(idStr, out int id))
            {
                //Si no puede parsear el ID vuelve a la pagina anterior del historial
                ScriptManager.RegisterStartupScript(this, GetType(), "historyBack", "history.back();", true);
            }

            // 2) Buscar producto
            var negocio = new ProductosNegocio();
            var producto = negocio.buscar(id)[0];

            if (producto == null)
            {
                Response.Redirect("~/Error.aspx");
                return;
            }


            // 3) Asignar a los controles del front
            lblNombre.InnerText = producto.Nombre;
            lblMarca.InnerText = producto.Marca.Nombre;
            lblCategoria.InnerText = producto.Categoria.Descripcion;
            lblStock.InnerText = producto.StockActual.ToString();
            lblPrecio.InnerText = producto.Precio.ToString();

            //lblPrecio.InnerText = "U$D " + producto.Precio.ToString("N0");

            lblPorcentajeGanancia.InnerText = producto.PorcentajeGanancia.ToString("0.#") + " %";


        }
    }
}