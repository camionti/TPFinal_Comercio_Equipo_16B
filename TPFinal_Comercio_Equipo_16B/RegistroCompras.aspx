<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="RegistroCompras.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.RegistroCompras" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .bg-warning-50 {
            background-color:#dc3546c0;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container py-3">

        <div class="card shadow-sm border-0">
            <div class="card-header bg-info text-white">
                <h4 class="my-1">Registrar Nueva Compra</h4>
            </div>

            <div class="card-body">

                <!-- PROVEEDOR -->
                <div class="form-group">
                    <asp:Label ID="lblAgregarProveedor" runat="server" CssClass="font-weight-lighter px-1 pb-1 rounded text-white bg-warning-50" >Por favor seleccione un proveedor</asp:Label>
                    <label class="font-weight-bold d-block">Proveedor</label>
                    <asp:DropDownList 
                        ID="ddlProveedores" 
                        runat="server" 
                        CssClass="form-control"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="ddlProveedores_SelectedIndexChanged">
                    </asp:DropDownList>

                    
                    <div class="mt-3">
                        <asp:Button ID="btnAceptarProveedor" runat="server" Text="Aceptar" OnClick="btnAceptarProveedor_Click" />
                        <asp:Button ID="btnCancelarProveedor" runat="server" Text="Cancelar" OnClick="btnCancelarProveedor_Click" />
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
                            <asp:Button ID="btnAgregarDetalle" runat="server" CssClass=""
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

            <div class="card-footer d-flex justify-content-end">
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-outline-danger mr-3" OnClick="btnCancelar_Click" CausesValidation="false" />
                <asp:Button ID="btnGuardarCompra" runat="server" CssClass="btn" Text="Generar Compra" OnClick="btnGuardarCompra_Click" />
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

                <div id="modalBodyGrid" class="modal-body " runat="server" visible="false">
                    <div class="table-responsive mt-2">
                        <asp:GridView ID="gvDetallesConfirmar" runat="server"
                            CssClass="table table-striped table-bordered text-center"
                            AutoGenerateColumns="False"
                            OnRowCommand="gvDetalles_RowCommand">


                            <Columns>
                                <asp:BoundField DataField="Producto.Nombre" HeaderText="Producto" />
                                <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />
                                <asp:BoundField DataField="PrecioUnitario" HeaderText="Precio" DataFormatString="{0:C2}" />
                                <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" DataFormatString="{0:C2}" />

                            </Columns>

                        </asp:GridView>

                    </div>
                    <h6 class="  ">El total de la compra es de: <span ID="lblTotal" class="d-inline bg-warning-50 text-white rounded mx-auto w-auto py-1 px-2 text-center" runat="server"></span></h6>

                </div>

                <div class="modal-footer">
                    <!-- Botón para éxito -->
                    <asp:Button ID="btnVolverAlPanel" runat="server"
                        Text="Volver al panel"
                        CssClass="btn btn-outline-primary mx-auto"
                        OnClick="btnVolverAlPanel_Click"
                        CausesValidation="false" />

                    <!-- Botón para Cerrar -->
                    <button id="btnCerrarModal"
                        runat="server"
                        type="button"
                        class="btn btn-outline-danger mx-auto"
                        data-dismiss="modal">
                        Cerrar
                    </button>

                    <!-- Botón para Confirmar -->
                    <asp:Button ID="btnConfirmarCompra" runat="server"
                        Text="Confirmar"
                        CssClass="btn btn-outline-primary mx-auto"
                        OnClick="btnConfirmarCompra_Click"
                        CausesValidation="false" />

                </div>
            </div>
        </div>
    </div>
</asp:Content>
