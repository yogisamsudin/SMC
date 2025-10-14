using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using Npgsql;

namespace _test
{
    public class MigrationDB:System.IDisposable
    {
        public MigrationDB()
        {
            
        }
        public long SalesDocumentMigrasiData(string _ConnectionStringSQLServer, string _ConnectionStringPostgre)
        {
            long TotalRow = 0;
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(_ConnectionStringSQLServer))
                using (NpgsqlConnection pgConn = new NpgsqlConnection(_ConnectionStringPostgre))
                {
                    sqlConn.Open();
                    pgConn.Open();

                    string selectQuery = "select sales_id,file_name,file_image, file_type,update_date from opr_sales_document";
                    using (SqlCommand cmd = new SqlCommand(selectQuery, sqlConn))
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        TotalRow = 0;
                        while (reader.Read())
                        {
                            TotalRow++;
                            long sales_id = reader.GetInt64(0);
                            string file_name = reader.GetString(1);
                            System.Data.SqlTypes.SqlBinary file_image = reader.GetSqlBinary(2);
                            string file_type = reader.GetString(3);
                            DateTime update_date = reader.GetDateTime(4);

                            // Masukkan ke PostgreSQL
                            string insertQuery = "insert into sales_documents(salesid, file_name, file_image,  file_type, update_date)values(@p_salesid, @p_file_name, @p_file_image,  @p_file_type, @p_update_date)ON CONFLICT (salesid)DO UPDATE SET file_image = EXCLUDED.file_image, file_type=EXCLUDED.file_type,file_name=EXCLUDED.file_name, update_date=EXCLUDED.update_date;";
                            using (var insertCmd = new NpgsqlCommand(insertQuery, pgConn))
                            {
                                insertCmd.Parameters.AddWithValue("p_salesid", sales_id);
                                insertCmd.Parameters.AddWithValue("p_file_name", file_name);
                                insertCmd.Parameters.AddWithValue("p_file_image", (byte[])file_image);
                                insertCmd.Parameters.AddWithValue("p_file_type", file_type);
                                insertCmd.Parameters.AddWithValue("p_update_date", update_date);

                                insertCmd.ExecuteNonQuery();
                            }
                        }
                    }                    
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                throw;
            }
            return TotalRow;
        }
        void IDisposable.Dispose()
        {

        }
    }
    

}