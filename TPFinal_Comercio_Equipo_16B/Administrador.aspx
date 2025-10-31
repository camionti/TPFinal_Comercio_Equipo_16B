<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Administrador.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.Administrador" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <<div class="d-flex flex-column justify-content-center align-items-center" style="height: 85vh; background-color: #f8f9fa;">
        
    <h5 class="mb-5 text-center fw-bold text-dark">
        Seleccione una opción para administrar
    </h5>

    <div class="card shadow border-0 text-center p-5" 
         style="max-width: 1100px; border-radius: 20px; background-color: white;">

        <div class="d-flex flex-wrap justify-content-center align-items-center d-grid gap-2 d-md-block text-center">

            <asp:Button Text="Clientes" 
                        CssClass="btn btn-dark px-5 py-2 rounded-pill border fw-semibold hover-btn" 
                        runat="server" 
                        ID="btnClientes" 
                        OnClick="btnClientes_Click" />

            <asp:Button Text="Proveedores" 
                        CssClass="btn btn-dark px-5 py-2 rounded-pill border fw-semibold hover-btn" 
                        runat="server" 
                        ID="btnProveedores" 
                        OnClick="btnProveedores_Click" />

            <asp:Button Text="Productos" 
                        CssClass="btn btn-dark px-5 py-2 rounded-pill border fw-semibold hover-btn" 
                        runat="server" 
                        ID="btnProductos" 
                        OnClick="btnProductos_Click" />

            <asp:Button Text="Registro Ventas" 
                        CssClass="btn btn-dark px-5 py-2 rounded-pill border fw-semibold hover-btn" 
                        runat="server" 
                        ID="btnVentas" 
                        OnClick="btnVentas_Click" />

            <asp:Button Text="Registro Compras" 
                        CssClass="btn btn-dark px-5 py-2 rounded-pill border fw-semibold hover-btn" 
                        runat="server" 
                        ID="btnCompras" 
                        OnClick="btnCompras_Click" />

        </div>
    </div>
</div>

</asp:Content>
