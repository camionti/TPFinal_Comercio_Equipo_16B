<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="registroVentasVendedor.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.registroVentasVendedor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
    <div class="row align-items-center justify-content-between my-4 pl-2  ">
        <asp:HyperLink 
            ID="adminVolver" 
            runat="server" 
            NavigateUrl="~/vendedor.aspx" 
            CssClass="btn btn-secondary ml-2 col">
            Volver al panel de vendedor
        </asp:HyperLink>

        <div class="d-flex col-7 ">

            <asp:TextBox ID="txtPrecioMin" runat="server" CssClass="form-control col ml-2 pl-2" placeholder="$ Desde" TextMode="Number" />
            <asp:TextBox ID="txtPrecioMax" runat="server" CssClass="form-control col ml-2 pl-2" placeholder="$ Hasta" TextMode="Number" />

            <div class="input-group col-8">
                <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control" placeholder="Buscá por marca, categoría o nombre" />

                <asp:LinkButton runat="server"
                    ID="btnBuscar"
                    CssClass="btn btn-outline-secondary"
                    OnClick="btnBuscar_Click"
                    >
                        Buscar
                </asp:LinkButton>
            </div>
        </div>

        <asp:HyperLink 
            ID="adminAgregarProducto" 
            runat="server" 
            NavigateUrl='<%# GetRouteUrl("VendedorRegistrarVenta", null) %>' 
            CssClass="btn btn-primary col">
            Agregar nueva venta
        </asp:HyperLink>
    </div>

    <asp:GridView ID="gvVentas" runat="server"
        CssClass="table table-hover text-nowrap"
        AutoGenerateColumns="false"
    >
        <Columns >
                <asp:BoundField DataField="IdVenta" HeaderText="#ID" />
                <asp:BoundField DataField="Usuario.NombreUsuario" HeaderText="Vendedor" />
                <asp:BoundField DataField="Cliente.Nombre" HeaderText="Cliente" />
                <asp:BoundField DataField="NumeroFactura" HeaderText="N° Factura" />
                <asp:BoundField DataField="Fecha" HeaderText="Fecha" />
       
        </Columns>
    </asp:GridView>
</div>  

</asp:Content>
