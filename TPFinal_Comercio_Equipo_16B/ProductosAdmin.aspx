<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ProductosAdmin.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.ProductosAdmin" %>
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

    <div class="card shadow-lg border-0">
        <div class="card-header bg-info text-white d-flex justify-content-between">
            <h4 class="mb-0">Listado de Productos</h4>
        </div>


     <div class="card-body">
        <!-- FILTROS -->
        <div class="mb-4 d-flex">
            <h6 class="text-center mr-3 py-1 my-1 fw-semibold">Mostrar productos:</h6>
            <asp:DropDownList
                ID="ddlFiltros"
                runat="server"
                CssClass="form-control w-auto"
                AutoPostBack="true"
                OnSelectedIndexChanged="lblFiltrarProductos_SelectedIndexChanged">
                <asp:ListItem Text="Activos" Value="1"></asp:ListItem>
                <asp:ListItem Text="Inactivos" Value="0"></asp:ListItem>
                <asp:ListItem Text="Todos" Value=""></asp:ListItem>
            </asp:DropDownList>
        </div>
        <asp:GridView ID="gvProductos" runat="server"
            AutoGenerateColumns="false"
            OnRowCommand="gvProductos_RowCommand"
            CssClass="table table-hover  rounded shadow-sm "
            HeaderStyle-CssClass="table-info"
            GridLines="None"
        >
            <Columns >
                    <asp:BoundField DataField="IdProducto" HeaderText="#ID" />
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                    <asp:BoundField DataField="Marca.Nombre" HeaderText="Marca" />
                    <asp:BoundField DataField="Categoria.Descripcion" HeaderText="Categoria" />
                    <asp:BoundField DataField="StockActual" HeaderText="Stock" />
                    <asp:BoundField DataField="PorcentajeGanancia" HeaderText="% Ganancia" DataFormatString="{0:0.#}%" />

                <asp:TemplateField HeaderText="Eventos">
                    <ItemTemplate >
                        <div class="d-inline-flex gap-3 align-items-center justify-content-center">
                            <asp:LinkButton runat="server"
                                CssClass="btn btn-sm btn-primary mx-1 "
                                CommandName="Ver"
                                Visible='<%# (bool)Eval("Estado") %>' 
                                CommandArgument='<%#Eval("IdProducto") %>'>
                                Ver detalle
                            </asp:LinkButton>

                            <asp:LinkButton runat="server"
                                CssClass="btn btn-sm btn-success mx-1"
                                CommandName="Editar"
                                Visible='<%# (bool)Eval("Estado") %>' 
                                CommandArgument='<%#Eval("IdProducto") %>'>

                                Editar
                            </asp:LinkButton>

                            <asp:LinkButton runat="server"
                                CssClass="btn btn-sm btn-danger mx-1"
                                CommandName="Eliminar"
                                Visible='<%# (bool)Eval("Estado") %>' 
                                CommandArgument='<%#Eval("IdProducto") %>'
                                >
                                Eliminar
                            </asp:LinkButton>

                            <asp:LinkButton runat="server"
                                CssClass="btn btn-sm btn-danger mx-1"
                                CommandName="Alta"
                                Visible='<%# !(bool)Eval("Estado") %>' 
                                CommandArgument='<%#Eval("IdProducto") %>'
                                >
                                Activar
                            </asp:LinkButton>
                        </div>
                    </ItemTemplate>

                </asp:TemplateField>



            </Columns>
        </asp:GridView>
    </div>
</div>
        <!-- MODAL PARA CONFIRMAR -->
        <div class="modal fade" id="modalBaja" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">

                    <div ID="modalconfirmarheader" runat="server">
                        <h5 id="tituloModalConfirmar" runat="server" class="modal-title"></h5>
                        <button type="button" class="close text-white" data-dismiss="modal">
                            <span>&times;</span>
                        </button>
                    </div>
                    <!--Body-->
                    <div class="modal-body">
                        <asp:HiddenField ID="hfIdProducto" runat="server" />
                    </div>

                    <div class="modal-footer">
                        <asp:Button ID="btnConfirmarBaja" runat="server"
                            Text="Confirmar Baja"
                            CssClass="btn btn-danger"
                            OnClick="btnConfirmarBaja_Click" />

                        <asp:Button ID="btnConfirmarAlta" runat="server"
                            Text="Confirmar Alta"
                            CssClass="btn btn-success"
                            OnClick="btnConfirmarAlta_Click" />
                        <button class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                    </div>

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
            <asp:Label ID="lblMensajeError" runat="server" Text="" EnableViewState="false" />

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
     </div>

</asp:Content>
