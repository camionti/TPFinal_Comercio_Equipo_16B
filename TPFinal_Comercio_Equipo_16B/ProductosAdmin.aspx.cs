using Dominio;
using Microsoft.Ajax.Utilities;
using Negocio;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPFinal_Comercio_Equipo_16B
{
    public partial class ProductosAdmin : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarLista();
                DataBind();
            }
        }

        private void CargarLista()
        {
            List<Producto> listaProducto = new List<Producto>();

            try
            {
                ProductosNegocio conexionProducto = new ProductosNegocio();
                listaProducto = conexionProducto.Listar();

                gvProductos.DataSource = listaProducto;
                gvProductos.DataBind();
            }
            catch (Exception ex)
            {

                throw ex;
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
                return;
            }


            try
            {
                ProductosNegocio conexionProducto = new ProductosNegocio();
                productos = conexionProducto.buscar(0, txtBuscar.Text, precioMin, precioMax);

                if(productos.Count == 0)
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



        protected void gvProductos_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            if (string.IsNullOrEmpty(e.CommandName)) return;

            //Si no puedo parsear el id retorno, sino parseo y guardo en la variable id
            if (!int.TryParse(e.CommandArgument?.ToString(), out int id)) return;

            string evento = e.CommandName;



            switch (evento)
            {
                case "Ver":
                    Response.RedirectToRoute($"ProductosAdmin_Ver", new { id = id });
                    break;
                case "Agregar":
                    Response.RedirectToRoute($"ProductosAdmin_Agregar");
                    break;

                case "Editar":
                    Response.RedirectToRoute("ProductosAdmin_Editar", new { id = id });
                    break;

                case "Eliminar":
                    try
                    {
                        ProductosNegocio conexionProductos = new ProductosNegocio();
                        conexionProductos.eliminar(id);
                        CargarLista();
                        break;

                    }
                    catch (Exception)
                    {
                        Response.Redirect("~/Error.aspx");
                    }
                    break;
            }

        }
    }
}