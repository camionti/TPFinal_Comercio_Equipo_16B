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
                CargarLista(true);
                CargarFiltros();
            }
        }

        private void CargarLista(bool? activos = null)
        {
            List<Producto> listaProducto = new List<Producto>();

            try
            {
                ProductosNegocio conexionProducto = new ProductosNegocio();
                listaProducto = conexionProducto.Listar(activos);

                gvProductos.DataSource = listaProducto;
                gvProductos.DataBind();
            }
            catch (Exception ex)
            {

                lblMensajeError.Text = ex.ToString();
                mostrarError();
            }
        }

        private void CargarFiltros()
        {
            ddlFiltros.Items.Clear();

            ddlFiltros.Items.Add(new ListItem("Activos", "1"));
            ddlFiltros.Items.Add(new ListItem("Inactivos", "0"));
            ddlFiltros.Items.Add(new ListItem("Todos", ""));
        }

        protected void lblFiltrarProductos_SelectedIndexChanged(object sender, EventArgs e)
        {
            bool? activo = null;

            switch (ddlFiltros.SelectedValue)
            {
                case "1": // Solo activos
                    activo = true;
                    break;
                case "0": // Solo inactivos
                    activo = false;
                    break;
                case "":  // Todas
                    activo = null;
                    break;
            }

            CargarLista(activo);
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
                CargarLista(true);
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
            catch (Exception ex)
            {
                lblMensajeError.Text = ex.ToString();
                mostrarError();
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
                    tituloModalConfirmar.InnerText = "Confirmar baja de producto";
                    modalconfirmarheader.Attributes["class"] = "modal-header bg-danger text-white";
                    btnConfirmarBaja.Visible = true;
                    btnConfirmarAlta.Visible = false;
                    hfIdProducto.Value = id.ToString();
                    ScriptManager.RegisterStartupScript(this, GetType(), "modal",
                        "$('#modalBaja').modal('show');", true);
                    break;

                case "Alta":
                    tituloModalConfirmar.InnerText = "Confirmar alta de producto";
                    btnConfirmarAlta.Visible = true;
                    btnConfirmarBaja.Visible = false;
                    modalconfirmarheader.Attributes["class"] = "modal-header bg-primary text-white";
                    hfIdProducto.Value = id.ToString();
                    ScriptManager.RegisterStartupScript(this, GetType(), "modal",
                        "$('#modalBaja').modal('show');", true);
                    break;
                }

        }

        protected void btnConfirmarAlta_Click(object sender, EventArgs e)
        {
            int id = int.Parse(hfIdProducto.Value);
            try
            {
                var productoConexion = new ProductosNegocio();
                productoConexion.DarDeAlta(id);
                lblMensajeModal.Text = "Producto activado correctamente";
                mostrarMensajeExito();
                ddlFiltros.SelectedValue = "";
                CargarLista();
            }
            catch (Exception ex)
            {
                lblMensajeError.Text = ex.ToString();
                mostrarError();
            }
        }


        protected void btnConfirmarBaja_Click(object sender, EventArgs e)
        {
            int id = int.Parse(hfIdProducto.Value);

            try
            {
                var productoConexion = new ProductosNegocio();
                productoConexion.DarDeBaja(id);
                lblMensajeModal.Text = "Producto eliminado correctamente";
                mostrarMensajeExito();
                ddlFiltros.SelectedValue = "";
                CargarLista();

            }
            catch (Exception ex)
            {
                lblMensajeError.Text = ex.ToString();
                mostrarError();
            }
        }

        private void mostrarError()
        {
            lblMensajeModal.Text = "Errores encontrados";
            modalHeader.Attributes["class"] = "modal-header bg-danger text-white";
            btnCerrarModal.Visible = true;

            ScriptManager.RegisterStartupScript(this, this.GetType(), "mostrarModal",
            "$('#modalConfirmacion').modal('show');", true);
        }

        private void mostrarMensajeExito()
        {
            modalHeader.Attributes["class"] = "modal-header bg-success text-white";
            btnCerrarModal.Visible = false;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "mostrarModal",
            "$('#modalConfirmacion').modal('show');", true);
            btnCerrarModal.Visible = true;

        }
    }
}