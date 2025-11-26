<%@ Page Title="Productos" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Productos.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.Productos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .botones-evento{
            width:250px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 
    <div class="container mt-3">
        <div class="row align-items-center justify-content-between my-4 pl-2  ">
            <asp:HyperLink 
                ID="adminVolver" 
                runat="server" 
                NavigateUrl="~/vendedor.aspx" 
                CssClass="btn btn-secondary ml-2 col">
                Volver al panel de vendedor
            </asp:HyperLink>

            <div class="d-flex col-9 ">

                <asp:TextBox ID="txtPrecioMin" runat="server" CssClass="form-control col ml-2 pl-2" placeholder="$ Desde" TextMode="Number" />
                <asp:TextBox ID="txtPrecioMax" runat="server" CssClass="form-control col ml-2 pl-2" placeholder="$ Hasta" TextMode="Number" />

                <div class="input-group col-8">
                    <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control" placeholder="Buscá por marca, categoría o nombre" />

                    <asp:LinkButton runat="server"
                        ID="btnBuscar"
                        CssClass="btn btn-outline-secondary ml-3"
                        OnClick="btnBuscar_Click"
                        >

                        Buscar
                    </asp:LinkButton>
                </div>

            </div>

        </div>
            <div class="card shadow-lg border-0">
        <div class="card-header bg-info text-white d-flex justify-content-between">
            <h4 class="mb-0">Listado de Productos</h4>
        </div>


     <div class="card-body">

        <asp:GridView ID="gvProductos" runat="server"
            CssClass="table table-hover  rounded shadow-sm "
            HeaderStyle-CssClass="table-info"
            GridLines="None"
            AutoGenerateColumns="false"
            >
            <Columns >
                <asp:BoundField DataField="IdProducto" HeaderText="#ID" />
                <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                <asp:BoundField DataField="Marca.Nombre" HeaderText="Marca" />
                <asp:BoundField DataField="Categoria.Descripcion" HeaderText="Categoria" />
                <asp:BoundField DataField="StockActual" HeaderText="StockActual" />
                <asp:BoundField DataField="Precio" HeaderText="Precio" />
                <asp:BoundField DataField="PorcentajeGanancia" HeaderText="% Ganancia" DataFormatString="{0:0.#}%" />

                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton runat="server"
                            ID="btnProductoVer" 
                            Text="Ver detalle"
                            CssClass="btn btn-primary btn-sm"
                            CommandName="VerDetalle"
                            CommandArgument='<%# Eval("IdProducto") %>'
                            OnCommand="btnProductoVer_Command" />
                    </ItemTemplate>
                </asp:TemplateField>


            </Columns>
        </asp:GridView>
    </div>
    </div>
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
