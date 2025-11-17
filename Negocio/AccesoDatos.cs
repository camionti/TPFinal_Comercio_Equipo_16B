using Dominio;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace Negocio
{
    public class AccesoDatos
    {
        private SqlConnection conexion;
        private SqlCommand comando;
        private SqlDataReader lector;

        public SqlDataReader Lector { get { return lector; } }

        public AccesoDatos()
        {
            conexion = new SqlConnection("server=.\\SQLEXPRESS; database=ComercioDB; integrated security=true;");
            comando = new SqlCommand();
        }

        public void setearConsulta(string consulta)
        {
            comando.Parameters.Clear(); 
            comando.CommandType = CommandType.Text;
            comando.CommandText = consulta;
        }

        public void setearParametro(string nombre, object valor)
        {
            comando.Parameters.AddWithValue(nombre, valor);
        }

        public void ejecutarLectura()
        {
            comando.Connection = conexion;

            try
            {
                if (conexion.State != ConnectionState.Open) 
                    conexion.Open();

                lector = comando.ExecuteReader();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void ejecutarAccion()
        {
            comando.Connection = conexion;

            try
            {
                if (conexion.State != ConnectionState.Open) 
                    conexion.Open();

                comando.ExecuteNonQuery(); 
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                conexion.Close(); 
            }
        }

        public object ejecutarScalar()
        {
            comando.Connection = conexion;

            try
            {
                if (conexion.State != ConnectionState.Open)
                    conexion.Open();

                return comando.ExecuteScalar(); 
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                conexion.Close(); 
            }
        }

        public void cerrarConexion()
        {
            try
            {
                if (lector != null && !lector.IsClosed)
                    lector.Close();

                if (conexion != null && conexion.State == ConnectionState.Open)
                    conexion.Close();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }

}
