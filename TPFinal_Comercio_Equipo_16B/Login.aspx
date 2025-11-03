<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.LoginVendedor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row">
        <div class="col-sm">
            <div class="col-md-auto">
                <hr />
                <h5 class="mb-4 text-center">Está por iniciar sesión dependiendo de tu usuario ingresaras como ADMINISTRADOR o VENDEDOR</h5>
                <hr />
            </div>
            <div class="form-group">
                <label for="txtUsuario">Ingrese su Usuario</label>
                <asp:TextBox runat="server" ID="txtUsuario" CssClass="form-control" />
            </div>
            <div class="form-group">
                <label for="txtPassword">Ingrese su contraseña</label>
                <asp:TextBox runat="server" ID="txtPassword" CssClass="form-control" type="Password" />
            </div>
            <asp:Button Text="Iniciar Sesión" ID="btnIniciarSesion" runat="server" CssClass="btn btn-outline-dark rounded-pill" OnClick="btnIniciarSesion_Click" />
            <asp:Button Text="Volver al Inicio" ID="btnInicio" runat="server" CssClass="btn btn-outline-dark rounded-pill" OnClick="btnInicio_Click" />
            <br />
            <asp:Label ID="lblMensaje" runat="server" CssClass="text-danger mt-2"></asp:Label>
        </div>
    </div>

</asp:Content>
