<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ProductoVer.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.ProductoVer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <style>
    .light-gray{
      background-color:#f1f1f1 !important;
    }
  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="container mt-5 pt-3 light-gray shadow-sm rounded shadow-sm mx-auto" style="max-width: 700px;">
        <asp:HyperLink 
            runat="server" 
            CssClass="" 
            NavigateUrl="javascript:history.back();">
            Volver a productos
        </asp:HyperLink>

    <!-- Card -->
    <div class="p-2 my-2 ">
        <!-- Imagen 
        <img id="imgProducto" runat="server"
             class="card-img-top"
             alt="Imagen del producto"
             style="height: 250px; object-fit: cover;" />-->

        <div class="card-body">
            <!-- Nombre -->
            <h3 id="lblNombre" runat="server" class="card-title mb-2"></h3>

            <!-- Marca y Categoría -->
            <p class="text-muted mb-2 d-flex">
            Marca: <span class="ml-1" id="lblMarca" runat="server"></span>
            </p>
            <p class="text-muted mb-2 d-flex">
            Categoría: <span class="ml-1" id="lblCategoria" runat="server"></span>
            </p>

            <!-- Stock -->
            <p class="mb-1">
            <strong>Stock actual:</strong> <span id="lblStock" runat="server"></span>
            </p>

            <!-- Precio y porcentaje ganancia -->

            <div class="d-flex w-50 justify-content-between">
                <p class="fs-5 mb-2 py-1 px-2">
                    Precio:
                    <span class="fw-semibold text-white mb-1 py-1 px-2 bg-success rounded" id="lblPrecio" runat="server"></span>
                </p>

                <p class="fs-5 mb-1 py-1 px-2">
                    Porcentaje de ganancia:
                    <span class="fw-semibold text-white mb-1 py-1 px-2 bg-success rounded" id="lblPorcentajeGanancia" runat="server"></span>
                </p>
            </div>
        </div>
    </div>
</div>
</asp:Content>
