using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System.Configuration;

namespace _test
{
    public class rpt : System.IDisposable
    {
        //public rpt()
        //{

        //}
        public void ConnectionInfo(ReportDocument _rpt)
        {
            //string[] strConnection = ConfigurationManager.ConnectionStrings[("csApp")].ConnectionString.Split(new char[] { ';' });
            _DBcon d = new _DBcon();
            string[] strConnection = d.getConnectionString().Split(new char[] { ';' });

            Database oCRDb = _rpt.Database;
            Tables oCRTables = oCRDb.Tables;
            CrystalDecisions.CrystalReports.Engine.Table oCRTable = default(CrystalDecisions.CrystalReports.Engine.Table);
            TableLogOnInfo oCRTableLogonInfo = default(CrystalDecisions.Shared.TableLogOnInfo);
            ConnectionInfo oCRConnectionInfo = new CrystalDecisions.Shared.ConnectionInfo();

            oCRConnectionInfo.ServerName = strConnection[0].Split(new char[] { '=' }).GetValue(1).ToString();
            oCRConnectionInfo.DatabaseName = strConnection[1].Split(new char[] { '=' }).GetValue(1).ToString();
            oCRConnectionInfo.Password = strConnection[4].Split(new char[] { '=' }).GetValue(1).ToString();
            oCRConnectionInfo.UserID = strConnection[3].Split(new char[] { '=' }).GetValue(1).ToString();

            for (int i = 0; i < oCRTables.Count; i++)
            {
                oCRTable = oCRTables[i];
                oCRTableLogonInfo = oCRTable.LogOnInfo;
                oCRTableLogonInfo.ConnectionInfo = oCRConnectionInfo;
                oCRTable.ApplyLogOnInfo(oCRTableLogonInfo);
                if (oCRTable.TestConnectivity())
                    //' If there is a "." in the location then remove the
                    // ' beginning of the fully qualified location.
                    //' Example "dbo.northwind.customers" would become
                    //' "customers".
                    oCRTable.Location = oCRTable.Location.Substring(oCRTable.Location.LastIndexOf(".") + 1);
            }

            for (int i = 0; i < _rpt.Subreports.Count; i++)
            {

                {
                    oCRDb = _rpt.OpenSubreport(_rpt.Subreports[i].Name).Database;
                    oCRTables = oCRDb.Tables;
                    foreach (CrystalDecisions.CrystalReports.Engine.Table aTable in oCRTables)
                    {
                        oCRTableLogonInfo = aTable.LogOnInfo;
                        oCRTableLogonInfo.ConnectionInfo = oCRConnectionInfo;
                        aTable.ApplyLogOnInfo(oCRTableLogonInfo);
                        if (aTable.TestConnectivity())
                            //' If there is a "." in the location then remove the
                            // ' beginning of the fully qualified location.
                            //' Example "dbo.northwind.customers" would become
                            //' "customers".
                            aTable.Location = aTable.Location.Substring(aTable.Location.LastIndexOf(".") + 1);
                    }
                }
            }
            _rpt.Refresh();
        }

        
        void IDisposable.Dispose()
        {
        }
    }
}