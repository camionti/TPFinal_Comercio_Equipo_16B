<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="RegistroCompras.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.RegistroCompras" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container py-3">

        <div class="card shadow-sm border-0">
            <div class="card-header bg-primary text-white">
                <h4 class="my-1">Registrar Nueva Compra</h4>
            </div>

            <div class="card-body">

                <!-- PROVEEDOR -->
                <div class="form-group">
                    <label class="font-weight-bold">Proveedor</label>
                    <asp:DropDownList 
                        ID="ddlProveedores" 
                        runat="server" 
                        CssClass="form-control"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="ddlProveedores_SelectedIndexChanged">
                    </asp:DropDownList>

                    
                    <div class="mt-3">
                        <asp:Button ID="btnAceptarProveedor" runat="server" Text="Aceptar" CssClass="btn btn-success" OnClick="btnAceptarProveedor_Click" />
                        <asp:Button ID="btnCancelarProveedor" runat="server" Text="Cancelar" CssClass="btn btn-danger ml-4" OnClick="btnCancelarProveedor_Click" />
                    </div>
                </div>

                <hr />

                <div>
                    <h5 class="mb-3">Agregar Productos</h5>

                    <div class="form-row">
                        <div class="form-group col-md-5">
                            <label class="font-weight-bold">Producto</label>
                            <asp:DropDownList ID="ddlProductos" runat="server" CssClass="form-control"
                                    AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlProductos_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>

                        <div class="form-group col-md-3">
                            <label class="font-weight-bold">Cantidad</label>
                            <asp:TextBox ID="txtCantidad" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                        </div>

                        <div class="form-group col-md-3">
                            <label class="font-weight-bold">Precio Compra</label>
                            <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                        </div>

                        <div class="form-group col-md-1 d-flex align-items-end">
                            <asp:Button ID="btnAgregarDetalle" runat="server" CssClass="btn btn-success btn-block"
                                Text="+" OnClick="btnAgregarDetalle_Click" />
                        </div>
                    </div>
                </div>

                <!-- TABLA DE DETALLES -->
                <div class="table-responsive mt-4">
                    <asp:GridView ID="gvDetalles" runat="server"
                        CssClass="table table-striped table-bordered text-center"
                        AutoGenerateColumns="False"
                        OnRowCommand="gvDetalles_RowCommand">


                        <Columns>
                            <asp:BoundField DataField="Producto.Nombre" HeaderText="Producto" />
                            <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />
                            <asp:BoundField DataField="PrecioUnitario" HeaderText="Precio" DataFormatString="{0:C2}" />
                            <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" DataFormatString="{0:C2}" />

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
                <asp:Button ID="btnGuardarCompra" runat="server" CssClass="btn btn-outline-primary " Text="Generar Compra" OnClick="btnGuardarCompra_Click" />
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-outline-danger" OnClick="btnCancelar_Click" CausesValidation="false" />
            </div>
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
