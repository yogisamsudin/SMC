using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Npgsql;
using System;

namespace _test
{
    public class _DBConPostGree
    {
        public void test()
        {
            string connectionString = "Host=localhost;Port=5432;Database=test;User Id=postgres;Password=123;";

            NpgsqlConnection connection = new NpgsqlConnection(connectionString);
            connection.Open();

            NpgsqlCommand cmd = new NpgsqlCommand("SELECT * FROM doc_files", connection);

            NpgsqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                Console.WriteLine(reader["doc_file_id"]);
                // Use the fetched results
            }
        }
        
    }
}