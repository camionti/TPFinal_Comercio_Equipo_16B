<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Proveedores.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.Proveedores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container py-5">
        <div class="card shadow-lg border-0 rounded-4">
            <div class="card-header bg-dark text-white text-center rounded-top">
                <h4 class="mb-0">Lista de Proveedores</h4>
            </div>

            <div class="card-body">

                <!-- GRID -->
                <div class="table-responsive">
                    <asp:GridView ID="gvProveedores" runat="server"
                        CssClass="table table-hover align-middle"
                        AutoGenerateColumns="False"
                        DataKeyNames="IdProveedor"
                        OnSelectedIndexChanged="gvProveedores_SelectedIndexChanged">

                        <Columns>
                            <asp:CommandField ShowSelectButton="True" SelectText="➡" />
                            <asp:BoundField DataField="IdProveedor" HeaderText="ID" />
                            <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                            <asp:BoundField DataField="Telefono" HeaderText="Teléfono" />
                            <asp:BoundField DataField="Email" HeaderText="Email" />
                        </Columns>


                        <SelectedRowStyle BackColor="#d1ecf1" Font-Bold="true" />
                    </asp:GridView>
                </div>

                <!-- BOTONES -->
                <div class="text-center mt-4 d-flex flex-wrap justify-content-center gap-3">

                    <asp:Button Text="Agregar"
                        CssClass="btn btn-success px-4 py-2 rounded-pill shadow-sm"
                        runat="server" ID="btnAgregar"
                        OnClick="btnAgregar_Click" />

                    <asp:Button Text="Modificar"
                        CssClass="btn btn-info px-4 py-2 rounded-pill shadow-sm"
                        runat="server" ID="btnModificar"
                        OnClick="btnModificar_Click" />

                    <asp:Button ID="btnEliminar" runat="server"
                        Text="Dar de baja"
                        CssClass="btn btn-danger px-4 py-2 rounded-pill shadow-sm"
                        OnClick="btnEliminar_Click"
                        OnClientClick="return confirm('¿Seguro que desea dar de baja este proveedor?');" />

                    <asp:Button Text="Volver"
                        CssClass="btn btn-dark px-4 py-2 rounded-pill shadow-sm"
                        runat="server" ID="btnVolver"
                        OnClick="btnVolver_Click" />
                </div>

                <asp:Label ID="lblError" runat="server"
                    CssClass="text-danger fw-semibold mt-3 d-block text-center"
                    Visible="false" />
            </div>
        </div>


        <!-- MODAL EDITAR -->
        <div class="modal fade" id="modalEditar" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content rounded-4 shadow">

                    <div class="modal-header bg-primary text-white rounded-top-4">
                        <h5 class="modal-title">Editar Proveedor</h5>
                    </div>

                    <div class="modal-body">

                        <asp:HiddenField ID="hfIdProveedor" runat="server" />

                        <!-- NOMBRE -->
                        <div class="form-group">
                            <label class="font-weight-semibold">Nombre</label>
                            <asp:TextBox ID="txtNombre"
                                CssClass="form-control rounded-pill"
                                runat="server" />
                            <asp:RequiredFieldValidator ID="rfvNombre"
                                runat="server" ControlToValidate="txtNombre"
                                CssClass="text-danger" ErrorMessage="El nombre es obligatorio"
                                ValidationGroup="vgEditar" />
                            <asp:RegularExpressionValidator
                                ID="RegularExpressionValidator1"
                                runat="server"
                                ControlToValidate="txtNombre"
                                ErrorMessage="Solo se permiten letras."
                                ValidationExpression="^[a-zA-ZÀ-ÿ\s]+$"
                                CssClass="text-danger"
                                ValidationGroup="vgEditar" />
                        </div>

                        <!-- TELEFONO -->
                        <div class="form-group">
                            <label class="font-weight-semibold">Teléfono</label>
                            <asp:TextBox ID="txtTelefono"
                                CssClass="form-control rounded-pill"
                                runat="server" />
                            <asp:RequiredFieldValidator ID="rfvTelefono"
                                runat="server" ControlToValidate="txtTelefono"
                                CssClass="text-danger" ErrorMessage="El teléfono es obligatorio"
                                ValidationGroup="vgEditar" />
                            <asp:RegularExpressionValidator
                                ID="revTelefono"
                                runat="server" ControlToValidate="txtTelefono"
                                ErrorMessage="Formato inválido."
                                ValidationExpression="^[0-9]{7,15}$"
                                CssClass="text-danger"
                                ValidationGroup="vgEditar" />
                        </div>

                        <!-- EMAIL -->
                        <div class="form-group">
                            <label class="font-weight-semibold">Email</label>
                            <asp:TextBox ID="txtEmail"
                                CssClass="form-control rounded-pill"
                                runat="server" />
                            <asp:RequiredFieldValidator ID="rfvEmail"
                                runat="server" ControlToValidate="txtEmail"
                                CssClass="text-danger" ErrorMessage="El email es obligatorio"
                                ValidationGroup="vgEditar" />
                            <asp:RegularExpressionValidator
                                ID="revEmail"
                                runat="server" ControlToValidate="txtEmail"
                                ErrorMessage="Email inválido"
                                ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                                CssClass="text-danger"
                                ValidationGroup="vgEditar" />
                        </div>

                    </div>

                    <div class="modal-footer">
                        <asp:Button ID="btnGuardar"
                            runat="server"
                            Text="Guardar"
                            CssClass="btn btn-primary rounded-pill px-4"
                            OnClick="btnGuardar_Click"
                            CausesValidation="true"
                            ValidationGroup="vgEditar" />
                        <button class="btn btn-secondary rounded-pill px-4"
                            data-dismiss="modal">
                            Cancelar</button>
                    </div>

                </div>
            </div>
        </div>


        <!-- MODAL AGREGAR -->
        <div class="modal fade" id="modalAgregar" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content rounded-4 shadow">

                    <div class="modal-header bg-success text-white rounded-top-4">
                        <h5 class="modal-title">Agregar Proveedor</h5>
                    </div>

                    <div class="modal-body">

                        <div class="form-group">
                            <asp:TextBox ID="txtNombreAgregar"
                                CssClass="form-control rounded-pill mb-3"
                                placeholder="Nombre" runat="server" />
                            <asp:RequiredFieldValidator ID="rfvNombreAgregar"
                                runat="server" ControlToValidate="txtNombreAgregar"
                                CssClass="text-danger" ErrorMessage="El nombre es obligatorio"
                                ValidationGroup="vgAgregar" />
                            <asp:RegularExpressionValidator ID="revNombreAgregar"
                                runat="server" ControlToValidate="txtNombreAgregar"
                                ErrorMessage="Solo letras."
                                ValidationExpression="^[a-zA-ZÀ-ÿ\s]+$"
                                CssClass="text-danger"
                                ValidationGroup="vgAgregar" />
                        </div>

                        <div class="form-group">
                            <asp:TextBox ID="txtTelefonoAgregar"
                                CssClass="form-control rounded-pill mb-3"
                                placeholder="Teléfono" runat="server" />
                            <asp:RequiredFieldValidator ID="rfvTelefonoAgregar"
                                runat="server" ControlToValidate="txtTelefonoAgregar"
                                CssClass="text-danger" ErrorMessage="El teléfono es obligatorio"
                                ValidationGroup="vgAgregar" />
                            <asp:RegularExpressionValidator ID="revTelefonoAgregar"
                                runat="server" ControlToValidate="txtTelefonoAgregar"
                                ErrorMessage="Solo números"
                                ValidationExpression="^[0-9]+$"
                                CssClass="text-danger"
                                ValidationGroup="vgAgregar" />
                        </div>

                        <div class="form-group">
                            <asp:TextBox ID="txtEmailAgregar"
                                CssClass="form-control rounded-pill mb-3"
                                placeholder="Email" runat="server" />
                            <asp:RequiredFieldValidator ID="rfvEmailAgregar"
                                runat="server" ControlToValidate="txtEmailAgregar"
                                CssClass="text-danger" ErrorMessage="El email es obligatorio"
                                ValidationGroup="vgAgregar" />
                            <asp:RegularExpressionValidator ID="revEmailAgregar"
                                runat="server" ControlToValidate="txtEmailAgregar"
                                ErrorMessage="Email inválido"
                                ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                                CssClass="text-danger"
                                ValidationGroup="vgAgregar" />
                        </div>

                    </div>

                    <div class="modal-footer">
                        <asp:Button ID="btnGuardarAgregar"
                            runat="server"
                            Text="Guardar"
                            CssClass="btn btn-success rounded-pill px-4"
                            OnClick="btnGuardarAgregar_Click"
                            CausesValidation="true"
                            ValidationGroup="vgAgregar" />
                        <button class="btn btn-secondary rounded-pill px-4"
                            data-dismiss="modal">
                            Cancelar</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>
