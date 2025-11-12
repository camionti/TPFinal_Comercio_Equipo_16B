<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Clientes.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.Clientes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="d-flex flex-column justify-content-center align-items-center" style="height: 85vh; background-color: #f8f9fa;">
        <h5 class="mb-5 text-center fw-bold text-dark">Lista de Clientes</h5>

        <!--LISTA DE CLIENTES-->
        <asp:GridView ID="gvClientes" runat="server"
            CssClass="table table-striped table-hover text-center"
            AutoGenerateColumns="False"
            DataKeyNames="IdCliente"
            OnSelectedIndexChanged="gvClientes_SelectedIndexChanged">
            <Columns>
                <asp:CommandField ShowSelectButton="True" SelectText="Seleccionar" />
                <asp:BoundField DataField="IdCliente" HeaderText="ID" />
                <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                <asp:BoundField DataField="Telefono" HeaderText="Teléfono" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
            </Columns>
            <SelectedRowStyle BackColor="#d1ecf1" Font-Bold="true" />
        </asp:GridView>

        <div class="d-flex flex-wrap justify-content-center align-items-center d-grid gap-2 d-md-block text-center">

            <asp:Button Text="Agregar"
                CssClass="btn btn-success px-5 py-2 rounded-pill border fw-semibold hover-btn"
                runat="server"
                ID="btnAgregar"
                OnClick="btnAgregar_Click" />

            <asp:Button Text="Modificar"
                CssClass="btn btn-info px-5 py-2 rounded-pill border fw-semibold hover-btn"
                runat="server"
                ID="btnModificar"
                OnClick="btnModificar_Click" />

            <asp:Button ID="btnEliminar" runat="server" Text="Eliminar Seleccionado"
                CssClass="btn btn-danger px-5 py-2 rounded-pill border fw-semibold hover-btn"
                OnClick="btnEliminar_Click"
                OnClientClick="return confirm('¿Seguro que desea eliminar este cliente?');" />


            <asp:Button Text="Volver"
                CssClass="btn btn-dark px-5 py-2 rounded-pill border fw-semibold hover-btn"
                runat="server"
                ID="btnVolver"
                OnClick="btnVolver_Click" />
        </div>

    </div>


    <!--MODAL PARA MODIFICAR CLIENTE-->
    <div class="modal fade" id="modalEditar" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Modificar Cliente</h5>
               
                </div>
                <div class="modal-body">

                    <asp:HiddenField ID="hfIdCliente" runat="server" />

                    <div class="mb-3">
                        <label>Nombre</label>
                        <asp:TextBox ID="txtNombre" CssClass="form-control" runat="server" />
                    </div>

                    <div class="mb-3">
                        <label>Telefono</label>
                        <asp:TextBox ID="txtTelefono" CssClass="form-control" runat="server" />
                    </div>

                    <div class="mb-3">
                        <label>Email</label>
                        <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" />
                    </div>

                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnGuardar" CssClass="btn btn-success" Text="Guardar" runat="server" OnClick="btnGuardar_Click" />
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>

    <!--MODAL PARA AGREGAR CLIENTE -->
    <div class="modal fade" id="modalAgregar" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title">Agregar Cliente</h5>
                   
                </div>

                <div class="modal-body">
                    <asp:TextBox ID="txtNombreAgregar" CssClass="form-control mb-3" runat="server" placeholder="Nombre"></asp:TextBox>
                    <asp:TextBox ID="txtTelefonoAgregar" CssClass="form-control mb-3" runat="server" placeholder="Teléfono"></asp:TextBox>
                    <asp:TextBox ID="txtEmailAgregar" CssClass="form-control" runat="server" placeholder="Email"></asp:TextBox>
                </div>

                <div class="modal-footer">
                    <asp:Button ID="btnGuardarAgregar" runat="server" Text="Guardar" CssClass="btn btn-success"
                        OnClick="btnGuardarAgregar_Click" />
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
