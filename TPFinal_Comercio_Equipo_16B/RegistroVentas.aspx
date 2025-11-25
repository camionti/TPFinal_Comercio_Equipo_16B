<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="RegistroVentas.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.RegistroVentas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .bg-warning-50 {
            background-color: #dc3546c0;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-3">

        <!-- FILTROS -->
        <div class="row align-items-center justify-content-between my-4 pl-2  ">
            <asp:Button Text="Volver"
                CssClass="btn btn-outline-danger ml-2 fw-semibold hover-btn"
                runat="server"
                ID="btnVolver"
                OnClick="btnVolver_Click" />

            <asp:Button Text="Registrar una nueva venta"
                CssClass="btn btn-primary px-5 py-2 mr-3  fw-semibold hover-btn"
                runat="server"
                ID="regVenta"
                OnClick="regVenta_Click" />
        </div>

        <!-- CARD -->
        <div class="card shadow-lg border-0">
            <div class="card-header bg-info text-white d-flex justify-content-between">
                <h4 class="mb-0">Listado de Ventas</h4>
            </div>

            <!-- BODY -->
            <div class="card-body">
                <!-- FILTROS -->
                <div class="mb-4 d-flex">
                    <h6 class="text-center mr-3 py-1 my-1 fw-semibold">Mostrar ventas:</h6>
                    <asp:DropDownList
                        ID="ddlFiltros"
                        runat="server"
                        CssClass="form-control w-auto"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="lblFiltrarVentas_SelectedIndexChanged">
                        <asp:ListItem Text="Activas" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Inactivas" Value="0"></asp:ListItem>
                        <asp:ListItem Text="Todas" Value=""></asp:ListItem>
                    </asp:DropDownList>
                </div>

                <!-- GV -->
                <asp:GridView ID="gvVentas" runat="server"
                    CssClass="table table-hover  rounded shadow-sm"
                    AutoGenerateColumns="False"
                    OnRowCommand="gvVentas_RowCommand"
                    HeaderStyle-CssClass="table-info"
                    GridLines="None">

                    <Columns>
                        <asp:BoundField DataField="IdVenta" HeaderText="#ID" />
                        <asp:BoundField DataField="Usuario.NombreUsuario" HeaderText="Vendedor" />
                        <asp:BoundField DataField="Cliente.Nombre" HeaderText="Cliente" />
                        <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy}" HtmlEncode="false" />
                        <asp:BoundField DataField="Total" HeaderText="Total" />

                        <asp:TemplateField HeaderText="Eventos">
                            <ItemTemplate>
                                <div class="d-flex align-items-center justify-content-between">
                                    <!-- BOTON DETALLES -->
                                    <asp:LinkButton runat="server"
                                        CssClass="btn btn-sm btn-primary mx-1 "
                                        CommandName="VerDetalles"
                                        Visible='<%# (bool)Eval("Activo") %>'
                                        CommandArgument='<%#Eval("IdVenta") %>'>
                            Ver detalle
                                    </asp:LinkButton>

                                    <!-- BOTON baja -->
                                    <asp:LinkButton runat="server"
                                        CssClass="btn btn-sm btn-danger mx-1"
                                        CommandName="DarBaja"
                                        Visible='<%# (bool)Eval("Activo") %>'
                                        CommandArgument='<%#Eval("IdVenta") %>'>
                            Dar de baja
                                    </asp:LinkButton>

                                    <!-- BOTON MOTIVO BAJA -->
                                    <asp:LinkButton ID="LinkButton1" runat="server"
                                        CssClass="btn btn-danger btn-sm"
                                        CommandName="MotivoBaja"
                                        Visible='<%# !(bool)Eval("Activo") %>'
                                        CommandArgument='<%# Eval("IdVenta") %>'>
                            <i class="fas fa-trash-alt"></i> Motivo de Baja
                                    </asp:LinkButton>
                                </div>
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

                <!--Body-->
                <div class="modal-body">

                    <!--Motivo de baja-->
                    <div id="divMotivoBaja" runat="server" class="mb-3 p-2 bg-warning-50 rounded w-auto text-white">
                        <p>Motivo de baja: </p>
                        <asp:Label runat="server" ID="lblMotivoBaja" Text="" CssClass="ml-2" Visible="false" />
                    </div>

                    <!--GV-->
                    <asp:GridView ID="gvDetalleVenta" runat="server"
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
                <!--Body-->
                <div class="modal-body">
                    <label>Motivo de baja</label>
                    <asp:TextBox ID="txtMotivoBaja" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:HiddenField ID="hfIdVentaBaja" runat="server" />
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


</asp:Content>
