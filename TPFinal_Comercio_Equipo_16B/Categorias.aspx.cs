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
    public partial class Categorias : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                cargarCategorias();
            }
        }
        //CARGA LA LISTA
        private void cargarCategorias()
        {
            CategoriaNegocio negocio = new CategoriaNegocio();

            try
            {
                gvCategorias.DataSource = negocio.Listar();
                gvCategorias.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error al cargar cartegorias: " + ex.Message + "');</script>");
            }
        }

        //BOTON AGREGAR
        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Show", "$('#modalAgregar').modal('show');", true);
        }

        //GUARDA LO QEU SE AGREGA
        protected void btnGuardarAgregar_Click(object sender, EventArgs e)
        {
            Categoria nuevo = new Categoria();
            nuevo.Descripcion = txtAgregar.Text;

            CategoriaNegocio negocio = new CategoriaNegocio();
            negocio.Agregar(nuevo);

            cargarCategorias();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Hide", "$('#modalAgregar').modal('hide');", true);
        }

        //MODAL MODIFICAR
        protected void btnModificar_Click(object sender, EventArgs e)
        {
            if (gvCategorias.SelectedRow != null)
            {
                int IdCategoria = Convert.ToInt32(gvCategorias.SelectedDataKey.Value);

                CategoriaNegocio negocio = new CategoriaNegocio();
                var categoria = negocio.ObtenerCategoriaPorID(IdCategoria);

                hfIdCategoria.Value = categoria.IdCategoria.ToString();
                txtDescripcion.Text = categoria.Descripcion;


                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#modalEditar').modal('show');", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Seleccione una categoria primero');", true);
            }
        }
        //GUARGA LO DEL MODAL MODIFICAR
        protected void btnGuardarEditar_Click(object sender, EventArgs e)
        {
            CategoriaNegocio negocio = new CategoriaNegocio();
            Categoria categoria = new Categoria();

            categoria.IdCategoria = int.Parse(hfIdCategoria.Value);
            categoria.Descripcion = txtDescripcion.Text;


            negocio.Modificar(categoria);
            cargarCategorias();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Hide", "$('#modalEditar').modal('hide');", true);
        }

        //ELIMINA PROVEEDOR
        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            CategoriaNegocio negocio = new CategoriaNegocio();

            try
            {
                int id = Convert.ToInt32(gvCategorias.SelectedDataKey.Value);
                negocio.Eliminar(id);

                // Recarga la lista
                cargarCategorias();
            }
            catch (Exception ex)
            {
                lblError.Text = "Hubo un error: " + ex.Message;
                lblError.Visible = true;
            }
        }

        //REDIRIGUE A LA PANTALLA ADMINISTRADOR
        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("Administrador.aspx");
        }

        protected void gvCategorias_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idSeleccionado = (int)gvCategorias.SelectedDataKey.Value;
            ViewState["idCategoriaSeleccionado"] = idSeleccionado;
        }

    }
}