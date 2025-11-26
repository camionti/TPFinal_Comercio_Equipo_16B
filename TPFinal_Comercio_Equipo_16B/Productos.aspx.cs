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
    public partial class Productos : System.Web.UI.Page
    {
        public List<Producto> listaProducto { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                CargarLista();
            }
        }

        private void CargarLista()
        {
            try
            {
                ProductosNegocio conexionProducto = new ProductosNegocio();
                listaProducto = conexionProducto.Listar(true);

                gvProductos.DataSource = listaProducto;
                gvProductos.DataBind();
            }
            catch (Exception)
            {

                Response.Redirect("~/Error.aspx");
            }
        }

        protected void btnProductoVer_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "VerDetalle")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                Response.RedirectToRoute($"Productos_Ver", new { id = id });
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            List<Producto> productos = new List<Producto>();
            decimal? precioMin = null, precioMax = null;

            if (string.IsNullOrWhiteSpace(txtBuscar.Text)
                && string.IsNullOrWhiteSpace(txtPrecioMin.Text)
                && string.IsNullOrWhiteSpace(txtPrecioMax.Text)
               )
            {
                CargarLista();
                return;
            }

            if (!string.IsNullOrWhiteSpace(txtPrecioMin.Text) &&
                decimal.TryParse(txtPrecioMin.Text, out var precioMin2))
                precioMin = precioMin2;

            if (!string.IsNullOrWhiteSpace(txtPrecioMax.Text) &&
                decimal.TryParse(txtPrecioMax.Text, out var precioMax2))
                precioMax = precioMax2;

            if (precioMax.HasValue && precioMin.HasValue && precioMin > precioMax)
            {
                lblMensajeModal.Text = "Error en la búsqueda";
                lblMensajeError.Text = "El precio mínimo no puede ser mayor al precio máximo";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "mostrarModal",
                "$('#modalConfirmacion').modal('show');", true);
                CargarLista();
                return;
            }


            try
            {
                ProductosNegocio conexionProducto = new ProductosNegocio();
                productos = conexionProducto.buscar(0, txtBuscar.Text, precioMin, precioMax);

                if (productos.Count == 0)
                {
                    lblMensajeModal.Text = "0 resultados encontrados";
                    lblMensajeError.Text = "No se han encontrado resultados";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "mostrarModal",
                    "$('#modalConfirmacion').modal('show');", true);
                    CargarLista();
                    return;
                }

                gvProductos.DataSource = productos;
                gvProductos.DataBind();
            }
            catch (Exception)
            {
                Response.Redirect("~/Error.aspx");
            }

        }
    }
}