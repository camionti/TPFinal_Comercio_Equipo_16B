using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public enum Rol
    {
        Administrador = 1,
        Vendedor = 2,
    }
    public class Usuario
    {
        public int IdUsuario { get; set; }
        public string NombreUsuario { get; set; }
        public string Contrasenia { get; set; }
        public Rol Rol { get; set; }  // Administrador o Vendedor

        public Usuario() { }
        public Usuario(string nombreusuario, string contrasenia, bool administrador)
        {
            NombreUsuario = nombreusuario;
            Contrasenia = contrasenia;
            Rol = administrador ? Rol.Administrador : Rol.Vendedor;
        }

        public bool Activo { get; set; }
    }
}
