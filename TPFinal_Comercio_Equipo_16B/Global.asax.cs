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
            RegisterRoutes(RouteTable.Routes);

        }



        private static void RegisterRoutes(RouteCollection routes)
        {
            routes.MapPageRoute(
                "ProductosAdmin", //nombre interno de la ruta
                "admin/productos", //URL publica del navegador
                "~/ProductosAdmin.aspx" //webform al que apunta
            );

            routes.MapPageRoute(
                "ProductosAdmin_Editar",
                "admin/productos/editar/{id}",
                "~/ProductoAgregarModif.aspx"
            );

            routes.MapPageRoute(
                "ProductosAdmin_Agregar",
                "admin/productos/agregar",
                "~/ProductoAgregarModif.aspx"
            );

            routes.MapPageRoute(
                "ProductosAdmin_Ver",
                "admin/productos/{id}",
                "~/ProductoVer.aspx"
            );
        }
    }
}