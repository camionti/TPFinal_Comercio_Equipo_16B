<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="registroVentasVendedor.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.registroVentasVendedor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .bg-warning-50 {
            background-color:#dc3546c0;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container">
    <div class="row align-items-center justify-content-between my-4 pl-2  ">
        <asp:HyperLink 
            ID="adminVolver" 
            runat="server" 
            NavigateUrl="~/vendedor.aspx" 
            CssClass="btn btn-secondary ml-2 col-3">
            Volver al panel de vendedor
        </asp:HyperLink>


        <asp:HyperLink 
            ID="adminAgregarProducto" 
            runat="server" 
            NavigateUrl='<%# GetRouteUrl("VendedorRegistrarVenta", null) %>' 
            CssClass="btn btn-primary col-3">
            Agregar nueva venta
        </asp:HyperLink>
    </div>

     <div class="card shadow-lg border-0">
         <div class="card-header bg-info text-white d-flex justify-content-between">
             <h4 class="mb-0">Listado de Ventas</h4>
         </div>


        <div class="card-body">
            <!-- FILTROS -->
            <div class="mb-4 d-flex">
                <h6 class = "text-center mr-3 py-1 my-1 fw-semibold">Mostrar ventas:</h6>
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

            <div class="table-responsive mt-4">
                <asp:GridView ID="gvVentas" runat="server"
                    CssClass="table table-hover align-middle rounded shadow-sm"
                    AutoGenerateColumns="false"
                    HeaderStyle-CssClass="table-info"
                    GridLines="None"
                    OnRowCommand="gvVentas_RowCommand">
                    <Columns >
                            <asp:BoundField DataField="IdVenta" HeaderText="ID Venta" ItemStyle-CssClass="text-center"/>
                            <asp:BoundField DataField="Usuario.NombreUsuario" HeaderText="Vendedor" />
                            <asp:BoundField DataField="Cliente.Nombre" HeaderText="Cliente" />
                            <asp:BoundField DataField="Fecha" HeaderText="Fecha" />
                         
       

                        <asp:TemplateField HeaderText="Eventos">
                            <ItemTemplate >
                            <div class="d-flex align-items-center justify-content-between">
                                    <!-- BOTON DETALLES -->
                                    <asp:LinkButton runat="server"
                                        CssClass="btn btn-sm btn-primary mx-1 "
                                        CommandName="VerDetalles"
                                        Visible='<%# (bool)Eval("Activo") %>' 
                                        CommandArgument='<%#Eval("IdVenta") %>'>
                                        Ver detalle
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
            <div ID="divMotivoBaja" runat="server" class="mb-3 p-2 bg-warning-50 rounded w-auto text-white">
                <p>Motivo de baja: </p>
                <asp:Label runat="server" ID="lblMotivoBaja" Text="" CssClass="ml-2" Visible="false"/>
            </div>

               <!--GV-->
                <asp:GridView ID="gvDetalleVenta" runat="server"
                    CssClass="table table-bordered text-center"
                    AutoGenerateColumns="False">


                    <Columns>
                        <asp:BoundField DataField="Producto.Nombre" HeaderText="Producto" />
                        <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />
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
</asp:Content>
