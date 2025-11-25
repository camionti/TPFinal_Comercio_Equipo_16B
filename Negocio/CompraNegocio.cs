using Dominio;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class CompraNegocio
    {

        public void AgregarCompraConDetalles(Compra compra, List<DetalleCompra> detalles)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                // Seteo procedure
                datos.setearProcedure("sp_Compras_Crear");

                // Seteo parametros
                datos.setearParametro("@IdProveedor", compra.Proveedor.IdProveedor);
                datos.setearParametro("@IdUsuario", compra.IdUsuario);
                datos.setearParametro("@Fecha", compra.Fecha);

                // Armo la tabla Detalles para enviar a la DB
                DataTable tablaDetalles = new DataTable();
                tablaDetalles.Columns.Add("IdProducto", typeof(int));
                tablaDetalles.Columns.Add("Cantidad", typeof(int));
                tablaDetalles.Columns.Add("PrecioUnitario", typeof(decimal));

                foreach (DetalleCompra det in detalles)
                {
                    tablaDetalles.Rows.Add(
                        det.Producto.IdProducto,
                        det.Cantidad,
                        det.PrecioUnitario
                    );
                }

                // Seteo la tabla Detalles
                datos.setearParametroTabla("@Detalles", tablaDetalles, "dbo.TipoDetalleCompra");


                datos.ejecutarAccion();

            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void AgregarCompra(Compra compra)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                // VALIDACIONES
                if (compra.Proveedor == null || compra.Proveedor.IdProveedor <= 0)
                    throw new Exception("Debe seleccionar un proveedor.");

                if (compra.Detalles == null || compra.Detalles.Count == 0)
                    throw new Exception("La compra debe tener al menos un detalle.");

                foreach (var d in compra.Detalles)
                {
                    if (d.Cantidad <= 0)
                        throw new Exception("La cantidad debe ser mayor a cero.");
                    if (d.PrecioUnitario <= 0)
                        throw new Exception("El precio unitario debe ser mayor a cero.");
                }

                // INSERTA COMPRA Y OBTIENE ID
                datos.setearConsulta(
                    "INSERT INTO Compras (Fecha, IdProveedor, Total, IdUsuario) " +
                    "OUTPUT INSERTED.IdCompra VALUES (@Fecha, @IdProveedor, 0, @IdUsuario)"
                );

                datos.setearParametro("@Fecha", compra.Fecha);
                datos.setearParametro("@IdProveedor", compra.Proveedor.IdProveedor);
                datos.setearParametro("@IdUsuario", compra.IdUsuario);

                int idCompra = (int)datos.ejecutarScalar();

                decimal totalCompra = 0;

                //  DETALLE
                foreach (var detalle in compra.Detalles)
                {
                    // INSERTA DETALLE
                    datos.setearConsulta(
                        @"INSERT INTO DetalleCompra (IdCompra, IdProducto, Cantidad, PrecioUnitario) 
                  VALUES (@IdCompra, @IdProducto, @Cantidad, @PrecioUnitario)"
                    );

                    datos.setearParametro("@IdCompra", idCompra);
                    datos.setearParametro("@IdProducto", detalle.Producto.IdProducto);
                    datos.setearParametro("@Cantidad", detalle.Cantidad);
                    datos.setearParametro("@PrecioUnitario", detalle.PrecioUnitario);

                    datos.ejecutarAccion();

                    // CALCULA TOTAL
                    totalCompra += detalle.Cantidad * detalle.PrecioUnitario;

                    // ACTUALIZA STOCK
                    datos.setearConsulta(
                        @"UPDATE Productos
                  SET StockActual = StockActual + @Cantidad
                  WHERE IdProducto = @IdProducto"
                    );

                    datos.setearParametro("@Cantidad", detalle.Cantidad);
                    datos.setearParametro("@IdProducto", detalle.Producto.IdProducto);

                    datos.ejecutarAccion();
                }

                // ACTUALIZA TOTAL DE LA COMPRA
                datos.setearConsulta(
                    "UPDATE Compras SET Total = @Total WHERE IdCompra = @IdCompra"
                );

                datos.setearParametro("@Total", totalCompra);
                datos.setearParametro("@IdCompra", idCompra);

                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void DarDeBaja(int idCompra, string motivo)
        {
            AccesoDatos datos = new AccesoDatos();

            // Baja compra
            datos.setearConsulta("UPDATE Compras SET Activo = 0, MotivoBaja = @motivo WHERE IDCompra = @id");
            datos.setearParametro("@id", idCompra);
            datos.setearParametro("@motivo", motivo);
            datos.ejecutarAccion();
        }

        public List<Compra> Listar(bool? activo = null)
        {
            List<Compra> lista = new List<Compra>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                string consulta = @"SELECT C.IdCompra, C.Fecha, C.Total, C.Activo, 
                               P.IdProveedor, P.Nombre AS Proveedor
                               FROM Compras C
                               INNER JOIN Proveedores P ON C.IdProveedor = P.IdProveedor 
                               WHERE (@Activo IS NULL OR C.Activo = @Activo)";

                datos.setearConsulta(consulta);

                if (activo.HasValue)
                    datos.setearParametro("@Activo", activo.Value);
                else
                    datos.setearParametro("@Activo", DBNull.Value);
                

                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Compra c = new Compra();
                    c.IdCompra = (int)datos.Lector["IdCompra"];
                    c.Fecha = (DateTime)datos.Lector["Fecha"];
                    c.Total = (decimal)datos.Lector["Total"];
                    c.Proveedor = new Proveedor
                    {
                        IdProveedor = (int)datos.Lector["IdProveedor"],
                        Nombre = datos.Lector["Proveedor"].ToString()
                    };
                    c.Activo = (bool)datos.Lector["Activo"];

                    lista.Add(c);
                }

                return lista;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public Compra BuscarPorId(int IdCompra = 0)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                string consulta = @"SELECT C.IdCompra, C.Fecha, C.Total, C.Activo, C.MotivoBaja, 
                               P.IdProveedor, P.Nombre AS Proveedor 
                               FROM Compras C 
                               INNER JOIN Proveedores P ON C.IdProveedor = P.IdProveedor  
                               WHERE (@id = C.IdCompra)";

                datos.setearConsulta(consulta);
                datos.setearParametro("@id", IdCompra);

                datos.ejecutarLectura();
                Compra c = new Compra();
                while (datos.Lector.Read())
                {
                    c.IdCompra = (int)datos.Lector["IdCompra"];
                    c.Fecha = (DateTime)datos.Lector["Fecha"];
                    c.Total = (decimal)datos.Lector["Total"];
                    c.MotivoBaja = (string)datos.Lector["MotivoBaja"];
                    c.Activo = (bool)datos.Lector["Activo"];

                    c.Proveedor = new Proveedor
                    {
                        IdProveedor = (int)datos.Lector["IdProveedor"],
                        Nombre = datos.Lector["Proveedor"].ToString()
                    };
                    
                }
                return c;

            }
            finally
            {
                datos.cerrarConexion();
            }
        }


    }

}
