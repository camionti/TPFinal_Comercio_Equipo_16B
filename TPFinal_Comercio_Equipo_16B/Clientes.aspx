<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Clientes.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.Clientes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-3">
        <div class="d-flex justify-content-between mb-4">
            <asp:Button ID="btnVolver" runat="server" Text="Volver"
                CssClass="btn btn-outline-danger ml-2 fw-semibold hover-btn"
                OnClick="btnVolver_Click" />

            <asp:Button ID="btnAgregar" runat="server" Text="Agregar nuevo cliente"
                CssClass="btn btn-primary px-5 py-2 mr-3  fw-semibold hover-btn"
                OnClick="btnAgregar_Click" />
        </div>
    </div>

    <div class="card shadow border-0 rounded-4">

        <div class="card-header text-white rounded-top" style="background-color: #0a9bb8;">
            <h4 class="mb-0 fw-bold">Listado de Clientes</h4>
        </div>

        <div class="card-body">


            <div class="table-responsive mb-4">
                <asp:GridView ID="gvClientes" runat="server"
                    CssClass="table table-hover table-bordered align-middle"
                    AutoGenerateColumns="False"
                    DataKeyNames="IdCliente"
                   OnRowCommand="gvClientes_RowCommand"
                    HeaderStyle-CssClass="text-center fw-bold bg-light">

                    <Columns>


                        <asp:BoundField DataField="IdCliente" HeaderText="#ID" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                        <asp:BoundField DataField="Telefono" HeaderText="Telefono" />
                        <asp:BoundField DataField="Email" HeaderText="Email" />
                        <asp:TemplateField HeaderText="Editar">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEditar" runat="server"
                                    Text="Modificar"
                                    CssClass="btn btn-sm btn-primary mx-1 "
                                    CommandName="Editar"
                                    CommandArgument='<%# Eval("IdCliente") %>'>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>


                        <asp:TemplateField HeaderText="Baja">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnBaja" runat="server"
                                    Text="Dar de baja"
                                    CssClass="btn btn-sm btn-danger mx-1 "
                                    CommandName="Borrar"
                                    CommandArgument='<%# Eval("IdCliente") %>'
                                    OnClientClick="return confirm('¿Seguro que desea dar de baja este cliente?');">
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
                    <h5 class="modal-title">Modificar Cliente</h5>
                    <button type="button" class="close text-white" data-dismiss="modal"><span>&times;</span></button>
                </div>

                <div class="modal-body">

                    <asp:HiddenField ID="hfIdCliente" runat="server" />

                    <!-- NOMBRE -->
                    <div class="mb-3">
                        <label class="fw-semibold">Nombre</label>
                        <asp:TextBox ID="txtNombre" CssClass="form-control rounded-pill" runat="server" />

                        <asp:RequiredFieldValidator ID="rfvNombre"
                            runat="server" ErrorMessage="El nombre es obligatorio"
                            ControlToValidate="txtNombre"
                            CssClass="text-danger small d-block"
                            ValidationGroup="vgEditar" />

                        <asp:RegularExpressionValidator ID="revNombre"
                            runat="server" ErrorMessage="Solo letras."
                            ControlToValidate="txtNombre"
                            ValidationExpression="^[a-zA-ZÀ-ÿ\s]+$"
                            CssClass="text-danger small d-block"
                            ValidationGroup="vgEditar" />
                    </div>

                    <!-- TELEFONO -->
                    <div class="mb-3">
                        <label class="fw-semibold">Teléfono</label>
                        <asp:TextBox ID="txtTelefono" CssClass="form-control rounded-pill" runat="server" />

                        <asp:RequiredFieldValidator ID="rfvTelefono"
                            runat="server" ErrorMessage="El teléfono es obligatorio"
                            ControlToValidate="txtTelefono"
                            CssClass="text-danger small d-block"
                            ValidationGroup="vgEditar" />

                        <asp:RegularExpressionValidator ID="revTelefono"
                            runat="server" ErrorMessage="Formato inválido (solo números, 7 a 15 dígitos)"
                            ControlToValidate="txtTelefono"
                            ValidationExpression="^[0-9]{7,15}$"
                            CssClass="text-danger small d-block"
                            ValidationGroup="vgEditar" />
                    </div>

                    <!-- EMAIL -->
                    <div class="mb-3">
                        <label class="fw-semibold">Email</label>
                        <asp:TextBox ID="txtEmail" CssClass="form-control rounded-pill" runat="server" />

                        <asp:RequiredFieldValidator ID="rfvEmail"
                            runat="server" ErrorMessage="El email es obligatorio"
                            ControlToValidate="txtEmail"
                            CssClass="text-danger small d-block"
                            ValidationGroup="vgEditar" />

                        <asp:RegularExpressionValidator ID="revEmail"
                            runat="server" ErrorMessage="Email inválido"
                            ControlToValidate="txtEmail"
                            ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                            CssClass="text-danger small d-block"
                            ValidationGroup="vgEditar" />
                    </div>

                </div>

                <div class="modal-footer">
                    <asp:Button ID="btnGuardar"
                        runat="server" Text="Guardar Cambios"
                        CssClass="btn btn-info rounded-pill px-4"
                        OnClick="btnGuardar_Click" ValidationGroup="vgEditar" />
                    <button type="button" class="btn btn-light rounded-pill px-4" data-dismiss="modal">Cancelar</button>
                </div>

            </div>
        </div>
    </div>



    <!--  MODAL AGREGAR  -->
    <div class="modal fade" id="modalAgregar" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content rounded-4 shadow">

                <div class="modal-header bg-success text-white rounded-top">
                    <h5 class="modal-title">Agregar Cliente</h5>
                    <button type="button" class="close text-white" data-dismiss="modal"><span>&times;</span></button>
                </div>

                <div class="modal-body">

                    <!-- NOMBRE -->
                    <div class="mb-3">
                        <label class="fw-semibold">Nombre</label>
                        <asp:TextBox ID="txtNombreAgregar" CssClass="form-control rounded-pill"
                            runat="server" placeholder="Nombre" />

                        <asp:RegularExpressionValidator ID="revNombreAgregar"
                            runat="server" ControlToValidate="txtNombreAgregar"
                            ErrorMessage="Solo letras."
                            ValidationExpression="^[a-zA-ZÀ-ÿ\s]+$"
                            CssClass="text-danger small d-block"
                            ValidationGroup="vgAgregar" />

                        <asp:RequiredFieldValidator ID="rfvNombreAgregar"
                            runat="server" ControlToValidate="txtNombreAgregar"
                            ErrorMessage="El nombre es obligatorio."
                            CssClass="text-danger small d-block"
                            ValidationGroup="vgAgregar" />
                    </div>

                    <!-- TELEFONO -->
                    <div class="mb-3">
                        <label class="fw-semibold">Teléfono</label>
                        <asp:TextBox ID="txtTelefonoAgregar" CssClass="form-control rounded-pill"
                            runat="server" placeholder="Teléfono" />

                        <asp:RegularExpressionValidator ID="revTelefonoAgregar"
                            runat="server" ControlToValidate="txtTelefonoAgregar"
                            ErrorMessage="Solo números."
                            ValidationExpression="^[0-9]{7,15}$"
                            CssClass="text-danger small d-block"
                            ValidationGroup="vgAgregar" />

                        <asp:RequiredFieldValidator ID="rfvTelefonoAgregar"
                            runat="server" ControlToValidate="txtTelefonoAgregar"
                            ErrorMessage="El teléfono es obligatorio."
                            CssClass="text-danger small d-block"
                            ValidationGroup="vgAgregar" />
                    </div>

                    <!-- EMAIL -->
                    <div class="mb-3">
                        <label class="fw-semibold">Email</label>
                        <asp:TextBox ID="txtEmailAgregar" CssClass="form-control rounded-pill"
                            runat="server" placeholder="Email" />

                        <asp:RegularExpressionValidator ID="revEmailAgregar"
                            runat="server" ControlToValidate="txtEmailAgregar"
                            ErrorMessage="Formato de email inválido"
                            ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                            CssClass="text-danger small d-block"
                            ValidationGroup="vgAgregar" />

                        <asp:RequiredFieldValidator ID="rfvEmailAgregar"
                            runat="server" ControlToValidate="txtEmailAgregar"
                            ErrorMessage="El email es obligatorio."
                            CssClass="text-danger small d-block"
                            ValidationGroup="vgAgregar" />
                    </div>

                </div>

                <div class="modal-footer">
                    <asp:Button ID="btnGuardarAgregar"
                        runat="server" Text="Guardar"
                        CssClass="btn btn-success rounded-pill px-4"
                        OnClick="btnGuardarAgregar_Click"
                        ValidationGroup="vgAgregar" />
                    <button type="button" class="btn btn-light rounded-pill px-4" data-dismiss="modal">Cancelar</button>
                </div>

            </div>
        </div>
    </div>

</asp:Content>

