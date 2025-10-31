using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Compra
    {
        public int IdCompra { get; set; }
        public DateTime Fecha { get; set; }
        public int IdProveedor { get; set; }
        public Proveedor Proveedor { get; set; }

        public int IdUsuario { get; set; }
        public Usuario Usuario { get; set; }

        public decimal Total { get; set; }

        public List<DetalleCompra> Detalles { get; set; } = new List<DetalleCompra>();
    }
}
