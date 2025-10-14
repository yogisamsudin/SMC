<%@ WebHandler Language="C#" Class="download_coretax" %>

using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using ClosedXML.Excel;
using _test;



public class download_coretax : IHttpHandler {
    const int rowHeader = 3;
    
    private string getNPWPcom()
    {
        string npwp = "";
        
        _DBcon d = new _DBcon();

        string _connectionString = d.getConnectionString();


        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            try
            {
                conn.Open();
                string query = "select nilai from appParameter where kode='npwpcom'";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                    npwp = dt.Rows[0]["nilai"].ToString();
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error saat mengambil data dari database: " + ex.Message);
            }
        }
        return npwp;
    }

    private DataTable GetDataFaktur()
    {
        _DBcon d = new _DBcon();

        string _connectionString = d.getConnectionString();


        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            try
            {
                conn.Open();
                string query = "select * from tmp_pajak_faktur";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error saat mengambil data dari database: " + ex.Message);
            }
        }
        return dt;
    }
    private DataTable GetDataFakturDetail()
    {
        _DBcon d = new _DBcon();

        string _connectionString = d.getConnectionString();


        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            try
            {
                conn.Open();
                string query = "select * from tmp_pajak_fakturdetail";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error saat mengambil data dari database: " + ex.Message);
            }
        }
        return dt;
    }
    private void setSheetFaktur(XLWorkbook wb, DataTable dt)
    {
        var ws = wb.Worksheets.Add("Faktur");

        ws.Column(1).Style.NumberFormat.Format = "@";
        ws.Column(2).Style.DateFormat.Format = "MM/dd/yyyy";        
        ws.Column(3).Style.NumberFormat.Format = "@";
        ws.Column(4).Style.NumberFormat.Format = "@";
        ws.Column(5).Style.NumberFormat.Format = "@";
        ws.Column(6).Style.NumberFormat.Format = "@";
        ws.Column(7).Style.NumberFormat.Format = "@";
        ws.Column(8).Style.NumberFormat.Format = "@";
        ws.Column(9).Style.NumberFormat.Format = "@";
        ws.Column(10).Style.NumberFormat.Format = "@";
        ws.Column(11).Style.NumberFormat.Format = "@";
        ws.Column(12).Style.NumberFormat.Format = "@";
        ws.Column(13).Style.NumberFormat.Format = "@";
        ws.Column(14).Style.NumberFormat.Format = "@";
        ws.Column(15).Style.NumberFormat.Format = "@";
        ws.Column(16).Style.NumberFormat.Format = "@";
        ws.Column(17).Style.NumberFormat.Format = "@";

        var mergeRange = ws.Range("A1:B1"); // Rentang yang akan digabung
        mergeRange.Merge();
        mergeRange.Value = "NPWP Penjual"; // Teks dalam sel yang digabungkan

        //ws.Cell(1, 1).Value = "NPWP Penjual";
        //ws.Cell(1, 3).Value = "0537037731044000";
        ws.Cell(1, 3).Value = getNPWPcom();

        // Tambahkan Header
        ws.Cell(rowHeader, 1).Value = "Baris";
        ws.Cell(rowHeader, 2).Value = "Tanggal Faktur";
        ws.Cell(rowHeader, 3).Value = "Jenis Faktur";
        ws.Cell(rowHeader, 4).Value = "Kode Transaksi";
        ws.Cell(rowHeader, 5).Value = "Keterangan Tambahan";
        ws.Cell(rowHeader, 6).Value = "Dokumen Pendukung";
        ws.Cell(rowHeader, 7).Value = "Referensi";
        ws.Cell(rowHeader, 8).Value = "Cap Fasilitas";
        ws.Cell(rowHeader, 9).Value = "ID TKU Penjual";
        ws.Cell(rowHeader, 10).Value = "NPWP/NIK Pembeli";
        ws.Cell(rowHeader, 11).Value = "Jenis ID Pembeli";
        ws.Cell(rowHeader, 12).Value = "Negara Pembeli";
        ws.Cell(rowHeader, 13).Value = "Nomor Dokumen Pembeli";
        ws.Cell(rowHeader, 14).Value = "Nama Pembeli";
        ws.Cell(rowHeader, 15).Value = "Alamat Pembeli";
        ws.Cell(rowHeader, 16).Value = "Email Pembeli";
        ws.Cell(rowHeader, 17).Value = "ID TKU Pembeli";
        ws.Cell(rowHeader, 18).Value = "keterangan";

        //string dateString = "20/02/2025"; // Format dd/MM/yyyy
        //DateTime date = DateTime.Parse(dateString);
        // Tambahkan Data
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            ws.Cell(i + rowHeader + 1, 1).Value = dt.Rows[i]["baris"].ToString();
            ws.Cell(i + rowHeader + 1, 2).Value = DateTime.Parse( dt.Rows[i]["tglfaktur"].ToString());
            ws.Cell(i + rowHeader + 1, 3).Value = dt.Rows[i]["jenisfaktur"].ToString();
            ws.Cell(i + rowHeader + 1, 4).Value = dt.Rows[i]["kodetransaksi"].ToString();
            ws.Cell(i + rowHeader + 1, 5).Value = dt.Rows[i]["keterangantambahan"].ToString();
            ws.Cell(i + rowHeader + 1, 6).Value = dt.Rows[i]["dokpendukung"].ToString();
            ws.Cell(i + rowHeader + 1, 7).Value = dt.Rows[i]["referensi"].ToString();
            ws.Cell(i + rowHeader + 1, 8).Value = dt.Rows[i]["capfasilitas"].ToString();
            ws.Cell(i + rowHeader + 1, 9).Value = dt.Rows[i]["idtkupenjual"].ToString();
            ws.Cell(i + rowHeader + 1, 10).Value = dt.Rows[i]["npwpnikpembeli"].ToString();
            ws.Cell(i + rowHeader + 1, 11).Value = dt.Rows[i]["jenisidpembeli"].ToString();
            ws.Cell(i + rowHeader + 1, 12).Value = dt.Rows[i]["negarapembeli"].ToString();
            ws.Cell(i + rowHeader + 1, 13).Value = dt.Rows[i]["nodokpembeli"].ToString();
            ws.Cell(i + rowHeader + 1, 14).Value = dt.Rows[i]["namapembeli"].ToString();
            ws.Cell(i + rowHeader + 1, 15).Value = dt.Rows[i]["alamatpembeli"].ToString();
            ws.Cell(i + rowHeader + 1, 16).Value = dt.Rows[i]["emailpembeli"].ToString();
            ws.Cell(i + rowHeader + 1, 17).Value = dt.Rows[i]["idtkupembeli"].ToString();
            ws.Cell(i + rowHeader + 1, 18).Value = null;

        }
        //ws.Cell(dt.Rows.Count + rowHeader + 1, 1).Style.NumberFormat.Format = "@";
        ws.Cell(dt.Rows.Count + rowHeader + 1, 1).Value = "END";

        // Format Otomatis
        ws.Columns().AdjustToContents();
    }
    private void setSheetDetailFaktur(XLWorkbook wb, DataTable dt)
    {
        var ws = wb.Worksheets.Add("DetailFaktur");

        ws.Column(1).Style.NumberFormat.Format = "0";
        ws.Column(2).Style.NumberFormat.Format = "@";
        ws.Column(3).Style.NumberFormat.Format = "@";
        ws.Column(4).Style.NumberFormat.Format = "@";
        ws.Column(5).Style.NumberFormat.Format = "@";
        ws.Column(6).Style.NumberFormat.Format = "0.00";
        ws.Column(7).Style.NumberFormat.Format = "0";
        ws.Column(8).Style.NumberFormat.Format = "0.00";
        ws.Column(9).Style.NumberFormat.Format = "0.00";
        ws.Column(10).Style.NumberFormat.Format = "0.00";
        ws.Column(11).Style.NumberFormat.Format = "0";
        ws.Column(12).Style.NumberFormat.Format = "0.00";
        ws.Column(13).Style.NumberFormat.Format = "0";
        ws.Column(14).Style.NumberFormat.Format = "0.00";

        ws.Cell(1, 1).Value = "Baris";
        ws.Cell(1, 2).Value = "Barang/Jasa";
        ws.Cell(1, 3).Value = "Kode Barang Jasa";
        ws.Cell(1, 4).Value = "Nama Barang/Jasa";
        ws.Cell(1, 5).Value = "Nama Satuan Ukur";
        ws.Cell(1, 6).Value = "Harga Satuan";
        ws.Cell(1, 7).Value = "Jumlah Barang Jasa";
        ws.Cell(1, 8).Value = "Total Diskon";
        ws.Cell(1, 9).Value = "DPP";
        ws.Cell(1, 10).Value = "DPP Nilai Lain";
        ws.Cell(1, 11).Value = "Tarif PPN";
        ws.Cell(1, 12).Value = "PPN";
        ws.Cell(1, 13).Value = "Tarif PPnBM";
        ws.Cell(1, 14).Value = "PPnBM";

        // Tambahkan Data
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            ws.Cell(i + 2, 1).Value = Convert.ToInt32(dt.Rows[i]["baris"]);
            ws.Cell(i + 2, 2).Value = dt.Rows[i]["barangjasa"].ToString();
            ws.Cell(i + 2, 3).Value = dt.Rows[i]["kodebarangjasa"].ToString();
            ws.Cell(i + 2, 4).Value = dt.Rows[i]["namabarangjasa"].ToString();
            ws.Cell(i + 2, 5).Value = dt.Rows[i]["namasatuanukur"].ToString();
            ws.Cell(i + 2, 6).Value = dt.Rows[i]["hargasatuan"].ToString();
            ws.Cell(i + 2, 7).Value = dt.Rows[i]["jumlahbarangjasa"].ToString();
            ws.Cell(i + 2, 8).Value = dt.Rows[i]["totaldiskon"].ToString();
            ws.Cell(i + 2, 9).Value = dt.Rows[i]["dpp"].ToString();
            ws.Cell(i + 2, 10).Value = dt.Rows[i]["dppnilailain"].ToString();
            ws.Cell(i + 2, 11).Value = dt.Rows[i]["tarifppn"].ToString();
            ws.Cell(i + 2, 12).Value = dt.Rows[i]["ppn"].ToString();
            ws.Cell(i + 2, 13).Value = dt.Rows[i]["tarifppnbm"].ToString();
            ws.Cell(i + 2, 14).Value = dt.Rows[i]["ppnbm"].ToString();

        }
        ws.Cell(dt.Rows.Count + 2, 1).Style.NumberFormat.Format = "@";
        ws.Cell(dt.Rows.Count+2, 1).Value = "END";
        ws.Columns().AdjustToContents();
    }
    public void ProcessRequest (HttpContext context) 
    {
        string tanggal = context.Request.QueryString["tanggal"].ToString();
        string[] arr = tanggal.Split('/');
        string FileName = "CORETAX_" + arr[2] + arr[1] + arr[0] + ".xlsx";
         
        
        DataTable df = GetDataFaktur();
        DataTable dfd = GetDataFakturDetail();
        
        if (df.Rows.Count == 0)
        {
            //context.Response.ContentType = "text/plain";
            //context.Response.Write("Tidak ada data untuk diekspor.");
            //context.Response.RedirectLocation = "coretax_download.aspx";
            context.Response.Redirect("coretax_download.aspx?pesan=data tidak ditemukan, silahkan ulangi kembali");
            return;
        }

        using (XLWorkbook wb = new XLWorkbook())
        {
            setSheetFaktur(wb, df);
            setSheetDetailFaktur(wb, dfd);

            using (MemoryStream stream = new MemoryStream())
            {
                wb.SaveAs(stream);
                byte[] excelData = stream.ToArray();

                context.Response.Clear();
                context.Response.Buffer = true;
                context.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                context.Response.AddHeader("content-disposition", "attachment;filename="+FileName);
                context.Response.BinaryWrite(excelData);
                context.Response.End();
            }
        }
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}