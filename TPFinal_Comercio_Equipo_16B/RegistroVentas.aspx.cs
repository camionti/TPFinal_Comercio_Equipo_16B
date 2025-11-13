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
    public partial class RegistroVentas : System.Web.UI.Page
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


            try
            {
                VentaNegocio conexionVenta = new VentaNegocio();
                listaVenta = conexionVenta.Listar();

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

            if (string.IsNullOrEmpty(e.CommandName)) return;

            //Si no puedo parsear el id de la venta hago return, sino parseo y guardo en la variable id
            if (!int.TryParse(e.CommandArgument?.ToString(), out int id)) return;

            string evento = e.CommandName;



            switch (evento)
            {
                case "Ver":
                    Response.Redirect($"~/DetalleVentaVer.aspx?id={id}");
                    break;

                case "Eliminar":
                    try
                    {
                        VentaNegocio ventasConexion = new VentaNegocio();
                        DetalleVentaNegocio detalleVentaConexion = new DetalleVentaNegocio();
                        DetalleVenta detalleVenta = detalleVentaConexion.ListarPorVenta(id)[0];

                        detalleVentaConexion.Eliminar(id);
                        ventasConexion.Eliminar(id);

                        ProductosNegocio conexionProductos = new ProductosNegocio();
                        conexionProductos.AgregarStock(detalleVenta.Producto.IdProducto, detalleVenta.Cantidad);

                        mostrarMensajeExito();

                        CargarVentas();
                        break;

                    }
                    catch (Exception)
                    {
                        mostrarError();
                        throw;
                        //Response.Redirect("~/Error.aspx");
                    }
                    break;
            }

        }

        protected void btnVolverAlPanel_Click(object sender, EventArgs e)
        {
            Response.RedirectToRoute($"Administrador");
        }

        private void mostrarError()
        {
            lblMensajeModal.Text = "Error al borrar la venta";
            modalHeader.Attributes["class"] = "modal-header bg-danger text-white";
            btnCerrarModal.Visible = true;
            btnVolverAlPanel.Visible = false;
            modalBody.Visible = false;

            ScriptManager.RegisterStartupScript(this, this.GetType(), "mostrarModal",
            "$('#modalConfirmacion').modal('show');", true);
        }

        private void mostrarMensajeExito()
        {
            lblMensajeModal.Text = "Venta borrada correctamente";
            modalHeader.Attributes["class"] = "modal-header bg-success text-white";
            btnCerrarModal.Visible = true;
            btnVolverAlPanel.Visible = false;
            modalBody.Visible = false;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "mostrarModal",
            "$('#modalConfirmacion').modal('show');", true);
        }
    }
}