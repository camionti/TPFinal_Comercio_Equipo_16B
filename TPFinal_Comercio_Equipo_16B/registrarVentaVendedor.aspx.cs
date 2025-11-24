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
                LimpiarProducto();
                LimpiarCliente();
                LimpiarListaDetalles();
            }
            ActualizarEstadoUI();
        }

        private void CargarProductos()
        {
            ProductosNegocio conexionProductos = new ProductosNegocio();
            List<Producto> lista = conexionProductos.Listar();
            Session["listaProductos"] = lista;
            ddlProductos.DataSource = lista;
            ddlProductos.DataTextField = "Nombre";      // lo que se muestra
            ddlProductos.DataValueField = "IdProducto"; // lo que devuelve
            ddlProductos.DataBind();

            //Cargo manualmente el 1er item para que no muestre ningun producto existente
            ddlProductos.Items.Insert(0, new ListItem("Seleccione un producto", "0"));
        }

        protected void ddlProductos_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlProductos.SelectedValue == "0")
            {
                // Limpio textbox si no hay seleccion
                LimpiarProducto();
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
                Session["clienteSeleccionado"] = null;
                ActualizarEstadoUI();
                return;
            }

            int idCliente = int.Parse(ddlClientes.SelectedValue);

            var lista = Session["listaClientes"] as List<Cliente>;
            var cliente = lista.Find(c => c.IdCliente == idCliente);
            if (cliente == null)
            {
                Session["clienteSeleccionado"] = null;
                ActualizarEstadoUI();
                return;
            }
            Session["clienteSeleccionado"] = cliente;
            ActualizarEstadoUI();
        }


        // ---------- Helpers ----------

        private List<DetalleVenta> DescargarDetallesDeSession()
        {
            if (Session["detallesVenta"] == null)
                Session["detallesVenta"] = new List<DetalleVenta>();

            return (List<DetalleVenta>)Session["detallesVenta"];
        }

        private void ActualizarDetallesGrid()
        {
            var detalles = DescargarDetallesDeSession();
            gvDetalles.DataSource = detalles;
            gvDetalles.DataBind();
        }

        private void ActualizarProductoEnSession(Producto productoSeleccionado)
        {
            var listaProductos = Session["listaProductos"] as List<Producto>;

            if(listaProductos == null)
                listaProductos = new List<Producto>();

            int index = listaProductos.FindIndex(p => p.IdProducto == productoSeleccionado.IdProducto);


            if (index >= 0)
            {
                listaProductos[index] = productoSeleccionado;
                Session["listaProductos"] = listaProductos; 
            }
        }

        //  ---------- Validaciones ----------
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

            if(hayError)
                mostrarError();

            return hayError;
        }

        private bool HayStockDeProducto(Producto producto)
        {
            var detalles = DescargarDetallesDeSession();
            var detalleConProducto = detalles.FirstOrDefault(d => d.Producto.IdProducto == producto.IdProducto);

            int cantidadNueva = int.Parse(txtCantidad.Text);

            // Cantidad ya reservada en el carrito
            int cantidadEnCarrito = detalleConProducto != null ? detalleConProducto.Cantidad : 0;

            // Validación contra stock real del producto
            if (cantidadEnCarrito + cantidadNueva > producto.StockActual)
            {
                return false;
            }

            return true;
        }

        //  ---------- Limpieza de front ----------

        private void ActualizarEstadoUI()
        {
            var detalles = DescargarDetallesDeSession();
            bool hayProductos = detalles.Count > 0;
            Cliente clienteSeleccionado = Session["clienteSeleccionado"] as Cliente;
            Cliente clienteAceptado = Session["clienteAceptado"] as Cliente;

            bool hayCliente = clienteSeleccionado != null;
            bool hayClienteAceptado = clienteAceptado != null;

            // Una vez que hay productos → cliente fijo
            ddlClientes.Enabled = !hayProductos;

            // Botón agregar producto SOLO si hay cliente
            btnAgregarProducto.Enabled = hayClienteAceptado;

            // Botón "Generar venta" SOLO si hay cliente + productos
            btnAceptar.Enabled = hayCliente && hayProductos;

            //Boton aceptar cliente solo si hay cliente en elegido y no hay cliente aceptado
            btnAceptarCliente.Enabled = hayCliente && !hayClienteAceptado;

            //Boton cancelar cliente solo si hay cliente aceptado y no hay productos
            btnCancelarCliente.Enabled = hayClienteAceptado && !hayProductos;

            //Dropdown cliente solo si no hay cliente aceptado
            ddlClientes.Enabled = !hayClienteAceptado;

            //Dropdown productos solo si hay cliente aceptado
            ddlProductos.Enabled = hayClienteAceptado;

        }

        private void LimpiarProducto()
        {
            txtCategoria.Text = "";
            txtMarca.Text = "";
            txtStock.Text = "";
            txtPorcentajeGanancia.Text = "";

            ddlProductos.ClearSelection();
            ddlProductos.SelectedIndex = 0;
            Session["productoSeleccionado"] = null;
        }

        private void LimpiarCliente()
        {
            ddlClientes.ClearSelection();
            ddlClientes.SelectedIndex = 0;
            Session["clienteSeleccionado"] = null;
            Session["clienteAceptado"] = null;
        }
        
        private void LimpiarListaDetalles()
        {
            Session["detallesVenta"] = null;
        }

        // ---------- GridView: quitar ítems ----------

        protected void gvDetalles_RowCommand(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Quitar")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                var listaDetallesVenta = DescargarDetallesDeSession();

                if (index >= 0 && index < listaDetallesVenta.Count)
                {
                    listaDetallesVenta.RemoveAt(index);
                    Session["detallesVenta"] = listaDetallesVenta;
                    ActualizarDetallesGrid();
                }
            }

            ActualizarEstadoUI();
        }

        // ------------ BOTONES ------------
        protected void btnAceptarCliente_Click(object sender, EventArgs e)
        {
            Cliente clienteSeleccionado = Session["clienteSeleccionado"] as Cliente;

            Session["clienteAceptado"] = clienteSeleccionado;

            ActualizarEstadoUI();
        }
        protected void btnCancelarCliente_Click(object sender, EventArgs e)
        {
            LimpiarCliente();
            ActualizarEstadoUI();
        }

        protected void btnAgregarProducto_Click(object sender, EventArgs e)
        {
            //Valido errores del front
            lblMensajeError.Text = "";
            if (validarInputs())
                return;

            Producto productoSeleccionado = Session["productoSeleccionado"] as Producto;
            int cantidad = int.Parse(txtCantidad.Text);

            //Valido si hay stock en tiempo real (Session)
            if(!HayStockDeProducto(productoSeleccionado))
            {
                lblMensajeError.Text = "No hay suficiente stock para agregar esa cantidad.";
                mostrarError();
                return;
            }

            var detallesVenta = DescargarDetallesDeSession();

            // Si el producto ya está en la lista, sumo cantidades
            var existente = detallesVenta.Find(d => d.Producto.IdProducto == productoSeleccionado.IdProducto);
            if (existente != null)
            {
                existente.Cantidad += cantidad;
            }
            //Sino, creo que producto nuevo y lo agrego a la lista
            else
            {
                DetalleVenta detalle = new DetalleVenta();
                detalle.Producto = productoSeleccionado;
                detalle.Cantidad = cantidad;
                detalle.PrecioUnitario = productoSeleccionado.Precio;

                detallesVenta.Add(detalle);
            }
            //Actualizo producto en Session
            productoSeleccionado.StockActual = productoSeleccionado.StockActual - cantidad;
            ActualizarProductoEnSession(productoSeleccionado);

            //Guardo la lista de Detalles Venta en Session y actualizo el grid
            Session["detallesVenta"] = detallesVenta;
            ActualizarDetallesGrid();

            //Limpio el front
            txtCantidad.Text = "";
            LimpiarProducto();
            ActualizarEstadoUI();
        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            try
            {
                // Obtener cliente aceptado
                Cliente cliente = Session["clienteAceptado"] as Cliente;
                if (cliente == null)
                {
                    lblMensajeError.Text = "No se seleccionó un cliente.";
                    mostrarError();
                    return;
                }

                // Obtener detalles del carrito (Session)
                List<DetalleVenta> detalles = DescargarDetallesDeSession();
                if (detalles.Count == 0)
                {
                    lblMensajeError.Text = "No hay productos en la venta.";
                    mostrarError();
                    return;
                }

                if (Session["id"] == null)
                {
                    throw new Exception("No se pudo obtener el usuario logueado.");
                }
                int idUsuario = (int)Session["id"];


                // Creo la Venta
                Venta venta = new Venta();
                venta.Cliente = cliente;
                venta.Usuario = new Usuario { IdUsuario = idUsuario };
                venta.Fecha = DateTime.Now;

                VentaNegocio negocio = new VentaNegocio();
                negocio.Agregar(venta, detalles);

                lblMensajeModal.Text = "Venta generada correctamente.";
                mostrarMensajeExito();

                // Limpio la session
                Session["detallesVenta"] = null;
                Session["clienteAceptado"] = null;
                Session["clienteSeleccionado"] = null;

                //Limpio el front
                ActualizarEstadoUI();
                ActualizarDetallesGrid();
            }
            catch (Exception ex)
            {
                lblMensajeError.Text = ex.Message;
                mostrarError();
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.RedirectToRoute($"VendedorRegistroVentas");

        }

        protected void btnVolverAlPanel_Click(object sender, EventArgs e)
        {
            Response.RedirectToRoute($"VendedorRegistroVentas");
        }

        //Condiguración del modal

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