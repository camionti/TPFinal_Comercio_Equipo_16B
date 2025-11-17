<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Categorias.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.Categorias" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="d-flex flex-column justify-content-center align-items-center" style="height: 85vh; background-color: #f8f9fa;">
        <h5 class="mb-5 text-center fw-bold text-dark">Lista de Categorias</h5>

        <!--LISTA-->
        <asp:GridView ID="gvCategorias" runat="server"
            CssClass="table table-striped table-hover text-center"
            AutoGenerateColumns="False"
            DataKeyNames="IdCategoria"
            OnSelectedIndexChanged="gvCategorias_SelectedIndexChanged">
            <Columns>
                <asp:CommandField ShowSelectButton="True" SelectText="Seleccionar" />
                <asp:BoundField DataField="IdCategoria" HeaderText="ID" />
                <asp:BoundField DataField="Descripcion" HeaderText="Descripcion" />

            </Columns>
            <SelectedRowStyle BackColor="#d1ecf1" Font-Bold="true" />
        </asp:GridView>

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
                OnClientClick="return confirm('¿Seguro que desea eliminar esta categoria?');" />


            <asp:Button Text="Volver"
                CssClass="btn btn-dark px-5 py-2 rounded-pill border fw-semibold hover-btn"
                runat="server"
                ID="btnVolver"
                OnClick="btnVolver_Click" />
        </div>

    </div>


    <!--MODAL PARA MODIFICAR -->
    <div class="modal fade" id="modalEditar" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title">Modificar Categoria</h5>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hfIdCategoria" runat="server" />
                    <div class="mb-3">
                        <label>Descripcion</label>
                        <asp:TextBox ID="txtDescripcion" CssClass="form-control" runat="server" />
                        <asp:RequiredFieldValidator
                            ID="rfvNombre"
                            runat="server"
                            ErrorMessage="El nombre es obligatorio"
                            ControlToValidate="txtDescripcion"
                            CssClass="text-danger"
                            ValidationGroup="Modificar" />

                        <asp:RegularExpressionValidator
                            ID="revNombre"
                            runat="server"
                            ErrorMessage="Solo se permiten letras"
                            ControlToValidate="txtDescripcion"
                            ValidationExpression="^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$"
                            CssClass="text-danger"
                            ValidationGroup="Modificar" />
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button
                        ID="btnGuardarEditar"
                        runat="server"
                        Text="Guardar Cambios"
                        CssClass="btn btn-success"
                        OnClick="btnGuardarEditar_Click"
                        ValidationGroup="Modificar" />
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>

    <!--MODAL PARA AGREGAR -->
    <div class="modal fade" id="modalAgregar" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title">Agregar Categoria</h5>
                </div>
                <div class="modal-body">
                    <!-- NOMBRE -->
                    <asp:TextBox ID="txtAgregar" CssClass="form-control mb-3"
                        runat="server" placeholder="Descripcion"></asp:TextBox>

                    <asp:RegularExpressionValidator
                        ID="revAgregar"
                        runat="server"
                        ControlToValidate="txtAgregar"
                        ErrorMessage="La descripcion solo puede contener letras."
                        ValidationExpression="^[a-zA-ZÀ-ÿ\s]+$"
                        CssClass="text-danger"
                        ValidationGroup="vgAgregar">
                    </asp:RegularExpressionValidator>

                    <asp:RequiredFieldValidator
                        ID="rfvAgregar"
                        runat="server"
                        ControlToValidate="txtAgregar"
                        ErrorMessage="La descripcion es obligatoria."
                        CssClass="text-danger"
                        ValidationGroup="vgAgregar">
                    </asp:RequiredFieldValidator>
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
    <asp:Label ID="lblError" runat="server" CssClass="text-danger fw-semibold mt-3 d-block" Visible="false" />
</asp:Content>


