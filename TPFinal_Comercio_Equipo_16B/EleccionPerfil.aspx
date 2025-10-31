<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="EleccionPerfil.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.EleccionPerfil" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="d-flex justify-content-center align-items-center" style="height: 80vh;">
        <div class="card shadow-lg border-0 p-5 text-center" style="max-width: 450px; border-radius: 20px;">
            <h2 class="mb-4 text-dark fw-bold">Seleccione un perfil</h2>
            <p class="text-muted mb-4">para ingresar al sistema</p>

            <div class="d-grid gap-3">
                <asp:Button
                    ID="btnAdministrador"
                    runat="server"
                    Text="Administrador"
                    CssClass="btn btn-outline-dark btn-lg rounded-pill"
                    OnClick="btnAdministrador_Click" />

                <asp:Button
                    ID="btnVendedor"
                    runat="server"
                    Text="Vendedor"
                    CssClass="btn btn-outline-dark btn-lg rounded-pill"
                    OnClick="btnVendedor_Click" />
            </div>
        </div>
    </div>
</asp:Content>
