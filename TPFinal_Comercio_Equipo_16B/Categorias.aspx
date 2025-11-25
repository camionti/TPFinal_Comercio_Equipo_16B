<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Categorias.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.Categorias" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container py-5">
        <div class="card shadow-lg border-0 rounded-4">
            <div class="card-header bg-dark text-white text-center rounded-top">
                <h4 class="mb-0"> Lista de Categorías</h4>
            </div>

            <div class="card-body">

                <!-- GRID -->
                <div class="table-responsive mb-4">
                    <asp:GridView ID="gvCategorias" runat="server"
                        CssClass="table table-hover table-bordered align-middle"
                        AutoGenerateColumns="False"
                        DataKeyNames="IdCategoria"
                        OnSelectedIndexChanged="gvCategorias_SelectedIndexChanged">
                        <Columns>
                            <asp:CommandField ShowSelectButton="True" SelectText="➡" />
                            <asp:BoundField DataField="IdCategoria" HeaderText="ID" />
                            <asp:BoundField DataField="Descripcion" HeaderText="Descripción" />
                        </Columns>
                        <SelectedRowStyle BackColor="#c7f3ff" Font-Bold="true" />
                    </asp:GridView>
                </div>

                <!-- BOTONES -->
                <div class="d-flex flex-wrap justify-content-center gap-2 text-center">
                    <asp:Button Text="Agregar"
                        CssClass="btn btn-success px-4 py-2 rounded-pill fw-semibold shadow-sm"
                        runat="server" ID="btnAgregar" OnClick="btnAgregar_Click" />

                    <asp:Button Text="Modificar"
                        CssClass="btn btn-info px-4 py-2 rounded-pill fw-semibold shadow-sm"
                        runat="server" ID="btnModificar" OnClick="btnModificar_Click" />

                    <asp:Button ID="btnEliminar" runat="server" Text="Dar de baja"
                        CssClass="btn btn-danger px-4 py-2 rounded-pill fw-semibold shadow-sm"
                        OnClick="btnEliminar_Click"
                        OnClientClick="return confirm('¿Seguro que desea dar de baja esta categoría?');" />

                    <asp:Button Text="Volver"
                        CssClass="btn btn-secondary px-4 py-2 rounded-pill fw-semibold shadow-sm"
                        runat="server" ID="btnVolver" OnClick="btnVolver_Click" />
                </div>

            </div>
        </div>
    </div>

    <!-- ======================= MODAL EDITAR ======================= -->
    <div class="modal fade" id="modalEditar" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content rounded-4 shadow">

                <div class="modal-header bg-info text-white rounded-top">
                    <h5 class="modal-title">Editar Categoría</h5>
                    <button type="button" class="close text-white" data-dismiss="modal">
                        <span>&times;</span>
                    </button>
                </div>

                <div class="modal-body">
                    <asp:HiddenField ID="hfIdCategoria" runat="server" />

                    <label class="fw-semibold">Descripción</label>
                    <asp:TextBox ID="txtDescripcion" CssClass="form-control rounded-pill" runat="server" />

                    <asp:RequiredFieldValidator ID="rfvNombre"
                        runat="server" ErrorMessage="La descripción es obligatoria"
                        ControlToValidate="txtDescripcion"
                        CssClass="text-danger small d-block mt-1"
                        ValidationGroup="Modificar" />

                    <asp:RegularExpressionValidator ID="revNombre"
                        runat="server" ErrorMessage="Solo se permiten letras"
                        ControlToValidate="txtDescripcion"
                        ValidationExpression="^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$"
                        CssClass="text-danger small d-block mt-1"
                        ValidationGroup="Modificar" />
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


    <!-- ======================= MODAL AGREGAR ======================= -->
    <div class="modal fade" id="modalAgregar" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content rounded-4 shadow">

                <div class="modal-header bg-success text-white rounded-top">
                    <h5 class="modal-title">Agregar Categoría</h5>
                    <button type="button" class="close text-white" data-dismiss="modal">
                        <span>&times;</span>
                    </button>
                </div>

                <div class="modal-body">

                    <asp:TextBox ID="txtAgregar"
                        CssClass="form-control rounded-pill mb-3"
                        runat="server" placeholder="Descripción"></asp:TextBox>

                    <asp:RegularExpressionValidator
                        ID="revAgregar" runat="server"
                        ControlToValidate="txtAgregar"
                        ErrorMessage="Solo letras."
                        ValidationExpression="^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$"
                        CssClass="text-danger small d-block"
                        ValidationGroup="vgAgregar">
                    </asp:RegularExpressionValidator>

                    <asp:RequiredFieldValidator
                        ID="rfvAgregar" runat="server"
                        ControlToValidate="txtAgregar"
                        ErrorMessage="Este campo es obligatorio."
                        CssClass="text-danger small d-block"
                        ValidationGroup="vgAgregar">
                    </asp:RequiredFieldValidator>
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
