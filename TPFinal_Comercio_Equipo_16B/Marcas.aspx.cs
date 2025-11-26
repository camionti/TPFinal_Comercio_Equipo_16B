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
    public partial class Marcas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                cargarMarcas();
            }
        }
        //CARGA LA LISTA
        private void cargarMarcas()
        {
            MarcaNegocio negocio = new MarcaNegocio();

            try
            {
                gvMarcas.DataSource = negocio.Listar();
                gvMarcas.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error al cargar marca: " + ex.Message + "');</script>");
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
            if (!Page.IsValid)
                return;
            Marca nuevo = new Marca();
            nuevo.Nombre = txtNombreAgregar.Text;

            MarcaNegocio negocio = new MarcaNegocio();
            negocio.Agregar(nuevo);

            cargarMarcas();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Hide", "$('#modalAgregar').modal('hide');", true);
        }

        //MODAL MODIFICAR
        protected void btnModificar_Click(object sender, EventArgs e)
        {
            if (gvMarcas.SelectedRow != null)
            {
                int IdMarca = Convert.ToInt32(gvMarcas.SelectedDataKey.Value);

                MarcaNegocio negocio = new MarcaNegocio();
                var marca = negocio.ObtenerMarcaPorID(IdMarca);

                hfIdMarca.Value = marca.IdMarca.ToString();
                txtNombre.Text = marca.Nombre;


                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#modalEditar').modal('show');", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Seleccione una marca primero');", true);
            }
        }
        //GUARGA LO DEL MODAL MODIFICAR
        protected void btnGuardarEditar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;
            MarcaNegocio negocio = new MarcaNegocio();
            Marca marca = new Marca();

            marca.IdMarca = int.Parse(hfIdMarca.Value);
            marca.Nombre = txtNombre.Text;


            negocio.Modificar(marca);
            cargarMarcas();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Hide", "$('#modalEditar').modal('hide');", true);
        }

        //ELIMINA PROVEEDOR
        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            MarcaNegocio negocio = new MarcaNegocio();

            try
            {
                int id = Convert.ToInt32(gvMarcas.SelectedDataKey.Value);
                negocio.Eliminar(id);

                // Recarga la lista
                cargarMarcas();
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

        protected void gvMarcas_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idSeleccionado = (int)gvMarcas.SelectedDataKey.Value;
            ViewState["idMarcaSeleccionado"] = idSeleccionado;
        }

        protected void gvMarcas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int IdMarca = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Editar")
            {
                hfIdMarca.Value = IdMarca.ToString();

                // Cargar descripción
                MarcaNegocio negocio = new MarcaNegocio();
                var cat = negocio.ObtenerMarcaPorID(IdMarca);

                txtNombre.Text = cat.Nombre;

                ScriptManager.RegisterStartupScript(this, GetType(), "modalEditar",
                    "$('#modalEditar').modal('show');", true);
            }

            if (e.CommandName == "Borrar")
            {
                MarcaNegocio negocio = new MarcaNegocio();
                negocio.Eliminar(IdMarca);

                cargarMarcas();
            }
        }


    }
}
