<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="LoginAdministrador.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.LoginAdministrador" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-sm">
            <div class="col-md-auto">
                <hr />
                <h5 class="mb-4 text-center">Está por iniciar sesión como ADMINISTRADOR</h5>
                <hr />
            </div>
            <div class="form-group">
                <label for="txtEmail">Ingrese su Email</label>
                <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" type="Email" />
            </div>
            <div class="form-group">
                <label for="txtPassword">Ingrese su contraseña</label>
                <asp:TextBox runat="server" ID="txtPassword" CssClass="form-control" type="Password" />
            </div>
            <asp:Button Text="Iniciar Sesión" ID="btnIniciarSesion" runat="server" CssClass="btn btn-outline-dark rounded-pill" OnClick="btnIniciarSesion_Click"/>
            <asp:Button Text="Volver al Inicio" ID="btnInicio" runat="server" CssClass="btn btn-outline-dark rounded-pill" OnClick="btnInicio_Click"/>
        </div>
    </div>
</asp:Content>
