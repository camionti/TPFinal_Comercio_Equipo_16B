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
                CargarProductos();
            }
        }

        private void CargarProveedores()
        {
            ProveedorNegocio negocio = new ProveedorNegocio();
            ddlProveedores.DataSource = negocio.Listar();
            ddlProveedores.DataTextField = "Nombre";
            ddlProveedores.DataValueField = "IdProveedor";
            ddlProveedores.DataBind();
        }

        private void CargarProductos()
        {
            ProductosNegocio negocio = new ProductosNegocio();
            ddlProductos.DataSource = negocio.Listar();
            ddlProductos.DataTextField = "Nombre";
            ddlProductos.DataValueField = "IdProducto";
            ddlProductos.DataBind();
        }

        protected void btnAgregarDetalle_Click(object sender, EventArgs e)
        {
            ProductosNegocio prodNeg = new ProductosNegocio();
            Producto p = prodNeg.BuscarPorId(int.Parse(ddlProductos.SelectedValue));

            DetalleCompra det = new DetalleCompra();
            det.Producto = p;
            det.Cantidad = int.Parse(txtCantidad.Text);
            det.PrecioUnitario = decimal.Parse(txtPrecio.Text);
            decimal subtotalCalculado = det.Subtotal;

            Detalles.Add(det);

            gvDetalles.DataSource = Detalles;
            gvDetalles.DataBind();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            Compra compra = new Compra();
            compra.Fecha = DateTime.Today;
            compra.Proveedor = new Proveedor { IdProveedor = int.Parse(ddlProveedores.SelectedValue) };
            compra.Detalles = Detalles;

            Usuario usuario = (Usuario)Session["usuario"];
            compra.IdUsuario = usuario.IdUsuario;

            CompraNegocio negocio = new CompraNegocio();
            negocio.AgregarCompra(compra);

            
            Session["DetallesCompra"] = null;
            gvDetalles.DataSource = null;
            gvDetalles.DataBind();
        }
        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("DetalleCompras.aspx");
        }
    }
}
