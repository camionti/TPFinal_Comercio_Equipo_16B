<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Marcas.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.Marcas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



    <div class="container mt-3">
        <div class="d-flex justify-content-between mb-4">
            <asp:Button ID="btnVolver" runat="server" Text="Volver"
                CssClass="btn btn-outline-danger ml-2 fw-semibold hover-btn"
                OnClick="btnVolver_Click" />

            <asp:Button ID="btnAgregar" runat="server" Text="Agregar nueva marca"
                CssClass="btn btn-primary px-5 py-2 mr-3  fw-semibold hover-btn"
                OnClick="btnAgregar_Click" />
        </div>
    </div>

    <div class="card shadow border-0 rounded-4">

        <div class="card-header text-white rounded-top" style="background-color: #0a9bb8;">
            <h4 class="mb-0 fw-bold">Listado de Marcas</h4>
        </div>

        <div class="card-body">


            <div class="table-responsive mb-4">
                <asp:GridView ID="gvMarcas" runat="server"
                    CssClass="table table-hover table-bordered align-middle"
                    AutoGenerateColumns="False"
                    DataKeyNames="IdMarca"
                    OnRowCommand="gvMarcas_RowCommand"
                    HeaderStyle-CssClass="text-center fw-bold bg-light">

                    <Columns>


                        <asp:BoundField DataField="IdMarca" HeaderText="#ID" />


                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />


                        <asp:TemplateField HeaderText="Editar">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEditar" runat="server"
                                    Text="Modificar"
                                    CssClass="btn btn-sm btn-primary mx-1 "
                                    CommandName="Editar"
                                    CommandArgument='<%# Eval("IdMarca") %>'>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>


                        <asp:TemplateField HeaderText="Eventos">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnBaja" runat="server"
                                    Text="Dar de baja"
                                    CssClass="btn btn-sm btn-danger mx-1 "
                                    CommandName="Borrar"
                                    CommandArgument='<%# Eval("IdMarca") %>'
                                    OnClientClick="return confirm('¿Seguro que desea dar de baja esta marca?');">
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>

                </asp:GridView>
            </div>

        </div>
    </div>
    <!-- MODAL EDITAR -->
    <div class="modal fade" id="modalEditar" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content rounded-4 shadow">

                <div class="modal-header bg-success text-white rounded-top-4">
                    <h5 class="modal-title fw-bold">Modificar Marca</h5>
                </div>

                <div class="modal-body">
                    <asp:HiddenField ID="hfIdMarca" runat="server" />

                    <label class="fw-semibold">Nombre</label>
                    <asp:TextBox ID="txtNombre" CssClass="form-control rounded-3" runat="server" />
                    <asp:RequiredFieldValidator ID="rfvNombre"
                        runat="server" ErrorMessage="El nombre es obligatorio"
                        ControlToValidate="txtNombre" CssClass="text-danger"
                        ValidationGroup="Modificar" />
                    <asp:RegularExpressionValidator ID="revNombre"
                        runat="server" ErrorMessage="Solo letras"
                        ControlToValidate="txtNombre"
                        CssClass="text-danger"
                        ValidationExpression="^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$"
                        ValidationGroup="Modificar" />
                </div>
                <asp:Button ID="btnGuardarEditar"
                    runat="server"
                    Text="Guardar Cambios"
                    CssClass="btn btn-success px-4 rounded-pill fw-bold"
                    ValidationGroup="Modificar"
                    OnClick="btnGuardarEditar_Click" />

                <button type="button" class="btn btn-outline-secondary px-4 rounded-pill"
                    data-dismiss="modal">
                    Cancelar</button>
            </div>

        </div>
    </div>
    

    <!-- MODAL AGREGAR -->
    <div class="modal fade" id="modalAgregar" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content rounded-4 shadow">

                <div class="modal-header bg-success text-white rounded-top-4">
                    <h5 class="modal-title fw-bold">Agregar Marca</h5>
                </div>

                <div class="modal-body">

                    <asp:TextBox ID="txtNombreAgregar"
                        CssClass="form-control rounded-3 mb-2"
                        placeholder="Nombre"
                        runat="server" />

                    <asp:RegularExpressionValidator ID="revNombreAgregar"
                        runat="server" ControlToValidate="txtNombreAgregar"
                        ErrorMessage="Solo letras." CssClass="text-danger"
                        ValidationExpression="^[a-zA-ZÀ-ÿ\s]+$"
                        ValidationGroup="vgAgregar" />

                    <asp:RequiredFieldValidator ID="rfvNombreAgregar"
                        runat="server" ControlToValidate="txtNombreAgregar"
                        ErrorMessage="El nombre es obligatorio."
                        CssClass="text-danger"
                        ValidationGroup="vgAgregar" />

                </div>
                <asp:Button ID="btnGuardarAgregar"
                    runat="server"
                    Text="Guardar"
                    CssClass="btn btn-success px-4 fw-bold rounded-pill"
                    ValidationGroup="vgAgregar"
                    OnClick="btnGuardarAgregar_Click" />

                <button type="button" class="btn btn-outline-secondary px-4 rounded-pill"
                    data-dismiss="modal">
                    Cancelar</button>
            </div>

        </div>
    </div>


    <asp:Label ID="lblError" runat="server"
        CssClass="text-danger fw-semibold mt-3 d-block text-center"
        Visible="false" />
</asp:Content>
