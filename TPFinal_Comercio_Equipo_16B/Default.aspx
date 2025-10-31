<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="d-flex flex-column justify-content-center align-items-center" style="height: 80vh;">
        <h3 class="mb-4 text-center">¡Estas por ingresar al sistema de DriveCar, puede ser como administrador o vendedor!</h3>
        <asp:Button Text="Ingresar" ID="btnSistema" CssClass="btn btn-dark btn-lg"  runat="server" OnClick="btnSistema_Click" />
    </div>
</asp:Content>
