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
    public partial class RegistroCompras : System.Web.UI.Page
    {
        protected List<DetalleCompra> Detalles
        {
            get
            {
                if (Session["DetalleCompra"] == null)
                    Session["DetalleCompra"] = new List<DetalleCompra>();

                return (List<DetalleCompra>)Session["DetalleCompra"];
            }
            set { Session["DetalleCompra"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarProveedores();
                CargarProductosPorProveedor(null);
                LimpiarProveedores();
                LimpiarProductos();
                LimpiarListaDetalles();
            }
            ActualizarEstadoUI();
        }

        private void CargarProveedores()
        {
            ProveedorNegocio negocio = new ProveedorNegocio();
            List<Proveedor> listaProveedores = negocio.Listar();
            ddlProveedores.DataSource = listaProveedores;
            ddlProveedores.DataTextField = "Nombre";
            ddlProveedores.DataValueField = "IdProveedor";
            ddlProveedores.DataBind();
            ddlProveedores.Items.Insert(0, new ListItem("Seleccione un proveedor", "0"));
            Session["listaProveedores"] = listaProveedores;
        }

        private void CargarProductosPorProveedor(int? IdProveedor)
        {
            if(IdProveedor == null)
            {
                ddlProductos.Items.Insert(0, new ListItem("Seleccione un producto", "0"));
            }
            else
            { 
                try
                {
                    ProductosNegocio negocio = new ProductosNegocio();
                    List<Producto> listaProductos = negocio.BuscarPorProveedor(int.Parse(IdProveedor.ToString()));
                    ddlProductos.DataSource = listaProductos;
                    ddlProductos.DataTextField = "Nombre";
                    ddlProductos.DataValueField = "IdProducto";
                    ddlProductos.DataBind();
                    ddlProductos.Items.Insert(0, new ListItem("Seleccione un producto", "0"));
                    Session["listaProductos"] = listaProductos;
                }
                catch (Exception)
                {
                    throw;
                }
            }

        }

        private void ActualizarEstadoUI()
        {
           
            Proveedor proveedorSeleccionado = Session["proveedorSeleccionado"] as Proveedor;
            
            bool hayProveedor = proveedorSeleccionado != null;
            bool hayProductos = Detalles.Count > 0;

            // Botón "Generar compra" SOLO si hay proveedor + productos
            btnGuardarCompra.Enabled = hayProveedor && hayProductos;

            //Boton aceptar cliente solo si no hay proveedor elegido y no hay productos
            btnAceptarProveedor.Enabled = !hayProveedor && !hayProductos && ddlProveedores.SelectedValue != "0";

            //Boton cancelar proveedor solo si hay proveedor aceptado y no hay productos
            btnCancelarProveedor.Enabled = hayProveedor && !hayProductos && ddlProveedores.SelectedIndex > 0;

            //Dropdown proveedor solo si no hay proveedor aceptado
            ddlProveedores.Enabled = !hayProveedor;

            //Dropdown productos solo si hay cliente aceptado
            ddlProductos.Enabled = hayProveedor;

            // Botón agregar producto SOLO si hay proveedor
            btnAgregarDetalle.Enabled = hayProveedor;

            //Txt Cantidad solo si hay proveedor
            txtCantidad.Enabled = hayProveedor;

            //Txt precio lo define el producto
            txtPrecio.Enabled = false;

            // Mostrar/ocultar lbl mensaje agregar proveedor
            lblAgregarProveedor.Visible = !hayProveedor;

            CambiarEstilosBotones(hayProveedor, hayProductos);

        }

        //Cambios de estilo CSS de botones
        private void CambiarEstilosBotones(bool hayProveedor, bool hayProductos)
        {

            if (hayProveedor && hayProductos)
                btnGuardarCompra.CssClass = "btn btn-primary";
            else
                btnGuardarCompra.CssClass = "btn btn-secondary";

            if (!hayProveedor && !hayProductos && ddlProveedores.SelectedValue != "0")
                btnAceptarProveedor.CssClass = "btn btn-success";
            else
                btnAceptarProveedor.CssClass = "btn btn-secondary";

            if(hayProveedor && !hayProductos && ddlProveedores.SelectedIndex > 0)
                btnCancelarProveedor.CssClass = "btn btn-danger ml-4";
            else
                btnCancelarProveedor.CssClass = "btn btn-secondary ml-4";

            if (hayProveedor)
                btnAgregarDetalle.CssClass = "btn btn-block btn-success";
            else
                btnAgregarDetalle.CssClass = "btn btn-block btn-secondary";
        }

        private void LimpiarProveedores()
        {
            ddlProveedores.ClearSelection();
            ddlProveedores.SelectedIndex = 0;
            Session["proveedorSeleccionado"] = null;
        }

        private void LimpiarProductos()
        {
            ddlProductos.ClearSelection();
            ddlProductos.SelectedIndex = 0;
            txtCantidad.Text = "";
            txtPrecio.Text = "";
            Session["productoSeleccionado"] = null;
        }

        private void LimpiarListaDetalles()
        {
            Session["DetalleCompra"] = null;
            Detalles.Clear();
            gvDetalles.DataSource = Detalles;
            gvDetalles.DataBind();
            ActualizarTotalCompra();
            ActualizarEstadoUI();
        }

        private void ActualizarTotalCompra()
        {
            decimal total = Detalles.Sum(d => d.Subtotal);
            lblTotal.InnerText ="$ " + total.ToString("0.00");
        }

        // ---------- Selected Index Changed ----------

        protected void ddlProveedores_SelectedIndexChanged(object sender, EventArgs e)
        {
            ActualizarEstadoUI();
        }

        protected void ddlProductos_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlProductos.SelectedValue == "0")
            {
                // Limpio textbox si no hay seleccion
                LimpiarProductos();
                return;
            }

            int idSeleccionado = int.Parse(ddlProductos.SelectedValue);
            var listaProductos = Session["listaProductos"] as List<Producto>;

            Producto seleccionado = listaProductos.Find(p => p.IdProducto == idSeleccionado);
            if (seleccionado == null) return;

            txtPrecio.Text = seleccionado.Precio.ToString();
            txtCantidad.Text = "1";

            Session["productoSeleccionado"] = seleccionado;
        }

        // ---------- GridView: quitar ítems ----------

        protected void gvDetalles_RowCommand(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Quitar")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                if (index >= 0 && index < Detalles.Count)
                {
                    Detalles.RemoveAt(index);
                    gvDetalles.DataSource = Detalles;
                    gvDetalles.DataBind();
                    ActualizarTotalCompra();
                    ActualizarEstadoUI();
                }
            }
            ActualizarEstadoUI();
        }

        
        // ---------- Botones ----------

        protected void btnAceptarProveedor_Click(object sender, EventArgs e)
        {
            int idProveedor = int.Parse(ddlProveedores.SelectedValue);

            var lista = Session["listaProveedores"] as List<Proveedor>;
            var proveedor = lista.Find(p => p.IdProveedor == idProveedor);

            Session["proveedorSeleccionado"] = proveedor;
            CargarProductosPorProveedor(proveedor.IdProveedor);
            ActualizarEstadoUI();
        }

        protected void btnCancelarProveedor_Click(object sender, EventArgs e)
        {
            LimpiarProveedores();
            ActualizarEstadoUI();
        }



        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("DetalleCompras.aspx");

        }
        protected void btnAgregarDetalle_Click(object sender, EventArgs e)
        {

            if (validarInputs())
                return;

            ProductosNegocio prodNeg = new ProductosNegocio();
            Producto p = prodNeg.BuscarPorId(int.Parse(ddlProductos.SelectedValue));

            // Si el producto ya está en la lista, sumo cantidades
            var existente = Detalles.Find(d => d.Producto.IdProducto == p.IdProducto);
            if (existente != null)
            {
                existente.Cantidad += int.Parse(txtCantidad.Text);
            }
            //Sino, creo que producto nuevo y lo agrego a la lista
            else
            {
                DetalleCompra det = new DetalleCompra();
                det.Producto = p;
                det.Cantidad = int.Parse(txtCantidad.Text);
                det.PrecioUnitario = decimal.Parse(txtPrecio.Text);
                Detalles.Add(det);
            }

            gvDetalles.DataSource = Detalles;
            gvDetalles.DataBind();
            gvDetallesConfirmar.DataSource = Detalles;
            gvDetallesConfirmar.DataBind();

            ActualizarTotalCompra();

            LimpiarProductos();
            ActualizarEstadoUI();
        }
        protected void btnGuardarCompra_Click(object sender, EventArgs e)
        {
            MostrarMensajeConConfirmacion();
        }

        protected void btnConfirmarCompra_Click(object sender, EventArgs e)
        {
            Compra compra = new Compra();
            compra.Fecha = DateTime.Today;
            compra.Proveedor = new Proveedor { IdProveedor = int.Parse(ddlProveedores.SelectedValue) };

            if (compra.Proveedor == null)
            {
                lblMensajeError.Text = "No se seleccionó un proveedor.";
                mostrarError();
                return;
            }

            compra.Detalles = Detalles;

            if (compra.Detalles.Count == 0)
            {
                lblMensajeError.Text = "No hay productos en la compra.";
                mostrarError();
                return;
            }

            if (Session["usuario"] == null)
            {
                lblMensajeError.Text = "No hay un usuario logeado.";
                mostrarError();
                return;
            }

            Usuario usuario = (Usuario)Session["usuario"];
            compra.IdUsuario = usuario.IdUsuario;

            CompraNegocio negocio = new CompraNegocio();
            negocio.AgregarCompra(compra);


            Session["DetallesCompra"] = null;
            gvDetalles.DataSource = null;
            gvDetalles.DataBind();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            MostrarMensajeConConfirmacion();
        }
        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("DetalleCompras.aspx");
        }

        protected void btnVolverAlPanel_Click(object sender, EventArgs e)
        {
            Response.Redirect("DetalleCompras.aspx");
        }

        // ---------- Validaciones ----------

        protected bool validarInputs()
        {
            bool hayError = false;

            if (Session["productoSeleccionado"] as Producto == null)
            {
                lblMensajeError.Text += "No se selecciono ningun producto<br/>";
                hayError = true;
            }


            if (!int.TryParse(txtCantidad.Text, out int cantidad))
            {
                lblMensajeError.Text += "La cantidad debe ser un número válido.<br/>";
                hayError = true;
            }

            if (!int.TryParse(txtPrecio.Text, out int precio))
            {
                lblMensajeError.Text += "El precio debe ser un número válido.<br/>";
                hayError = true;
            }

            if (Session["proveedorSeleccionado"] as Proveedor == null)
            {
                lblMensajeError.Text += "No se puede encontrar el proveedor<br/>";
                hayError = true;
            }

            if (cantidad <= 0)
            {
                lblMensajeError.Text += "No se puede comprar un producto con cantidad 0 o negativa<br/>";
                hayError = true;
            }

            if (precio <= 0)
            {
                lblMensajeError.Text += "No se puede comprar un producto con precio 0 o negativo<br/>";
                hayError = true;
            }

            if (hayError)
                mostrarError();

            return hayError;
        }

        private void mostrarError()
        {
            lblMensajeModal.Text = "Errores encontrados";
            modalHeader.Attributes["class"] = "modal-header bg-danger text-white";
            btnCerrarModal.Visible = true;
            btnVolverAlPanel.Visible = false;
            modalBody.Visible = true;
            btnConfirmarCompra.Visible = false;
            modalBodyGrid.Visible = false;

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
            btnConfirmarCompra.Visible = false;
            modalBodyGrid.Visible = false;

            ScriptManager.RegisterStartupScript(this, this.GetType(), "mostrarModal",
            "$('#modalConfirmacion').modal('show');", true);
        }

        private bool MostrarMensajeConConfirmacion()
        {
            lblMensajeModal.Text = "Usted va a generar la siguiente compra";
            modalHeader.Attributes["class"] = "modal-header bg-primary text-white";
            btnCerrarModal.Visible = true;
            btnConfirmarCompra.Visible = true;
            btnVolverAlPanel.Visible = false;
            modalBody.Visible = false;
            modalBodyGrid.Visible = true;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "mostrarModal",
            "$('#modalConfirmacion').modal('show');", true);

            return false;
        }
        
    }
}
