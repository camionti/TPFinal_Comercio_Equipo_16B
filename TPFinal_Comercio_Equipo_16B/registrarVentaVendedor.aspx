<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="registrarVentaVendedor.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.registrarVentaVendedor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="card shadow card-form">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">
                <asp:Label ID="lblTitulo" runat="server" Text="Agregar venta"></asp:Label>
            </h4>
        </div>

        <div class="card-body">


            <!-- Cliente -->
            <div class="mb-3">
                <div class="mb-3">
                    <label for="ddlClientes" class="form-label">Cliente</label>
                    <asp:DropDownList ID="ddlClientes" runat="server"
                        CssClass="form-control"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="ddlClientes_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>

                <asp:Button ID="btnAceptarCliente" runat="server" Text="Aceptar" CssClass="btn btn-success" OnClick="btnAceptarCliente_Click" />
                <asp:Button ID="btnCancelarCliente" runat="server" Text="Cancelar" CssClass="btn btn-danger ml-4" OnClick="btnCancelarCliente_Click" />


            </div>

            <hr />

            <!--Detalles del producto-->
            <div class="mb-3">
                <label for="ddlProductos" class="form-label">Nombre</label>
                <asp:DropDownList ID="ddlProductos" runat="server"
                    CssClass="form-control"
                    AutoPostBack="true"
                    OnSelectedIndexChanged="ddlProductos_SelectedIndexChanged">
                </asp:DropDownList>
            </div>

            <div class="mb-3 mr-3">
                <label for="txtMarca" class="form-label">Marca</label>
                <asp:TextBox ID="txtMarca" runat="server" CssClass="form-control" Enabled="false" />
            </div>

            <div class="mb-3">
                <label for="txtCategoria" class="form-label">Categoría</label>
                <asp:TextBox ID="txtCategoria" runat="server" CssClass="form-control" Enabled="false" />
            </div>

            <div class="mb-3">
                <label for="txtStock" class="form-label">Stock</label>
                <asp:TextBox ID="txtStock" runat="server" CssClass="form-control" TextMode="Number" Enabled="false" />
            </div>

            <div class=" mb-3">
                <label for="txtPorcentajeGanancia" class="form-label">Porcentaje de Ganancia (%)</label>
                <asp:TextBox ID="txtPorcentajeGanancia" runat="server" CssClass="form-control" Enabled="false" />
            </div>

            <div class="mb-3">
                <label for="txtCantidad" class="form-label">Cantidad</label>
                <asp:TextBox ID="txtCantidad" runat="server" CssClass="form-control" TextMode="Number" />
            </div>

            <!-- Botón para agregar ítem al "carrito" -->
            <div class="mb-3">
                <asp:Button ID="btnAgregarProducto" runat="server"
                    Text="Agregar producto"
                    CssClass="btn btn-secondary"
                    OnClick="btnAgregarProducto_Click" />
            </div>

            <hr />


            <!-- Grid con los productos agregados -->
            <div class="mb-3">
                <asp:GridView ID="gvDetalles" runat="server"
                    AutoGenerateColumns="False"
                    CssClass="table table-striped"
                    OnRowCommand="gvDetalles_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="Producto">
                            <ItemTemplate>
                                <%# Eval("Producto.Nombre") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />

                        <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" DataFormatString="{0:C}" />

                        <asp:TemplateField HeaderText="Acciones">
                            <ItemTemplate>
                                <asp:Button
                                    ID="btnQuitar"
                                    runat="server"
                                    Text="Quitar"
                                    CommandName="Quitar"
                                    CommandArgument="<%# Container.DataItemIndex %>"
                                    CssClass="btn btn-danger btn-sm" />
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>
            </div>
        </div>

        <div class="card-footer d-flex justify-content-between">
            <!-- Ahora este botón confirma TODA la venta (cliente + lista de productos) -->
            <asp:Button ID="btnAceptar" runat="server" Text="Generar venta" CssClass="btn btn-success" OnClick="btnAceptar_Click" />
            <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-outline-danger" OnClick="btnCancelar_Click" CausesValidation="false" />
        </div>
    </div>


    <!-- Modal de confirmación -->
    <div class="modal fade" id="modalConfirmacion" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header text-white mx-auto" id="modalHeader" runat="server">
                    <asp:Label ID="lblMensajeModal" runat="server" Text=""></asp:Label>
                </div>
                <div id="modalBody" class="modal-body " runat="server">
                    <asp:Label ID="lblMensajeError" runat="server" Text="" EnableViewState="false" />
                </div>

                <div class="modal-footer">
                    <!-- Botón para éxito -->
                    <asp:Button ID="btnVolverAlPanel" runat="server"
                        Text="Volver al panel"
                        CssClass="btn btn-outline-primary mx-auto"
                        OnClick="btnVolverAlPanel_Click"
                        CausesValidation="false" />

                    <!-- Botón para error -->
                    <button id="btnCerrarModal"
                        runat="server"
                        type="button"
                        class="btn btn-outline-danger mx-auto"
                        data-dismiss="modal">
                        Cerrar
                    </button>

                </div>
            </div>
        </div>
    </div>
</asp:Content>
