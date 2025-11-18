<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="DetalleCompras.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.DetalleCompras" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-5">

        <div class="card shadow-lg border-0">
            <div class="card-header bg-primary text-white d-flex justify-content-between">
                <h4 class="mb-0">Listado de Compras</h4>
            </div>

            <div class="card-body">

                <!-- COMPRAS -->
                <asp:GridView ID="gvCompras" runat="server"
                    CssClass="table table-striped table-hover text-center"
                    AutoGenerateColumns="False"
                    OnRowCommand="gvCompras_RowCommand"
                    DataKeyNames="IdCompra">

                    <Columns>

                        <asp:BoundField DataField="IdCompra" HeaderText="ID" />

                        <asp:BoundField DataField="Fecha" HeaderText="Fecha"
                            DataFormatString="{0:dd/MM/yyyy}" />

                        <asp:BoundField DataField="Proveedor.Nombre" HeaderText="Proveedor" />

                        <asp:BoundField DataField="Total" HeaderText="Total"
                            DataFormatString="${0:N2}" />

                        <asp:TemplateField HeaderText="Acciones">
                            <ItemTemplate>

                                <!-- DETALLES -->
                                <asp:LinkButton ID="btnDetalles" runat="server"
                                    CssClass="btn btn-info btn-sm mr-2"
                                    CommandName="VerDetalles"
                                    CommandArgument='<%# Eval("IdCompra") %>'>
                                    <i class="fas fa-eye"></i> Ver Detalles
                                </asp:LinkButton>

                                <!-- BAJA -->
                                <asp:LinkButton ID="btnBaja" runat="server"
                                    CssClass="btn btn-danger btn-sm"
                                    CommandName="DarBaja"
                                    CommandArgument='<%# Eval("IdCompra") %>'>
                                    <i class="fas fa-trash-alt"></i> Dar Baja
                                </asp:LinkButton>

                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>

                </asp:GridView>

            </div>
        </div>
    </div>


    <!-- MODAL DETALLE COMPRA -->
    <div class="modal fade" id="modalDetalles" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">

                <div class="modal-header bg-info text-white">
                    <h5 class="modal-title">Detalles de la Compra</h5>
                    <button type="button" class="close text-white" data-dismiss="modal">
                        <span>&times;</span>
                    </button>
                </div>

                <div class="modal-body">

                    <asp:GridView ID="gvDetalleCompra" runat="server"
                        CssClass="table table-bordered text-center"
                        AutoGenerateColumns="False">

                        <Columns>
                            <asp:BoundField DataField="Producto.Nombre" HeaderText="Producto" />
                            <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />
                            <asp:BoundField DataField="PrecioUnitario" HeaderText="Precio Unitario"
                                DataFormatString="${0:N2}" />
                            <asp:BoundField DataField="Subtotal" HeaderText="Subtotal"
                                DataFormatString="${0:N2}" />
                        </Columns>

                    </asp:GridView>

                </div>

                <div class="modal-footer">
                    <button class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                </div>

            </div>
        </div>
    </div>

    <!-- MODAL DAR DE BAJA (LOGICA) -->
    <div class="modal fade" id="modalBaja" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">

                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title">Dar de Baja la Compra</h5>
                    <button type="button" class="close text-white" data-dismiss="modal">
                        <span>&times;</span>
                    </button>
                </div>

                <div class="modal-body">
                    <label>Motivo de baja</label>
                    <asp:TextBox ID="txtMotivoBaja" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:HiddenField ID="hfIdCompraBaja" runat="server" />
                </div>

                <div class="modal-footer">
                    <asp:Button ID="btnConfirmarBaja" runat="server"
                        Text="Confirmar Baja" CssClass="btn btn-danger"
                        OnClick="btnConfirmarBaja_Click" />
                    <button class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                </div>

            </div>
        </div>
    </div>
    <asp:Button Text="Volver"
        CssClass="btn btn-dark px-5 py-2 rounded-pill border fw-semibold hover-btn"
        runat="server"
        ID="btnVolver"
        OnClick="btnVolver_Click" />
    <asp:Button Text="Registrar una nueva compra"
        CssClass="btn btn-dark px-5 py-2 rounded-pill border fw-semibold hover-btn"
        runat="server"
        ID="regCompra"
        OnClick="regCompra_Click" />
</asp:Content>
