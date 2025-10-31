using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace Dominio
{
    public class Producto
    {
        public int IdProducto { get; set; }
        public string Nombre { get; set; }
        public Marca Marca { get; set; }
        public Categoria Categoria { get; set; }
        public int StockActual { get; set; }
        public int StockMinimo { get; set; }
        public decimal PorcentajeGanancia { get; set; }
        public decimal Precio { get; set; }
        public List<Imagen> Imagenes { get; set; }

        // Relacion con proveedores
        public List<Proveedor> Proveedores { get; set; } = new List<Proveedor>();
    }

}
