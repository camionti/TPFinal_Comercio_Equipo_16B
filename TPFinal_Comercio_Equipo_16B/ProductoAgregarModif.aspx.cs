using Dominio;
using Microsoft.Ajax.Utilities;
using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPFinal_Comercio_Equipo_16B
{
    public partial class ProductoAgregarModif : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarMarcas();
                CargarCategorias();

                // 1) Obtener el id desde la ruta
                var idStr = Page.RouteData.Values["id"] as string;

                if (int.TryParse(idStr, out int id))
                {
                    lblTitulo.Text = "Modificar Producto";
                    CargarProducto(id);
                }
 
            }
        }

        private void CargarMarcas()
        {
            MarcaNegocio marcaNeg = new MarcaNegocio();
            ddlMarca.DataSource = marcaNeg.Listar();
            ddlMarca.DataTextField = "Nombre";
            ddlMarca.DataValueField = "IdMarca";
            ddlMarca.DataBind();
        }

        private void CargarCategorias()
        {
            CategoriaNegocio catNeg = new CategoriaNegocio();
            ddlCategoria.DataSource = catNeg.Listar();
            ddlCategoria.DataTextField = "Descripcion";
            ddlCategoria.DataValueField = "IdCategoria";
            ddlCategoria.DataBind();
        }

        private void CargarProducto(int id)
        {
            ProductosNegocio prodNeg = new ProductosNegocio();
            Producto prod = prodNeg.buscar(id)[0];

            if (prod != null)
            {
                txtNombre.Text = prod.Nombre;
                ddlMarca.SelectedValue = prod.Marca.IdMarca.ToString();
                ddlCategoria.SelectedValue = prod.Categoria.IdCategoria.ToString();
                txtStockActual.Text = prod.StockActual.ToString();
                txtStockMinimo.Text = prod.StockMinimo.ToString();
                txtPorcentajeGanancia.Text = prod.PorcentajeGanancia.ToString("0.##");
                //txtPrecio.Text = prod.Precio.ToString("0.##");
            }
        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            bool hayInputsVacios = validarInputs();
            if (hayInputsVacios) return;

            ProductosNegocio negocio = new ProductosNegocio();
            Producto prod = new Producto
            {
                Nombre = txtNombre.Text,
                Marca = new Marca { IdMarca = int.Parse(ddlMarca.SelectedValue) },
                Categoria = new Categoria { IdCategoria = int.Parse(ddlCategoria.SelectedValue) },
                StockActual = int.Parse(txtStockActual.Text),
                StockMinimo = int.Parse(txtStockMinimo.Text),
                PorcentajeGanancia = decimal.Parse(txtPorcentajeGanancia.Text),
                //Precio = decimal.Parse(txtPrecio.Text)
            };

            lblMensajeError.Text = "";
            bool hayError = validarProducto(prod);

            if (hayError || hayInputsVacios)
            {
                lblMensajeModal.Text = "Errores encontrados";
                modalHeader.Attributes["class"] = "modal-header bg-danger text-white";
                btnCerrarModal.Visible = true;
                btnVolverAlPanel.Visible = false;
                modalBody.Visible = true;
            }
            else
            {
                modalHeader.Attributes["class"] = "modal-header bg-success text-white";
                btnVolverAlPanel.Visible = true;
                btnCerrarModal.Visible = false;
                modalBody.Visible = false;

            }

            var idStr = Page.RouteData.Values["id"] as string;

            if (!hayError && !hayInputsVacios)
            {
                //Pregunto si viene un ID por parametro, si hay edito sino agrego
                if (int.TryParse(idStr, out int id))
                {
                    prod.IdProducto = id;
                    negocio.modificar(prod);
                    lblMensajeModal.Text = "Producto editado correctamente";
                }
                else
                {
                    negocio.agregar(prod);
                    lblMensajeModal.Text = "Producto agregado correctamente";
                }
            }


            ScriptManager.RegisterStartupScript(this, this.GetType(), "mostrarModal",
                "$('#modalConfirmacion').modal('show');", true);

        }

        protected bool validarInputs()
        {
            bool hayError = false;

            if (string.IsNullOrWhiteSpace(txtNombre.Text))
            {
                lblMensajeError.Text += "El nombre no puede estar vacío<br/>";
                hayError = true;
            }

            if (string.IsNullOrWhiteSpace(txtStockActual.Text))
            {
                lblMensajeError.Text += "El stock actual no puede estar vacío<br/>";
                hayError = true;
            }


            if (string.IsNullOrWhiteSpace(txtStockMinimo.Text))
            {
                lblMensajeError.Text += "El stock mínimo no puede estar vacío<br/>";
                hayError = true;
            }

            if (string.IsNullOrWhiteSpace(txtPorcentajeGanancia.Text))
            {
                lblMensajeError.Text += "El porcentaje de ganancia no puede estar vacío<br/>";
                hayError = true;
            }

            //if (string.IsNullOrWhiteSpace(txtPrecio.Text))
            //{
            //    lblMensajeError.Text += "El precio no puede estar vacío<br/>";
            //    hayError = true;
            //}

            lblMensajeModal.Text = "Errores encontrados";
            modalHeader.Attributes["class"] = "modal-header bg-danger text-white";
            btnCerrarModal.Visible = true;
            btnVolverAlPanel.Visible = false;
            modalBody.Visible = true;

            ScriptManager.RegisterStartupScript(this, this.GetType(), "mostrarModal",
            "$('#modalConfirmacion').modal('show');", true);

            return hayError;
        }

        protected bool validarProducto(Producto prod)
        {
            bool hayError = false;

            if (prod.PorcentajeGanancia < 0 || prod.PorcentajeGanancia > 100)
            {
                lblMensajeError.Text += "El % de ganancia no puede ser menor a 0 ni mayor a 100<br/>";
                hayError = true;
            }

            //if (prod.Precio <= 1000)
            //{
            //    lblMensajeError.Text += "El precio no puede ser menor a 1000<br/>";
            //    hayError = true;
            //}

            if (prod.StockMinimo < 0)
            {
                lblMensajeError.Text += "El stock mínimo no puede ser menor a 0<br/>";
                hayError = true;
            }

            if (prod.StockActual < 0)
            {
                lblMensajeError.Text += "El stock actual no puede ser menor a 0<br/>";
                hayError = true;
            }

            if (prod.StockActual < prod.StockMinimo)
            {
                lblMensajeError.Text += "El stock actual no puede ser menor al mínimo<br/>";
                hayError = true;
            }

            return hayError;
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.RedirectToRoute($"ProductosAdmin");

        }

        protected void btnVolverAlPanel_Click(object sender, EventArgs e)
        {
            Response.RedirectToRoute($"ProductosAdmin");
        }
    }
}