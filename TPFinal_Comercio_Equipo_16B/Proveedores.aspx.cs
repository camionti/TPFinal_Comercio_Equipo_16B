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
    public partial class Proveedores : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                cargarProveedores();
            }
        }
        //CARGA LA LISTA
        private void cargarProveedores()
        {
            ProveedorNegocio negocio = new  ProveedorNegocio();

            try
            {
                gvProveedores.DataSource = negocio.Listar();
                gvProveedores.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error al cargar proveedor: " + ex.Message + "');</script>");
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
            Proveedor nuevo = new Proveedor();
            nuevo.Nombre = txtNombreAgregar.Text;
            nuevo.Telefono = txtTelefonoAgregar.Text;
            nuevo.Email = txtEmailAgregar.Text;

            ProveedorNegocio negocio = new ProveedorNegocio();
            negocio.Agregar(nuevo);

            cargarProveedores();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Hide", "$('#modalAgregar').modal('hide');", true);
        }

        //MODAL MODIFICAR
        protected void btnModificar_Click(object sender, EventArgs e)
        {
            if (gvProveedores.SelectedRow != null)
            {
                int idProveedor = Convert.ToInt32(gvProveedores.SelectedDataKey.Value);

                ProveedorNegocio negocio = new ProveedorNegocio();
                var proveedor = negocio.ObtenerProveedorPorID(idProveedor);

                hfIdProveedor.Value = proveedor.IdProveedor.ToString();
                txtNombre.Text = proveedor.Nombre;
                txtTelefono.Text = proveedor.Telefono;
                txtEmail.Text = proveedor.Email;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#modalEditar').modal('show');", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Seleccione un proveedor primero');", true);
            }
        }
        //GUARGA LO DEL MODAL MODIFICAR
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            ProveedorNegocio negocio = new ProveedorNegocio();
            Proveedor proveedor = new Proveedor();

            proveedor.IdProveedor = int.Parse(hfIdProveedor.Value);
            proveedor.Nombre = txtNombre.Text;
            proveedor.Telefono = txtTelefono.Text;
            proveedor.Email = txtEmail.Text;

            negocio.Modificar(proveedor);
            cargarProveedores();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Hide", "$('#modalEditar').modal('hide');", true);
        }

        //ELIMINA PROVEEDOR
        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            if (gvProveedores.SelectedDataKey != null)
            {
                int IdProveedor = (int)gvProveedores.SelectedDataKey.Value;

                ProveedorNegocio negocio = new ProveedorNegocio();
                negocio.Eliminar(IdProveedor);

                cargarProveedores();
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Seleccione un proveedor primero');", true);
            }
        }

        //REDIRIGUE A LA PANTALLA ADMINISTRADOR
        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("Administrador.aspx");
        }

        protected void gvProveedores_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idSeleccionado = (int)gvProveedores.SelectedDataKey.Value;
            ViewState["IdClienteSeleccionado"] = idSeleccionado;
        }
    }
}