using Dominio;
using Negocio;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPFinal_Comercio_Equipo_16B
{
    public partial class registrarVentaVendedor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                CargarProductos();
                CargarClientes();
            }
        }

        private void CargarProductos()
        {
            ProductosNegocio conexionProductos = new ProductosNegocio();
            List<Producto> lista = conexionProductos.Listar();
            Session["listaProductos"] = lista;
            ddlProductos.DataSource = lista;
            ddlProductos.DataTextField = "Nombre";
            ddlProductos.DataValueField = "IdProducto";
            ddlProductos.DataBind();

            //Cargo manualmente el 1er item para que no muestre ningun producto existente
            ddlProductos.Items.Insert(0, new ListItem("Seleccione un producto", "0"));
        }

        protected void ddlProductos_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlProductos.SelectedValue == "0")
            {
                // Limpio textbox si no hay seleccion
                txtCategoria.Text = "";
                txtMarca.Text = "";
                txtStock.Text = "";
                txtPorcentajeGanancia.Text = "";
                return;
            }

            var lista = Session["listaProductos"] as List<Producto>;
            if (lista == null) return;

            int idSeleccionado = int.Parse(ddlProductos.SelectedValue);

            Producto seleccionado = lista.Find(p => p.IdProducto == idSeleccionado);
            if (seleccionado == null) return;

            txtCategoria.Text = seleccionado.Categoria.Descripcion;
            txtMarca.Text = seleccionado.Marca.Nombre;
            txtStock.Text = seleccionado.StockActual.ToString();
            txtPorcentajeGanancia.Text = seleccionado.PorcentajeGanancia.ToString();

            Session["productoSeleccionado"] = seleccionado;
        }

        private void CargarClientes()
        {
            ClienteNegocio clienteConexion = new ClienteNegocio();
            var lista = clienteConexion.Listar(); // lista de Cliente

            Session["listaClientes"] = lista;

            ddlClientes.DataSource = lista;
            ddlClientes.DataTextField = "Nombre";      // lo que se muestra
            ddlClientes.DataValueField = "IdCliente";  // lo que devuelve
            ddlClientes.DataBind();

            ddlClientes.Items.Insert(0, new ListItem("Seleccione un cliente", "0"));
        }

        protected void ddlClientes_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlClientes.SelectedValue == "0")
            {
                return;
            }

            int idCliente = int.Parse(ddlClientes.SelectedValue);

            var lista = Session["listaClientes"] as List<Cliente>;
            var cliente = lista.Find(c => c.IdCliente == idCliente);
            if (cliente == null) return;

            Session["clienteSeleccionado"] = cliente;

        }


        protected void btnAceptar_Click(object sender, EventArgs e)
        {

            bool hayInputsVacios = validarInputs();
            if (hayInputsVacios) return;

            int IdProductoSeleccionado = int.Parse(ddlProductos.SelectedValue);
            ProductosNegocio productoConexion = new ProductosNegocio();
            Producto productoSeleccionado = productoConexion.buscar(IdProductoSeleccionado)[0];

            Cliente cliente = Session["clienteSeleccionado"] as Cliente;
            VentaNegocio conexionVentas = new VentaNegocio();


            Venta venta = new Venta();
            venta.Fecha = DateTime.Now;
            venta.Cliente = new Cliente();
            venta.Usuario = new Usuario();
            venta.Cliente.IdCliente = cliente.IdCliente;
            venta.Usuario.IdUsuario = int.Parse(Session["id"] as String);
            venta.Total = productoSeleccionado.Precio * int.Parse(txtCantidad.Text);

            int idVenta = conexionVentas.Agregar(venta);

            if (idVenta <= 0)
            {
                lblMensajeError.Text = "No se pudo registrar la venta.";

                mostrarError();

                return;
            }

            DetalleVentaNegocio conexionDetalle = new DetalleVentaNegocio();
            DetalleVenta detalle = new DetalleVenta();

            detalle.IdVenta = idVenta;
            detalle.Producto = new Producto();
            detalle.Producto.IdProducto = int.Parse(ddlProductos.SelectedValue);
            detalle.Cantidad = int.Parse(txtCantidad.Text);
            detalle.PrecioUnitario = productoSeleccionado.Precio;

            conexionDetalle.Agregar(detalle);

            productoConexion.DescontarStock(detalle.Producto.IdProducto, detalle.Cantidad);

            lblMensajeModal.Text = "Venta y DetalleVenta creados correctamente";
            mostrarMensajeExito();
        }

        protected bool validarInputs()
        {
            bool hayError = false;

            if (Session["productoSeleccionado"] as Producto == null)
            {
                lblMensajeError.Text += "No se selecciono ningun producto<br/>";
                hayError = true;
            }

            if (!int.TryParse(txtStock.Text, out int stock))
            {
                lblMensajeError.Text += "El stock debe ser un número válido.<br/>";
                hayError = true;
            }

            if (!int.TryParse(txtCantidad.Text, out int cantidad))
            {
                lblMensajeError.Text += "La cantidad debe ser un número válido.<br/>";
                hayError = true;
            }

            if (Session["clienteSeleccionado"] as Cliente == null)
            {
                lblMensajeError.Text += "No se puede encontrar el cliente<br/>";
                hayError = true;
            }

            if ( stock <= 0)
            {
                lblMensajeError.Text += "No se puede vender un auto sin stock<br/>";
                hayError = true;
            }

            if (cantidad <= 0)
            {
                lblMensajeError.Text += "No se puede vender un auto con cantidad 0 o negativa<br/>";
                hayError = true;
            }

            if (cantidad > stock)
            {
                lblMensajeError.Text += "No hay suficientes productos<br/>";
                hayError = true;
            }

            mostrarError();

            return hayError;
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.RedirectToRoute($"VendedorRegistroVentas");

        }

        protected void btnVolverAlPanel_Click(object sender, EventArgs e)
        {
            Response.RedirectToRoute($"VendedorRegistroVentas");
        }

        private void mostrarError()
        {
            lblMensajeModal.Text = "Errores encontrados";
            modalHeader.Attributes["class"] = "modal-header bg-danger text-white";
            btnCerrarModal.Visible = true;
            btnVolverAlPanel.Visible = false;
            modalBody.Visible = true;

            ScriptManager.RegisterStartupScript(this, this.GetType(), "mostrarModal",
            "$('#modalConfirmacion').modal('show');", true);
        }

        private void mostrarMensajeExito()
        {

            lblMensajeModal.Text = "Venta creada correctamente";
            modalHeader.Attributes["class"] = "modal-header bg-success text-white";
            btnCerrarModal.Visible = false;
            btnVolverAlPanel.Visible = true;
            modalBody.Visible = false;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "mostrarModal",
            "$('#modalConfirmacion').modal('show');", true);
        }
    }
}