<%@ Page Title="Agregar o Modificar Producto" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ProductoAgregarModif.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.ProductoAgregarModif" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .card-form {
            max-width: 600px;
            margin: 40px auto;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="card shadow card-form">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">
                <asp:Label ID="lblTitulo" runat="server" Text="Agregar Producto"></asp:Label>
            </h4>
        </div>

        <div class="card-body">
            <div class="mb-3">
                <label for="txtNombre" class="form-label">Nombre</label>
                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Ej: Toyota Corolla XEi 2.0 AT 2023" />
            </div>

            <div class="mb-3">
                <label for="ddlMarca" class="form-label">Marca</label>
                <asp:DropDownList ID="ddlMarca" runat="server" CssClass="form-select" />
            </div>

            <div class="mb-3">
                <label for="ddlCategoria" class="form-label">Categoría</label>
                <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="form-select" />
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="txtStockActual" class="form-label">Stock Actual</label>
                    <asp:TextBox ID="txtStockActual" runat="server" CssClass="form-control" TextMode="Number" placeholder="Ej: 5" />
                </div>
                <div class="col-md-6 mb-3">
                    <label for="txtStockMinimo" class="form-label">Stock Mínimo</label>
                    <asp:TextBox ID="txtStockMinimo" runat="server" CssClass="form-control" TextMode="Number" placeholder="Ej: 1" />
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="txtPorcentajeGanancia" class="form-label">Porcentaje de Ganancia (%)</label>
                    <asp:TextBox ID="txtPorcentajeGanancia" runat="server" CssClass="form-control" TextMode="Number" placeholder="Ej: 15" />
                </div>
                <div class="col-md-6 mb-3">
                    <label for="txtPrecio" class="form-label">Precio</label>
                    <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control" TextMode="Number" placeholder="Ej: 15000" />
                </div>
            </div>
        </div>

        <div class="card-footer d-flex justify-content-between">
            <asp:Button ID="btnAceptar" runat="server" Text="Guardar" CssClass="btn btn-success" OnClick="btnAceptar_Click" />
            <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-outline-danger" OnClick="btnCancelar_Click" CausesValidation="false" />
        </div>
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
