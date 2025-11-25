using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class DetalleVenta
    {
        public int IdDetalleVenta { get; set; }
        public int IdVenta { get; set; }
        public Producto Producto { get; set; }
        public int Cantidad { get; set; }
        public decimal PrecioUnitario { get; set; }
        public decimal PrecioConGanancia
        {
            get
            {
                return PrecioUnitario + (PrecioUnitario * Producto.PorcentajeGanancia / 100);
            }
        }

        public decimal Subtotal
        {
            get
            {
                return Cantidad * PrecioConGanancia;
            }
        }
    }
}
