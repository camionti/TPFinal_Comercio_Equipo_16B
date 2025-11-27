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
    public partial class Usuarios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarUsuarios();
            }
        }


        private void CargarUsuarios()
        {
            UsuarioNegocio negocio = new UsuarioNegocio();
            gvUsuarios.DataSource = negocio.Listar();
            gvUsuarios.DataBind();
        }




        protected void gvUsuarios_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Editar")
            {
                CargarModalEditar(id);
            }
            else if (e.CommandName == "Eliminar")
            {
                EliminarUsuario(id);
            }
        }

        protected void btnGuardarAgregar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            Usuario usuario = new Usuario();
            usuario.NombreUsuario = txtNombreUsuarioAgregar.Text;
            usuario.Contrasenia = txtContraseniaAgregar.Text;
            usuario.Rol = (Rol)int.Parse(ddlRolAgregar.SelectedValue);
            usuario.Activo = true;

            UsuarioNegocio negocio = new UsuarioNegocio();
            negocio.Agregar(usuario);

            CargarUsuarios();
        }

        private void CargarModalEditar(int id)
        {
            UsuarioNegocio negocio = new UsuarioNegocio();
            Usuario usuario = negocio.BuscarPorId(id);

            hfIdUsuario.Value = usuario.IdUsuario.ToString();
            txtNombreUsuario.Text = usuario.NombreUsuario;

            // cargar contraseña y rol, si tu consulta lo devuelve
            txtContrasenia.Text = usuario.Contrasenia;
            ddlRol.SelectedValue = ((int)usuario.Rol).ToString();

            ScriptManager.RegisterStartupScript(this, GetType(), "MostrarModal",
                "$('#modalEditar').modal('show');", true);
        }


        protected void btnGuardarEditar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            Usuario usuario = new Usuario();
            usuario.IdUsuario = int.Parse(hfIdUsuario.Value);
            usuario.NombreUsuario = txtNombreUsuario.Text;
            usuario.Contrasenia = txtContrasenia.Text;
            usuario.Rol = (Rol)int.Parse(ddlRol.SelectedValue);

            UsuarioNegocio negocio = new UsuarioNegocio();
            negocio.Modificar(usuario);

            CargarUsuarios();
        }

        private void EliminarUsuario(int id)
        {
            UsuarioNegocio negocio = new UsuarioNegocio();
            negocio.Eliminar(id);

            CargarUsuarios();
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("Administrador.aspx");
        }



    }
}
