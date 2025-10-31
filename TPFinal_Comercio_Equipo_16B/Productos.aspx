<%@ Page Title="Productos" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Productos.aspx.cs" Inherits="TPFinal_Comercio_Equipo_16B.Productos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

 <style>

      /* Alto fijo y uniforme para el carrusel dentro de la card */
     .card .carousel-item{ height: 300px; }
     .card .carousel-item img{
     width:100%; height:100%; object-fit:contain; border-radius: 6px;
     }

     @media (max-width: 576px) { #carX .carousel-item { height: 220px; } }
     @media (min-width: 992px) { #carX .carousel-item { height: 380px; } }

 </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Nuestros autos mas locochones</h2>
    <hr />
    <div class="row align-items-stretch justify-content-around">
        <asp:Repeater ID="repProductos" runat="server">
            <ItemTemplate>
                 <!--Card-->
                 <div class="card col-12 col-lg-4 p-2 shadow ">

                     <!--Carrousel Imagenes-->
                     <div id='<%# "car_" + Eval("IdProducto") %>' class="carousel slide" data-ride="carousel">
                           <div  id="carX" class="carousel-inner">
                             <asp:Repeater ID="Repeater1" runat="server" DataSource='<%# Eval("Imagenes") %>'>
                               <ItemTemplate>
                                 <div class='carousel-item <%# Container.ItemIndex == 0 ? "active" : "" %>'>
                                   <img src='<%# Eval("imagenUrl") %>' class="d-block w-100" alt="img" />
                                 </div>
                               </ItemTemplate>
                             </asp:Repeater>
                           </div>

                           <!-- Controles carrousel -->
                           <a class="carousel-control-prev" href='<%# "#car_" + Eval("IdProducto") %>' role="button" data-slide="prev">
                             <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                             <span class="sr-only">Anterior</span>
                           </a>
                           <a class="carousel-control-next" href='<%# "#car_" + Eval("IdProducto") %>' role="button" data-slide="next">
                             <span class="carousel-control-next-icon" aria-hidden="true"></span>
                             <span class="sr-only">Siguiente</span>
                           </a>
                     </div>
                     <!--Fin Carrousel Imagenes-->


                     <div class="card-body d-flex flex-column align-items-start justify-content-around">
                         <h5 class="card-title"><%#Eval("Nombre") %></h5>
                         <p class="card-text"><%#Eval("Marca.Nombre") %></p>
                         <p class="card-text"><%#Eval("Categoria.Descripcion") %></p>
                         <p class="card-text"><%#Eval("Precio") %></p>
                     </div>
                 </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
