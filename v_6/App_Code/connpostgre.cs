using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Npgsql;
using System;
using System.Data;

namespace _test
{
    public enum npgsqlcommandtype {CommandText, CommandStoreprocedure};

    public class _DBConPostGree : System.IDisposable
    {
        private string _ConnectionString;
        public struct s_parameter
        {
            public string parameter_name;
            public object parameter_value;
            public s_parameter(string _parameter_name, object _parameter_value)
            {
                parameter_name = _parameter_name;
                parameter_value = _parameter_value;
            }
        }
        public string getConnectionString()
        {
            return System.Configuration.ConfigurationManager.ConnectionStrings["pgApp"].ConnectionString;
        }
        public _DBConPostGree()
        {
            _ConnectionString = getConnectionString();
        }
        public DataRowCollection ExecuteQ(string query, s_parameter[] arrparameters = null, npgsqlcommandtype commandtype = npgsqlcommandtype.CommandText)
        {
            DataTable dt = new DataTable();
            string sQuery = "";

            using (var conn = new NpgsqlConnection(_ConnectionString))
            {
                try
                {

                    if(commandtype==npgsqlcommandtype.CommandStoreprocedure)
                    {
                        sQuery = "(";
                        foreach (s_parameter d in arrparameters)
                        {
                            //sQuery += "@" + d.parameter_name+",";
                            sQuery += d.parameter_name + ",";
                        }
                        sQuery = "CALL " + query + sQuery.Substring(0, sQuery.Length - 1)+")";
                    }else
                    {
                        sQuery = query;
                    }

                    conn.Open();
                    using (NpgsqlCommand cmd = new NpgsqlCommand(sQuery, conn))
                    {
                        if (arrparameters != null)
                        {
                            foreach (s_parameter d in arrparameters)
                            {
                                cmd.Parameters.AddWithValue(d.parameter_name, d.parameter_value);
                            }
                        }

                        NpgsqlDataReader dr = cmd.ExecuteReader();
                        dt.Load(dr);
                    }
                    conn.Close();

                }
                catch (Exception ex)
                {
                    Console.WriteLine("Terjadi kesalahan: " + ex.Message);
                    throw;
                }
            }

            return dt.Rows;
        }
        public void ExecuteNQ(string query, s_parameter[] arrparameters = null)
        {
            string sQuery = "";

            using (var conn = new NpgsqlConnection(_ConnectionString))
            {
                try
                {

                    sQuery = "(";
                    foreach (s_parameter d in arrparameters)
                    {
                        //sQuery += "@" + d.parameter_name + ",";
                        sQuery += d.parameter_name + ",";
                    }
                    sQuery = "CALL " + query + sQuery.Substring(0, sQuery.Length - 1) + ")";

                    conn.Open();
                    using (NpgsqlCommand cmd = new NpgsqlCommand(sQuery, conn))
                    {
                        if (arrparameters != null)
                        {
                            foreach (s_parameter d in arrparameters)
                            {
                                cmd.Parameters.AddWithValue(d.parameter_name, d.parameter_value);
                            }
                        }

                        int ret = cmd.ExecuteNonQuery();
                    }
                    conn.Close();

                }
                catch (Exception ex)
                {
                    Console.WriteLine("Terjadi kesalahan: " + ex.Message);
                    throw;
                }
            }

        }
        

        void IDisposable.Dispose()
        {

        }
        
    }

}