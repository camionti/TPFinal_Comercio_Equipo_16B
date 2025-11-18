<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="RegistroCompras.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.RegistroCompras" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container py-3">

        <div class="card shadow-sm border-0">
            <div class="card-header bg-primary text-white">
                <h4 class="my-1">Registrar Nueva Compra</h4>
            </div>

            <div class="card-body">

                <!-- PROVEEDOR -->
                <div class="form-group">
                    <label class="font-weight-bold">Proveedor</label>
                    <asp:DropDownList ID="ddlProveedores" runat="server" CssClass="form-control"></asp:DropDownList>
                </div>

                <hr />

                <h5 class="mb-3">Agregar Productos</h5>

                <div class="form-row">
                    <div class="form-group col-md-5">
                        <label class="font-weight-bold">Producto</label>
                        <asp:DropDownList ID="ddlProductos" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>

                    <div class="form-group col-md-3">
                        <label class="font-weight-bold">Cantidad</label>
                        <asp:TextBox ID="txtCantidad" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                    </div>

                    <div class="form-group col-md-3">
                        <label class="font-weight-bold">Precio Compra</label>
                        <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                    </div>

                    <div class="form-group col-md-1 d-flex align-items-end">
                        <asp:Button ID="btnAgregarDetalle" runat="server" CssClass="btn btn-success btn-block"
                            Text="+" OnClick="btnAgregarDetalle_Click" />
                    </div>
                </div>

                <!-- TABLA DE DETALLES -->
                <div class="table-responsive mt-4">
                    <asp:GridView ID="gvDetalles" runat="server"
                        CssClass="table table-striped table-bordered text-center"
                        AutoGenerateColumns="False">

                        <Columns>
                            <asp:BoundField DataField="Producto.Nombre" HeaderText="Producto" />
                            <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />
                            <asp:BoundField DataField="PrecioUnitario" HeaderText="Precio" DataFormatString="{0:C2}" />
                            <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" DataFormatString="{0:C2}" />
                        </Columns>

                    </asp:GridView>
                </div>

                <!-- BOTÓN GUARDAR -->
                <div class="text-right mt-4">
                    <asp:Button ID="btnGuardar" runat="server" CssClass="btn btn-primary btn-lg"
                        Text="Guardar Compra" OnClick="btnGuardar_Click" />
                </div>

            </div>
        </div>
    </div>
    <asp:Button Text="Volver"
        CssClass="btn btn-dark px-5 py-2 rounded-pill border fw-semibold hover-btn"
        runat="server"
        ID="btnVolver"
        OnClick="btnVolver_Click" />

</asp:Content>
