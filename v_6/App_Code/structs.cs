using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using _test;

/// <summary>
/// Summary description for structs
/// </summary>
public struct s_karyawan
{
    public string name, address;
    public s_karyawan(string _name, string _address)
	{
        name = _name;
        address = _address;
	}
}

public abstract class data
{
    public string sqlScript;

    public System.Data.DataRowCollection getData(string filterScript)
    {
        _DBcon c = new _DBcon();
        string whereScript = (filterScript==null || filterScript == "") ? "" : " where " + filterScript;
        return c.executeTextQ_sdr(sqlScript + whereScript);        
    }

    public abstract object readData();
}

public class karyawan : data
{
    private s_karyawan d_karyawan;
    public karyawan()
    {
        sqlScript = "select name, address from tbl_karyawan";
    }

    public override object readData()
    {
        List<s_karyawan> arr = new List<s_karyawan>();
        return arr.ToArray();
    }
}

public class mainClass
{
    karyawan dk;
    s_karyawan[] arr;
    public void loadData()
    {
        dk = new karyawan();
        arr = (s_karyawan[])dk.readData();
    }
}

