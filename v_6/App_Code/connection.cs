using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Xml;
using System.IO;
using System.IO.Compression;

namespace _test
{
    public class _DBcon : System.IDisposable
    {
        public string connectionString;
        private SqlConnection _con;
        private SqlCommand _com;
        private XmlReader _xml;

        public string getConnectionString()
        {
            return System.Configuration.ConfigurationManager.ConnectionStrings["csApp"].ConnectionString;
        }
        public int getCommandTimeout()
        {
            return Convert.ToInt32((System.Configuration.ConfigurationManager.AppSettings["CommandTimeout"] == null) ? "0" : System.Configuration.ConfigurationManager.AppSettings["CommandTimeout"]);
        }
        public _DBcon()
        {
            //connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["conSMC"].ConnectionString;
            connectionString = getConnectionString();
        }
        public struct sComParameter
        {
            public string ParamName, TypeName;
            public System.Data.SqlDbType dbType;
            public int Length;
            public object Value;
            public ParameterDirection parDir;
            public sComParameter(string _ParamName, System.Data.SqlDbType _dbType, int _Length, object _Value)
            {
                ParamName = _ParamName;
                dbType = _dbType;
                Length = _Length;
                Value = _Value;
                parDir = ParameterDirection.Input;
                TypeName = null;
            }
            public sComParameter(string _ParamName, System.Data.SqlDbType _dbType, int _Length, ParameterDirection _ParDir)
            {
                ParamName = _ParamName;
                dbType = _dbType;
                Length = _Length;
                Value = null;
                parDir = _ParDir;
                TypeName = null;
            }
            public sComParameter(string _ParamName, System.Data.SqlDbType _dbType, int _Length, object _Value, string _TypeName)
            {
                ParamName = _ParamName;
                dbType = _dbType;
                Length = _Length;
                Value = _Value;
                parDir = ParameterDirection.Input;
                TypeName = _TypeName;
            }
        }
        struct sOutComPar
        {
            public string parName;
            public object parNilai;
            public sOutComPar(string _ParName, object _parNilai)
            {
                parName = _ParName;
                parNilai = _parNilai;
            }
        }
        public struct arrOutComPar
        {
            sOutComPar[] dtOutPar;
            public void getOutParam(sComParameter[] dt, SqlCommand _c)
            {
                List<sOutComPar> arrData = new List<sOutComPar>();
                if (dt != null)
                {
                    foreach (sComParameter d in dt)
                    {
                        if (d.parDir == ParameterDirection.Output)
                        {
                            arrData.Add(new sOutComPar(d.ParamName, _c.Parameters[d.ParamName].Value));
                        }
                    }
                }
                dtOutPar = arrData.ToArray();
            }
            object getNilai(string parName)
            {
                foreach (sOutComPar dt in dtOutPar)
                {
                    if (dt.parName == parName)
                    {
                        return dt.parNilai;
                    }
                }
                return null;
            }
            public object this[string Name]
            {
                get
                {
                    return getNilai(Name);
                }
            }
        }
        public arrOutComPar executeProcNQ(string strProcName, sComParameter[] dtComParameter)
        {
            using (_con = new SqlConnection(connectionString))
            {
                _con.Open();

                _com = new SqlCommand();
                _com.Connection = _con;
                _com.CommandType = CommandType.StoredProcedure;
                _com.CommandText = strProcName;
                _com.CommandTimeout = getCommandTimeout();

                if (dtComParameter != null)
                {
                    foreach (sComParameter dComPar in dtComParameter)
                    {
                        //_com.Parameters.Add(dComPar.ParamName, dComPar.dbType, dComPar.Length,ParameterDirection.Input).Value = dComPar.Value;
                        if (dComPar.parDir == ParameterDirection.Input)
                        {
                            _com.Parameters.Add(dComPar.ParamName, dComPar.dbType, dComPar.Length).Value = dComPar.Value;
                        }
                        else
                        {
                            _com.Parameters.Add(dComPar.ParamName, dComPar.dbType, dComPar.Length).Direction = dComPar.parDir;
                        }
                    }
                }


                _com.Transaction = _con.BeginTransaction();

                Boolean error = false;

                try
                {
                    _com.ExecuteNonQuery();


                }
                catch (Exception ex)
                {
                    error = true;
                    _com.Transaction.Rollback();
                    throw;
                }
                finally
                {
                    if (error == false) _com.Transaction.Commit();
                }


                arrOutComPar data = new arrOutComPar();
                data.getOutParam(dtComParameter, _com);
                _com.Dispose();
                return data;



            }
        }
        DataRowCollection createRows(XmlReader xml)
        {
            DataSet ds = new DataSet();
            ds.ReadXml(xml, XmlReadMode.Fragment);
            xml.Close();
            return ds.Tables[0].Rows;
        }
        public DataRowCollection executeProcQR(string strProcName, sComParameter[] dtComParameter, ref arrOutComPar retval)
        {
            DataRowCollection data;
            using (_con = new SqlConnection(connectionString))
            {
                _con.Open();
                _com = new SqlCommand();
                _com.Connection = _con;
                _com.CommandType = CommandType.StoredProcedure;
                _com.CommandText = strProcName;
                _com.CommandTimeout = getCommandTimeout();
                foreach (sComParameter dComPar in dtComParameter)
                {
                    //_com.Parameters.Add(dComPar.ParamName, dComPar.dbType, dComPar.Length).Value = dComPar.Value;
                    if (dComPar.parDir == ParameterDirection.Input)
                    {
                        _com.Parameters.Add(dComPar.ParamName, dComPar.dbType, dComPar.Length).Value = dComPar.Value;
                    }
                    else
                    {
                        _com.Parameters.Add(dComPar.ParamName, dComPar.dbType, dComPar.Length).Direction = dComPar.parDir;
                    }
                }
                _com.Transaction = _con.BeginTransaction();
                Boolean error = false;

                try
                {
                    _xml = _com.ExecuteXmlReader();

                }
                catch (Exception ex)
                {
                    error = true;
                    _com.Transaction.Rollback();
                }
                finally
                {
                    if (error == false) _com.Transaction.Commit();
                }

                data = createRows(_xml);

                retval = new arrOutComPar();
                retval.getOutParam(dtComParameter, _com);

                _com.Dispose();
            }

            return data;
        }
        public DataRowCollection executeProcQ(string strProcName, sComParameter[] dtComParameter)
        {
            DataRowCollection data;
            using (_con = new SqlConnection(connectionString))
            {
                _con.Open();
                _com = new SqlCommand();
                _com.Connection = _con;
                _com.CommandType = CommandType.StoredProcedure;
                _com.CommandText = strProcName;
                _com.CommandTimeout = getCommandTimeout();

                if (dtComParameter != null)
                {
                    foreach (sComParameter dComPar in dtComParameter)
                    {
                        _com.Parameters.Add(dComPar.ParamName, dComPar.dbType, dComPar.Length).Value = dComPar.Value;
                    }
                }

                /*
                _com.Transaction = _con.BeginTransaction();
                Boolean error = false;

                try
                {
                    _xml = _com.ExecuteXmlReader();
                    
                }
                catch (Exception ex)
                {
                    error = true;
                    _com.Transaction.Rollback();
                }
                finally
                {
                    if (error == false) _com.Transaction.Commit();
                }
                */
                _xml = _com.ExecuteXmlReader();
                data = createRows(_xml);
                _com.Dispose();
            }

            return data;
        }
        public DataRowCollection executeTextQ(string strSQL)
        {
            DataRowCollection data;
            using (_con = new SqlConnection(connectionString))
            {
                _con.Open();
                _com = new SqlCommand();
                _com.Connection = _con;
                _com.CommandType = CommandType.Text;
                _com.CommandText = strSQL + " for xml auto,xmldata";
                _com.CommandTimeout = getCommandTimeout();
                _xml = _com.ExecuteXmlReader();
                data = createRows(_xml);
                _com.Dispose();
            }

            return data;
        }
        public DataRowCollection executeTextQ_sdr(string strSQL)
        {
            DataSet ds = new DataSet();

            using (_con = new SqlConnection(connectionString))
            {
                _con.Open();
                _com = new SqlCommand();
                _com.Connection = _con;
                _com.CommandType = CommandType.Text;
                _com.CommandText = strSQL;
                _com.CommandTimeout = getCommandTimeout();
                SqlDataAdapter adap = new SqlDataAdapter(_com);
                adap.Fill(ds);
                _com.Dispose();
            }

            return ds.Tables[0].Rows;
        }
        public DataRowCollection executeProcQ_sdr(string strSQL, sComParameter[] dtComParameter)
        {
            DataSet ds = new DataSet();

            using (_con = new SqlConnection(connectionString))
            {
                _con.Open();
                _com = new SqlCommand();
                _com.Connection = _con;
                _com.CommandType = CommandType.Text;
                _com.CommandText = strSQL;
                _com.CommandTimeout = getCommandTimeout();
                if (dtComParameter != null)
                {
                    foreach (sComParameter dComPar in dtComParameter)
                    {
                        _com.Parameters.Add(dComPar.ParamName, dComPar.dbType, dComPar.Length).Value = dComPar.Value;
                    }
                }
                SqlDataAdapter adap = new SqlDataAdapter(_com);
                adap.Fill(ds);
                _com.Dispose();
            }

            return ds.Tables[0].Rows;
        }
        public byte[] array_compress(byte[] buffer)
        {
            MemoryStream ms = new MemoryStream();
            GZipStream zip = new GZipStream(ms, CompressionMode.Compress, true);
            zip.Write(buffer, 0, buffer.Length);
            zip.Close();
            ms.Position = 0;

            MemoryStream outStream = new MemoryStream();

            byte[] compressed = new byte[ms.Length];
            ms.Read(compressed, 0, compressed.Length);

            byte[] gzBuffer = new byte[compressed.Length + 4];
            Buffer.BlockCopy(compressed, 0, gzBuffer, 4, compressed.Length);
            Buffer.BlockCopy(BitConverter.GetBytes(buffer.Length), 0, gzBuffer, 0, 4);
            return gzBuffer;
        }
        public byte[] array_decompress(byte[] gzBuffer)
        {
            MemoryStream ms = new MemoryStream();
            int msgLength = BitConverter.ToInt32(gzBuffer, 0);
            ms.Write(gzBuffer, 4, gzBuffer.Length - 4);

            byte[] buffer = new byte[msgLength];

            ms.Position = 0;
            GZipStream zip = new GZipStream(ms, CompressionMode.Decompress);
            zip.Read(buffer, 0, buffer.Length);

            return buffer;
        }
        void IDisposable.Dispose()
        {

        }
    }
}