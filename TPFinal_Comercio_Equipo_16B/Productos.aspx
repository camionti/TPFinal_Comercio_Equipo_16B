<%@ Page Title="Productos" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Productos.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.Productos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .botones-evento{
            width:250px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 
    <asp:GridView ID="gvProductos" runat="server"
        CssClass="table table-hover text-nowrap"
        AutoGenerateColumns="false"
        OnRowCommand="gvProductos_RowCommand"
    >
        <Columns>
                <asp:BoundField DataField="IdProducto" HeaderText="#ID" />
                <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                <asp:BoundField DataField="Marca.Nombre" HeaderText="Marca" />
                <asp:BoundField DataField="Categoria.Descripcion" HeaderText="Categoria" />
                <asp:BoundField DataField="StockActual" HeaderText="StockActual" />
                <asp:BoundField DataField="PorcentajeGanancia" HeaderText="Porcentaje de Ganancia" DataFormatString="{0:0.#}%" />
                <asp:BoundField DataField="Precio" HeaderText="Precio" DataFormatString="U$D {0:N0}"/>
        </Columns>
    </asp:GridView>


</asp:Content>
