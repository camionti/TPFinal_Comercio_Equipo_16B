<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Usuarios.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.Usuarios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-3">
        <div class="d-flex justify-content-between mb-4">
            <asp:Button ID="btnVolver" runat="server" Text="Volver"
                CssClass="btn btn-outline-danger ml-2 fw-semibold hover-btn"
                OnClick="btnVolver_Click" />

            <asp:Button ID="btnAgregar" runat="server" Text="Agregar nuevo usuario"
                CssClass="btn btn-primary px-5 py-2 mr-3 fw-semibold hover-btn"
                OnClientClick="$('#modalAgregar').modal('show'); return false;" />
        </div>
    </div>

    <div class="card shadow border-0 rounded-4">

        <div class="card-header text-white rounded-top" style="background-color: #0a9bb8;">
            <h4 class="mb-0 fw-bold">Listado de Usuarios</h4>
        </div>

        <div class="card-body">


            <div class="table-responsive mb-4">
                <asp:GridView ID="gvUsuarios" runat="server"
                    CssClass="table table-hover table-bordered align-middle"
                    AutoGenerateColumns="False"
                    DataKeyNames="IdUsuario"
                    OnRowCommand="gvUsuarios_RowCommand"
                    HeaderStyle-CssClass="text-center fw-bold bg-light">

                    <Columns>


                        <asp:BoundField DataField="IdUsuario" HeaderText="#ID" />


                        <asp:BoundField DataField="NombreUsuario" HeaderText="NombreUsuario" />

                        <asp:BoundField DataField="Contrasenia" HeaderText="Contraseña" />

                        <asp:TemplateField HeaderText="Editar">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEditar" runat="server"
                                    Text="Modificar"
                                    CssClass="btn btn-sm btn-primary mx-1 "
                                    CommandName="Editar"
                                    CommandArgument='<%# Eval("IdUsuario") %>'>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>


                        <asp:TemplateField HeaderText="Baja">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnBaja" runat="server"
                                    Text="Dar de baja"
                                    CssClass="btn btn-sm btn-danger mx-1 "
                                    CommandName="Eliminar"
                                    CommandArgument='<%# Eval("IdUsuario") %>'
                                    OnClientClick="return confirm('¿Seguro que desea dar de baja este usuario?');">
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>

                </asp:GridView>
            </div>

        </div>
    </div>


    <!--  MODAL EDITAR  -->
   <div class="modal fade" id="modalEditar" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4 shadow">

            
            <div class="modal-header bg-info text-white rounded-top">
                <h5 class="modal-title">Editar Usuario</h5>
                <button type="button" class="close text-white" data-dismiss="modal">
                    <span>&times;</span>
                </button>
            </div>

            
            <div class="modal-body">

                <asp:HiddenField ID="hfIdUsuario" runat="server" />

                <!-- NOMBRE -->
                <label class="fw-semibold">Nombre</label>
                <asp:TextBox ID="txtNombreUsuario" CssClass="form-control rounded-pill" runat="server" />

                <asp:RequiredFieldValidator ID="rfvNombreUsuario"
                    runat="server" ErrorMessage="El nombre es obligatorio"
                    ControlToValidate="txtNombreUsuario"
                    CssClass="text-danger small d-block mt-1"
                    ValidationGroup="Modificar" />

                <asp:RegularExpressionValidator ID="revNombreUsuario"
                    runat="server" ErrorMessage="Solo se permiten letras"
                    ControlToValidate="txtNombreUsuario"
                    ValidationExpression="^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$"
                    CssClass="text-danger small d-block mt-1"
                    ValidationGroup="Modificar" />

                <hr />

                <!-- CONTRASEÑA -->
                <label class="fw-semibold mt-2">Contraseña</label>
                <asp:TextBox ID="txtContrasenia" CssClass="form-control rounded-pill" TextMode="Password" runat="server" />

                <asp:RequiredFieldValidator ID="rfvPass"
                    runat="server" ErrorMessage="La contraseña es obligatoria"
                    ControlToValidate="txtContrasenia"
                    CssClass="text-danger small d-block mt-1"
                    ValidationGroup="Modificar" />

                <hr />

                <!-- ROL -->
                <label class="fw-semibold mt-2">Rol</label>
                <asp:DropDownList ID="ddlRol" runat="server" CssClass="form-control rounded-pill">
                    <asp:ListItem Value="1">Administrador</asp:ListItem>
                    <asp:ListItem Value="2">Vendedor</asp:ListItem>
                </asp:DropDownList>

            </div>

            
            <div class="modal-footer">
                <asp:Button ID="btnGuardarEditar" runat="server" Text="Guardar Cambios"
                    CssClass="btn btn-info rounded-pill px-4"
                    ValidationGroup="Modificar" OnClick="btnGuardarEditar_Click" />

                <button type="button" class="btn btn-light rounded-pill px-4" data-dismiss="modal">
                    Cancelar
                </button>
            </div>

        </div>
    </div>
</div>
    <!-- MODAL AGREGAR -->
    <div class="modal fade" id="modalAgregar" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content rounded-4 shadow">

                <div class="modal-header bg-success text-white rounded-top">
                    <h5 class="modal-title">Agregar Usuario</h5>
                    <button type="button" class="close text-white" data-dismiss="modal">
                        <span>&times;</span>
                    </button>
                </div>

                <div class="modal-body">

                    <!-- NOMBRE -->
                    <label class="fw-semibold">Nombre de Usuario</label>
                    <asp:TextBox ID="txtNombreUsuarioAgregar" CssClass="form-control rounded-pill"
                        runat="server" />

                    <asp:RequiredFieldValidator ID="rfvNombreUsuarioAgregar"
                        runat="server" ErrorMessage="El nombre es obligatorio"
                        ControlToValidate="txtNombreUsuarioAgregar"
                        CssClass="text-danger small d-block mt-1"
                        ValidationGroup="vgAgregar" />

                    <asp:RegularExpressionValidator ID="revNombreUsuarioAgregar"
                        runat="server" ErrorMessage="Solo se permiten letras y números"
                        ControlToValidate="txtNombreUsuarioAgregar"
                        ValidationExpression="^[a-zA-ZáéíóúÁÉÍÓÚñÑ0-9\s]+$"
                        CssClass="text-danger small d-block mt-1"
                        ValidationGroup="vgAgregar" />

                    <hr />

                    <!-- CONTRASEÑA -->
                    <label class="fw-semibold mt-2">Contraseña</label>
                    <asp:TextBox ID="txtContraseniaAgregar" CssClass="form-control rounded-pill"
                        TextMode="Password" runat="server" />

                    <asp:RequiredFieldValidator ID="rfvPassAgregar"
                        runat="server" ErrorMessage="La contraseña es obligatoria"
                        ControlToValidate="txtContraseniaAgregar"
                        CssClass="text-danger small d-block mt-1"
                        ValidationGroup="vgAgregar" />

                    <hr />

                    <!-- ROL -->
                    <label class="fw-semibold mt-2">Rol</label>
                    <asp:DropDownList ID="ddlRolAgregar" runat="server" CssClass="form-control rounded-pill">
                        <asp:ListItem Value="1">Administrador</asp:ListItem>
                        <asp:ListItem Value="2">Vendedor</asp:ListItem>
                    </asp:DropDownList>

                </div>

                <div class="modal-footer">
                    <asp:Button ID="btnGuardarAgregar" runat="server" Text="Guardar"
                        CssClass="btn btn-success rounded-pill px-4"
                        CausesValidation="true" ValidationGroup="vgAgregar"
                        OnClick="btnGuardarAgregar_Click" />

                    <button type="button" class="btn btn-light rounded-pill px-4" data-dismiss="modal">
                        Cancelar
                    </button>
                </div>

            </div>
        </div>
    </div>



    <asp:Label ID="lblError" runat="server"
        CssClass="text-danger fw-semibold mt-3 d-block text-center"
        Visible="false" />

</asp:Content>
