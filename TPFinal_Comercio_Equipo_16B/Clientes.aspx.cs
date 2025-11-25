using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;

namespace TPFinal_Comercio_Equipo_16B
{
    public partial class Clientes : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarClientes();
            }
        }
        private void cargarClientes()
        {
            ClienteNegocio negocio = new ClienteNegocio();

            try
            {
                gvClientes.DataSource = negocio.Listar();
                gvClientes.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error al cargar clientes: " + ex.Message + "');</script>");
            }
        }
        //MODAL AGREGAR
        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Show", "$('#modalAgregar').modal('show');", true);
        }
        //BOTON AGREGAR CLIENTE
        protected void btnGuardarAgregar_Click(object sender, EventArgs e)
        {
            Cliente nuevo = new Cliente();
            nuevo.Nombre = txtNombreAgregar.Text;
            nuevo.Telefono = txtTelefonoAgregar.Text;
            nuevo.Email = txtEmailAgregar.Text;

            ClienteNegocio negocio = new ClienteNegocio();
            negocio.Agregar(nuevo);

            cargarClientes();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Hide", "$('#modalAgregar').modal('hide');", true);
        }
        //ABRE EL MODAL MODIFICAR
        protected void btnModificar_Click(object sender, EventArgs e)
        {
            if (gvClientes.SelectedRow != null)
            {
                int idCliente = Convert.ToInt32(gvClientes.SelectedDataKey.Value);

                ClienteNegocio negocio = new ClienteNegocio();
                var cliente = negocio.ObtenerClientePorID(idCliente);

                hfIdCliente.Value = cliente.IdCliente.ToString();
                txtNombre.Text = cliente.Nombre;
                txtTelefono.Text = cliente.Telefono;
                txtEmail.Text = cliente.Email;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#modalEditar').modal('show');", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Seleccione un cliente primero');", true);
            }
        }

        //GUARDA LO DEL MODAL MODIFICAR
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            ClienteNegocio negocio = new ClienteNegocio();
            Cliente cliente = new Cliente();

            cliente.IdCliente = int.Parse(hfIdCliente.Value);
            cliente.Nombre = txtNombre.Text;
            cliente.Telefono = txtTelefono.Text;
            cliente.Email = txtEmail.Text;

            negocio.Modificar(cliente);
            cargarClientes();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Hide", "$('#modalEditar').modal('hide');", true);
        }

        //ELIMINA UN CLIENTE
        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            if (ViewState["IdClienteSeleccionado"] != null)
            {
                int idCliente = (int)ViewState["IdClienteSeleccionado"];

                ClienteNegocio negocio = new ClienteNegocio();
                negocio.Eliminar(idCliente);

                cargarClientes(); // recargar lista
            }
        }

        //REDIRIGUE A LA PANTALLA ADMINISTRADOR
        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("Administrador.aspx");
        }

        protected void gvClientes_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idSeleccionado = (int)gvClientes.SelectedDataKey.Value;
            ViewState["IdClienteSeleccionado"] = idSeleccionado;
        }

        protected void gvClientes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Editar")
            {
                CargarClienteEnModal(id);
                ScriptManager.RegisterStartupScript(this, GetType(), "modalEd",
                    "$('#modalEditar').modal('show');", true);
            }

            if (e.CommandName == "Borrar")
            {
                DarDeBajaCliente(id);
                CargarClientes(); // refrescar grid
            }
        }

    }
}