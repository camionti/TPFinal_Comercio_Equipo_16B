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
    <div class="row align-items-center justify-content-between my-4 pl-2  ">
        <asp:HyperLink 
            ID="adminVolver" 
            runat="server" 
            NavigateUrl="~/administrador.aspx" 
            CssClass="btn btn-secondary ml-2 col">
            Volver al panel de admin
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
            NavigateUrl='<%# GetRouteUrl("ProductosAdmin_Agregar", null) %>' 
            CssClass="btn btn-primary col">
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

    <!--Modal para error-->
    <div class="modal fade" id="modalConfirmacion" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header text-white bg-danger" id="modalHeader" runat="server">
                <asp:Label ID="lblMensajeModal" runat="server" Text=""></asp:Label>
            </div>
            <div ID="modalBody" class="modal-body "  runat="server" >
                <asp:Label ID="lblMensajeError" runat="server" Text="" EnableViewState="false" />
            </div>

          <div class="modal-footer">
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
