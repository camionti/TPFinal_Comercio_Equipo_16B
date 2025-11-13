<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="DetalleVentaVer.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.DetalleVentaVer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="container mt-5 pt-3 light-gray shadow-sm rounded shadow-sm mx-auto" style="max-width: 700px;">
        <asp:HyperLink 
            runat="server" 
            CssClass="" 
            NavigateUrl="javascript:history.back();">
            Volver a mis ventas
        </asp:HyperLink>

    <!-- Card -->
    <div class="p-2 my-2 ">
        <div class="card-body">
            <!-- Marca y Categoría -->
            <p class="text-muted mb-2 d-flex">
                Vendedor: <span class="ml-1" id="lblVendedor" runat="server"></span>
            </p>
            <p class="text-muted mb-2 d-flex">
                Cliente: <span class="ml-1" id="lblCliente" runat="server"></span>
            </p>

            <p class="text-muted mb-2 d-flex">
                Auto: <span class="ml-1" id="lblNombreProducto" runat="server"></span>
            </p>

            <p class="text-muted mb-2 d-flex">
                Cantidad vendidos: <span class="ml-1" id="lblCantidad" runat="server"></span>
            </p>

            <p class="text-muted mb-2 d-flex">
                Precio: <span class="ml-1" id="lblPrecio" runat="server"></span>
            </p>


        </div>
    </div>
</asp:Content>
