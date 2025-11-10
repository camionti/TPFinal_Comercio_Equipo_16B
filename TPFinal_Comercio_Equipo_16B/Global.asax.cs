using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace TPFinal_Comercio_Equipo_16B
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Código que se ejecuta al iniciar la aplicación
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

        }

        public static class RouteConfig
        {
            public static void RegisterRoutes(RouteCollection routes)
            {

                routes.Add("IgnoreAdminFile", new Route("Administrador.aspx", new StopRoutingHandler()));
                // ADMIN
                routes.MapPageRoute(
                    "ProductosAdmin_Editar",
                    "admin/productos/editar/{id}",
                    "~/ProductoAgregarModif.aspx",
                    false, null,
                    new RouteValueDictionary { { "id", @"^\d+$" } }
                );

                routes.MapPageRoute(
                    "ProductosAdmin_Agregar",
                    "admin/productos/agregar",
                    "~/ProductoAgregarModif.aspx"
                );

                routes.MapPageRoute(
                    "ProductosAdmin_Ver",
                    "admin/productos/{id}",
                    "~/ProductoVer.aspx",
                    false, null,
                    new RouteValueDictionary { { "id", @"^\d+$" } }
                );

                routes.MapPageRoute(
                    "ProductosAdmin",
                    "admin/productos",
                    "~/ProductosAdmin.aspx"
                );

                routes.MapPageRoute(
                    "Administrador.aspx",
                    "Administrador",
                    "~/Administrador.aspx"
                );

                //Vendedor

                routes.MapPageRoute(
                    "Productos_Ver",
                    "vendedor/productos/{id}",
                    "~/ProductoVer.aspx",
                    false, null,
                    new RouteValueDictionary { { "id", @"^\d+$" } }
                );

                routes.MapPageRoute(
                    "ProductosVendedor",
                    "vendedor/productos",
                    "~/Productos.aspx"
                );

                routes.MapPageRoute(
                    "VendedorRegistroVentas",
                    "vendedor/ventas",
                    "~/registroVentasVendedor.aspx"
                );

                routes.MapPageRoute(
                    "VendedorRegistrarVenta",
                    "vendedor/ventas/agregar",
                    "~/registrarVentaVendedor.aspx"
                );

                routes.MapPageRoute(
                    "Vendedor",
                    "vendedor",
                    "~/Vendedor.aspx"
                );

                
            }
        }
    }
}