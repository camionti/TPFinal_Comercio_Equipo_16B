<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="DetalleVentaVer.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.DetalleVentaVer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="container mt-5 pt-3 light-gray rounded shadow-sm mx-auto" style="max-width: 700px;">
        <asp:HyperLink 
            runat="server" 
            CssClass="" 
            NavigateUrl="javascript:history.back();">
            Volver a la página anterior
        </asp:HyperLink>
        <asp:Repeater ID="repDetalles" runat="server">
            <HeaderTemplate>
                <table class="table table-hover">
                    <tr>
                        <th>Producto</th>
                        <th>Cantidad</th>
                        <th>Precio</th>
                        <th>Subtotal</th>
                    </tr>
            </HeaderTemplate>

            <ItemTemplate>
                <tr>
                    <td><%# Eval("Producto.Nombre") %></td>
                    <td><%# Eval("Cantidad") %></td>
                    <td><%# Eval("PrecioUnitario", "{0:C}") %></td>
                    <td><%# (Convert.ToInt32(Eval("Cantidad")) * Convert.ToDecimal(Eval("PrecioUnitario"))) %></td>
                </tr>
            </ItemTemplate>

            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
