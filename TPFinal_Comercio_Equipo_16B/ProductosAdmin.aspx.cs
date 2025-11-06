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
    public partial class ProductosAdmin : System.Web.UI.Page
    {
        public List<Producto> listaProducto { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarLista();
                DataBind();
            }
        }

        private void CargarLista()
        {
            try
            {
                ProductosNegocio conexionProducto = new ProductosNegocio();
                listaProducto = conexionProducto.Listar();

                if (!IsPostBack)
                {
                    gvProductos.DataSource = listaProducto;
                    gvProductos.DataBind();
                }
            }
            catch (Exception)
            {

                Response.Redirect("~/Error.aspx");
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
                    try
                    {
                        ProductosNegocio conexionProductos = new ProductosNegocio();
                        conexionProductos.eliminar(id);
                        CargarLista();
                        break;

                    }
                    catch (Exception)
                    {
                        Response.Redirect("~/Error.aspx");
                    }
                    break;
            }

        }
    }
}