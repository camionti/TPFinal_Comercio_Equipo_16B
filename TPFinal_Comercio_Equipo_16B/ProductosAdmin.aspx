<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ProductosAdmin.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.ProductosAdmin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .botones-evento{
            width:250px;
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 
    <div class="container">
    <div class="d-flex align-items-center justify-content-between my-4 ">
        <asp:HyperLink 
            ID="adminVolver" 
            runat="server" 
            NavigateUrl="~/administrador.aspx" 
            CssClass="btn btn-secondary ml-2">
            Volver al panel de admin
        </asp:HyperLink>

        <asp:HyperLink 
            ID="adminAgregarProducto" 
            runat="server" 
            NavigateUrl='<%# GetRouteUrl("ProductosAdmin_Agregar", null) %>' 
            CssClass="btn btn-primary">
            Agregar nuevo producto
        </asp:HyperLink>
    </div>

    <asp:GridView ID="gvProductos" runat="server"
        CssClass="table table-hover text-nowrap"
        AutoGenerateColumns="false"
        OnRowCommand="gvProductos_RowCommand"
    >
        <Columns >
                <asp:BoundField DataField="IdProducto" HeaderText="#ID" />
                <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                <asp:BoundField DataField="Marca.Nombre" HeaderText="Marca" />
                <asp:BoundField DataField="Categoria.Descripcion" HeaderText="Categoria" />
                <asp:BoundField DataField="StockActual" HeaderText="StockActual" />
                <asp:BoundField DataField="PorcentajeGanancia" HeaderText="% Ganancia" DataFormatString="{0:0.#}%" />
                <asp:BoundField DataField="Precio" HeaderText="Precio" DataFormatString="U$D {0:N0}"/>

            <asp:TemplateField HeaderText="Eventos">
                <ItemTemplate >
                    <div class="d-inline-flex gap-3 align-items-center justify-content-center">
                        <asp:LinkButton runat="server"
                            CssClass="btn btn-sm btn-primary mx-1 "
                            CommandName="Ver"
                            CommandArgument='<%#Eval("IdProducto") %>'>
                            Ver detalle
                        </asp:LinkButton>

                        <asp:LinkButton runat="server"
                            CssClass="btn btn-sm btn-success mx-1"
                            CommandName="Editar"
                            CommandArgument='<%#Eval("IdProducto") %>'>

                            Editar
                        </asp:LinkButton>

                        <asp:LinkButton runat="server"
                            CssClass="btn btn-sm btn-danger mx-1"
                            CommandName="Eliminar"
                            CommandArgument='<%#Eval("IdProducto") %>'
                            OnClientClick="return confirm('¿Seguro que querés eliminar este producto?');"
                            >

                            Eliminar
                        </asp:LinkButton>
                    </div>
                </ItemTemplate>

            </asp:TemplateField>



        </Columns>
    </asp:GridView>
    </div>


</asp:Content>
