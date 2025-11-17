<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Proveedores.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.Proveedores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="d-flex flex-column justify-content-center align-items-center" style="height: 85vh; background-color: #f8f9fa;">
        <h5 class="mb-5 text-center fw-bold text-dark">Lista de proveedores</h5>

        <!--LISTA DE PROVEEDORES-->
        <asp:GridView ID="gvProveedores" runat="server"
            CssClass="table table-striped table-hover text-center"
            AutoGenerateColumns="False"
            DataKeyNames="IdProveedor"
            OnSelectedIndexChanged="gvProveedores_SelectedIndexChanged">
            <Columns>
                <asp:CommandField ShowSelectButton="True" SelectText="Seleccionar" />
                <asp:BoundField DataField="IdProveedor" HeaderText="ID" />
                <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                <asp:BoundField DataField="Telefono" HeaderText="Teléfono" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
            </Columns>
            <SelectedRowStyle BackColor="#d1ecf1" Font-Bold="true" />
        </asp:GridView>

        <!--BOTONES AGREGAR, MODIFICAR, ELMINAR, VOLVER-->

        <div class="d-flex flex-wrap justify-content-center align-items-center d-grid gap-2 d-md-block text-center">

            <asp:Button Text="Agregar"
                CssClass="btn btn-success px-5 py-2 rounded-pill border fw-semibold hover-btn"
                runat="server"
                ID="btnAgregar"
                OnClick="btnAgregar_Click" />

            <asp:Button Text="Modificar"
                CssClass="btn btn-info px-5 py-2 rounded-pill border fw-semibold hover-btn"
                runat="server"
                ID="btnModificar"
                OnClick="btnModificar_Click" />

            <asp:Button ID="btnEliminar" runat="server" Text="Eliminar Seleccionado"
                CssClass="btn btn-danger px-5 py-2 rounded-pill border fw-semibold hover-btn"
                OnClick="btnEliminar_Click"
                OnClientClick="return confirm('¿Seguro que desea eliminar este proveedor?');" />

            <asp:Button Text="Volver"
                CssClass="btn btn-dark px-5 py-2 rounded-pill border fw-semibold hover-btn"
                runat="server"
                ID="btnVolver"
                OnClick="btnVolver_Click" />
        </div>

    </div>


    <!--MODAL PARA MODIFICAR PROVEEDOR-->
    <div class="modal fade" id="modalEditar" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title">Editar Proveedor</h5>
                </div>
                <div class="modal-body">

                    <asp:HiddenField ID="hfIdProveedor" runat="server" />
                    <!-- NOMBRE -->
                    <div class="mb-3">
                        <label>Nombre</label>
                        <asp:TextBox ID="txtNombre" CssClass="form-control" runat="server" />
                        <asp:RequiredFieldValidator
                            ID="rfvNombre"
                            runat="server"
                            ErrorMessage="El nombre es obligatorio"
                            ControlToValidate="txtNombre"
                            CssClass="text-danger"
                            ValidationGroup="vgEditar" />
                        <asp:RegularExpressionValidator
                            ID="RegularExpressionValidator1"
                            runat="server"
                            ControlToValidate="txtNombre"
                            ErrorMessage="El nombre solo puede contener letras."
                            ValidationExpression="^[a-zA-ZÀ-ÿ\s]+$"
                            CssClass="text-danger"
                            ValidationGroup="vgEditar">
                        </asp:RegularExpressionValidator>
                    </div>

                    <!-- TELEFONO -->
                    <div class="mb-3">
                        <label>Telefono</label>
                        <asp:TextBox ID="txtTelefono" CssClass="form-control" runat="server" />
                        <asp:RequiredFieldValidator
                            ID="rfvTelefono"
                            runat="server"
                            ErrorMessage="El teléfono es obligatorio"
                            ControlToValidate="txtTelefono"
                            CssClass="text-danger"
                            ValidationGroup="vgEditar" />

                        <asp:RegularExpressionValidator
                            ID="revTelefono"
                            runat="server"
                            ErrorMessage="Formato de teléfono inválido"
                            ControlToValidate="txtTelefono"
                            ValidationExpression="^[0-9]{7,15}$"
                            CssClass="text-danger"
                            ValidationGroup="vgEditar" />
                    </div>
                    <!-- EMAIL -->
                    <div class="mb-3">
                        <label>Email</label>
                        <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" />
                        <asp:RequiredFieldValidator
                            ID="rfvEmail"
                            runat="server"
                            ErrorMessage="El email es obligatorio"
                            ControlToValidate="txtEmail"
                            CssClass="text-danger"
                            ValidationGroup="vgEditar" />

                        <asp:RegularExpressionValidator
                            ID="revEmail"
                            runat="server"
                            ErrorMessage="Email inválido"
                            ControlToValidate="txtEmail"
                            ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                            CssClass="text-danger"
                            ValidationGroup="vgEditar" />
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnGuardar"
                        runat="server"
                        Text="Guardar"
                        CssClass="btn btn-success"
                        OnClick="btnGuardar_Click"
                        CausesValidation="true"
                        ValidationGroup="vgEditar" />
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>
    <!--MODAL PARA AGREGAR PROVEEDOR -->
    <div class="modal fade" id="modalAgregar" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title">Agregar Proveedor</h5>
                </div>
                <div class="modal-body">

                    <div class="mb-3">
                        <!-- NOMBRE -->
                        <asp:TextBox ID="txtNombreAgregar" CssClass="form-control mb-3"
                            runat="server" placeholder="Nombre"></asp:TextBox>

                        <asp:RegularExpressionValidator
                            ID="revNombreAgregar"
                            runat="server"
                            ControlToValidate="txtNombreAgregar"
                            ErrorMessage="El nombre solo puede contener letras."
                            ValidationExpression="^[a-zA-ZÀ-ÿ\s]+$"
                            CssClass="text-danger"
                            ValidationGroup="vgAgregar">
                        </asp:RegularExpressionValidator>

                        <asp:RequiredFieldValidator
                            ID="rfvNombreAgregar"
                            runat="server"
                            ControlToValidate="txtNombreAgregar"
                            ErrorMessage="El nombre es obligatorio."
                            CssClass="text-danger"
                            ValidationGroup="vgAgregar">
                        </asp:RequiredFieldValidator>
                    </div>


                    <!-- TELEFONO -->
                    <div class="mb-3">
                        <asp:TextBox ID="txtTelefonoAgregar" CssClass="form-control mb-3"
                            runat="server" placeholder="Teléfono"></asp:TextBox>

                        <asp:RegularExpressionValidator
                            ID="revTelefonoAgregar"
                            runat="server"
                            ControlToValidate="txtTelefonoAgregar"
                            ErrorMessage="El teléfono solo puede contener números."
                            ValidationExpression="^[0-9]+$"
                            CssClass="text-danger"
                            ValidationGroup="vgAgregar">
                        </asp:RegularExpressionValidator>

                        <asp:RequiredFieldValidator
                            ID="rfvTelefonoAgregar"
                            runat="server"
                            ControlToValidate="txtTelefonoAgregar"
                            ErrorMessage="El teléfono es obligatorio."
                            CssClass="text-danger"
                            ValidationGroup="vgAgregar">
                        </asp:RequiredFieldValidator>

                    </div>

                    <!-- EMAIL -->
                    <div class="mb-3">
                        <asp:TextBox ID="txtEmailAgregar" CssClass="form-control mb-3"
                            runat="server" placeholder="Email"></asp:TextBox>

                        <asp:RegularExpressionValidator
                            ID="revEmailAgregar"
                            runat="server"
                            ControlToValidate="txtEmailAgregar"
                            ErrorMessage="Ingrese un email válido."
                            ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                            CssClass="text-danger"
                            ValidationGroup="vgAgregar">
                        </asp:RegularExpressionValidator>

                        <asp:RequiredFieldValidator
                            ID="rfvEmailAgregar"
                            runat="server"
                            ControlToValidate="txtEmailAgregar"
                            ErrorMessage="El email es obligatorio."
                            CssClass="text-danger"
                            ValidationGroup="vgAgregar">
                        </asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnGuardarAgregar"
                        runat="server"
                        Text="Guardar"
                        CssClass="btn btn-success"
                        OnClick="btnGuardarAgregar_Click"
                        CausesValidation="true"
                        ValidationGroup="vgAgregar" />
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>
    <!--LBL DE ERROR (ELIMINAR PROVEEDORES CON PRODUCTOS ASOCIADOS)-->
    <asp:Label ID="lblError" runat="server" CssClass="text-danger fw-semibold mt-3 d-block" Visible="false" />

</asp:Content>
