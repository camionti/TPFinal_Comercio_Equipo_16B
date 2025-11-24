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
    public partial class DetalleVentaVer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                CargarDetalles();
            }

            ////Obtener el id desde la ruta
            //int IdVenta = ObtenerIdParametro();

            //var negocioVenta = new VentaNegocio();
            //var negocioDetalleVenta = new DetalleVentaNegocio();
            //var productoNegocio = new ProductosNegocio();
            //var usuarioNegocio = new UsuarioNegocio();
            //var clienteNegocio = new ClienteNegocio();

            ////Validar venta
            //var ventas = negocioVenta.Buscar(IdVenta);
            //if (ventas == null || ventas.Count == 0)
            //{
            //    Response.Redirect("~/Error.aspx");
            //    return;
            //}
            //Venta venta = ventas[0];

            ////Validar detalles
            //var detalles = negocioDetalleVenta.ListarPorVenta(IdVenta);
            //if (detalles == null || detalles.Count == 0)
            //{
            //    Response.Redirect("~/Error.aspx");
            //    return;
            //}
            //DetalleVenta detalleVenta = detalles[0];

            ////Validar producto
            //var productos = productoNegocio.buscar(detalleVenta.Producto.IdProducto);
            //if (productos == null || productos.Count == 0)
            //{
            //    Response.Redirect("~/Error.aspx");
            //    return;
            //}
            //Producto producto = productos[0];

            ////Validar cliente y usuario
            //Cliente cliente = clienteNegocio.ObtenerClientePorID(venta.Cliente.IdCliente);
            //Usuario vendedor = usuarioNegocio.BuscarPorId(venta.Usuario.IdUsuario);

            //if (cliente == null || vendedor == null)
            //{
            //    Response.Redirect("~/Error.aspx");
            //    return;
            //}

            //Cargo datos en el front
            //lblVendedor.InnerText = vendedor.NombreUsuario;
            //lblCliente.InnerText = cliente.Nombre;
            //lblNombreProducto.InnerText = producto.Nombre;
            //lblCantidad.InnerText = detalleVenta.Cantidad.ToString();
            //lblPrecio.InnerText = detalleVenta.PrecioUnitario.ToString("N0");

            //lblPrecio.InnerText = "U$D " + producto.Precio.ToString("N0");
        }

        private void CargarDetalles()
        {
            var detalles = ObtenerDetallesEnDB();
            repDetalles.DataSource = detalles;
            repDetalles.DataBind();
        }

        private List<DetalleVenta> ObtenerDetallesEnDB()
        {
            try
            {
                var detallesVentaConexion = new DetalleVentaNegocio();
                int IdVenta = ObtenerIdParametro();
                return detallesVentaConexion.ListarPorVenta(IdVenta);
            }
            catch (Exception)
            {
                throw;
            }
        }

        protected int ObtenerIdParametro()
        {
            string idStr = Request.QueryString["id"];

            if (!int.TryParse(idStr, out int id))
            {
                //Si no puede parsear el ID vuelve a la pagina anterior del historial
                ScriptManager.RegisterStartupScript(this, GetType(), "historyBack", "history.back();", true);
            }

            return id;
        }
    }
}