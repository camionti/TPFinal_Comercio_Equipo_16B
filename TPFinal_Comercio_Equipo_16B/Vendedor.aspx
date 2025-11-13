<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Vendedor.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.Vendedor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="d-flex flex-column justify-content-center align-items-center" style="height: 85vh; background-color: #f8f9fa;">

        <h5 class="mb-5 text-center fw-bold text-dark">Seleccione el botón para registrar una nueva venta
        </h5>

        <div class="card shadow border-0 text-center p-5"
            style="max-width: 1100px; border-radius: 20px; background-color: white;">

            <div class="d-flex flex-wrap justify-content-center d-grid gap-2 d-md-block">
                <asp:Button Text="Mis Ventas" ID="btnRegiVenta" CssClass="btn btn-dark  px-5 py-3 rounded-pill border fw-semibold hover-btn" OnClick="btnRegiVenta_Click" runat="server" />
            </div>

            <div class="d-flex flex-wrap justify-content-center d-grid gap-2 d-md-block">
                <asp:Button Text="Productos" ID="btnProductos" CssClass="btn btn-dark  px-5 py-3 rounded-pill border fw-semibold hover-btn" OnClick="btnProductos_Click" runat="server" />
            </div>
        </div>
    </div>
    <div class="container text-center">
        <div class="row align-items-end">
            <div class="col">
            </div>
            <div class="col">
                <asp:Button Text="Cerrar Sesion"
                    CssClass="btn btn-info px-5 py-2 rounded-pill border fw-semibold hover-btn align-items-center"
                    runat="server"
                    ID="Button1"
                    OnClick="btnSesion_Click" />
            </div>
            <div class="col">
            </div>
        </div>
    </div>
</asp:Content>
