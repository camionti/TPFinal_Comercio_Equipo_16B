<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="RegistroVentas.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.RegistroVentas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
    <div class="row align-items-center justify-content-between my-4 pl-2  ">
        <asp:HyperLink 
            ID="adminVolver" 
            runat="server" 
            NavigateUrl="~/administrador.aspx" 
            CssClass="btn btn-secondary ml-2 col-3">
            Volver al panel de vendedor
        </asp:HyperLink>



    </div>

    <asp:GridView ID="gvVentas" runat="server"
        CssClass="table table-hover text-nowrap"
        AutoGenerateColumns="false"
        OnRowCommand="gvVentas_RowCommand"
    >
        <Columns >
                <asp:BoundField DataField="IdVenta" HeaderText="#ID" />
                <asp:BoundField DataField="Usuario.NombreUsuario" HeaderText="Vendedor" />
                <asp:BoundField DataField="Cliente.Nombre" HeaderText="Cliente" />
                <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy}" HtmlEncode="false" />
                <asp:BoundField DataField="Total" HeaderText="Total" />

            <asp:TemplateField HeaderText="Eventos">
                <ItemTemplate >
                    <div class="d-flex align-items-center justify-content-around">
                        <asp:LinkButton runat="server"
                            CssClass="btn btn-sm btn-primary mx-1 "
                            CommandName="Ver"
                            CommandArgument='<%#Eval("IdVenta") %>'>
                            Ver detalle
                        </asp:LinkButton>

                        <asp:LinkButton runat="server"
                            CssClass="btn btn-sm btn-danger mx-1"
                            CommandName="Eliminar"
                            CommandArgument='<%#Eval("IdVenta") %>'
                            OnClientClick="return confirm('¿Seguro que querés eliminar este producto?');">

                            Dar de baja
                        </asp:LinkButton>
                    </div>
                </ItemTemplate>
            </asp:TemplateField>

       
        </Columns>
    </asp:GridView>

</div>  

            <!-- Modal de confirmación -->
        <div class="modal fade" id="modalConfirmacion" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
              <div class="modal-header text-white mx-auto" id="modalHeader" runat="server">
                <asp:Label ID="lblMensajeModal" runat="server" Text=""></asp:Label>
              </div>
                <div ID="modalBody" class="modal-body "  runat="server" >
                    <asp:Label ID="lblMensajeError" runat="server" Text="" EnableViewState="false" />
                </div>

              <div class="modal-footer">
                <!-- Botón para éxito -->
                <asp:Button ID="btnVolverAlPanel" runat="server" 
                    Text="Volver al panel" 
                    CssClass="btn btn-outline-primary mx-auto" 
                    OnClick="btnVolverAlPanel_Click" 
                    CausesValidation="false" />

                <!-- Botón para error -->
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
