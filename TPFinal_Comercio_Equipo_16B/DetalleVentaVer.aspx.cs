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

            if (IsPostBack) return;

            //Obtener el id desde la ruta
            string idStr = Request.QueryString["id"];

            if (!int.TryParse(idStr, out int id))
            {
                //Si no puede parsear el ID vuelve a la pagina anterior del historial
                ScriptManager.RegisterStartupScript(this, GetType(), "historyBack", "history.back();", true);
            }

            var negocioVenta = new VentaNegocio();
            var negocioDetalleVenta = new DetalleVentaNegocio();
            var productoNegocio = new ProductosNegocio();
            var usuarioNegocio = new UsuarioNegocio();
            var clienteNegocio = new ClienteNegocio();


            Venta venta = negocioVenta.Buscar(id)[0];
            DetalleVenta detalleVenta = negocioDetalleVenta.ListarPorVenta(id)[0];
            Producto producto = productoNegocio.buscar(detalleVenta.Producto.IdProducto)[0];
            Cliente cliente = clienteNegocio.ObtenerClientePorID(venta.Cliente.IdCliente);
            Usuario vendedor = usuarioNegocio.BuscarPorId(venta.Usuario.IdUsuario);


            if (detalleVenta == null || venta == null || producto==null || cliente == null || vendedor == null)
            {
                Response.Redirect("~/Error.aspx");
                return;
            }


            if (producto == null || venta == null || detalleVenta == null)
            {
                Response.Redirect("~/Error.aspx");
                return;
            }

            lblVendedor.InnerText = vendedor.NombreUsuario;
            lblCliente.InnerText = cliente.Nombre;
            lblNombreProducto.InnerText = producto.Nombre;
            lblCantidad.InnerText = detalleVenta.Cantidad.ToString();
            lblPrecio.InnerText = detalleVenta.PrecioUnitario.ToString("N0");

            //lblPrecio.InnerText = "U$D " + producto.Precio.ToString("N0");


        }
    }
}