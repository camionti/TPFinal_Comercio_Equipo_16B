using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Negocio;

namespace TPFinal_Comercio_Equipo_16B
{
    public partial class Productos : System.Web.UI.Page
    {
        public List<Producto> listaProducto { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                ProductosNegocio conexionProducto = new ProductosNegocio();
                listaProducto = conexionProducto.Listar();

                if (!IsPostBack)
                {
                    repProductos.DataSource = listaProducto;
                    repProductos.DataBind();
                }
            }
            catch (Exception)
            {

                Response.Redirect("~/Error.aspx");
            }
        }
    }
}