<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page" %>

<script runat="server">
    public string branch_id, disabled_sts, pict_url;
    
    void Page_Load(object o, EventArgs e)
    {
        _test.App a = new _test.App(Request, Response);
        branch_id = (a.BranchID == "") ? "%" : a.BranchID;
        disabled_sts = (a.BranchID == "") ? "" : "disabled";

        
        string strSQL = "select Nilai from appParameter where kode='pictlink'";

        _test._DBcon c = new _test._DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            pict_url = row["Nilai"].ToString();
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" src="../../js/Komponen.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <asp:ScriptManager runat="server" ID="sm">
        <Services>
            <asp:ServiceReference Path="../activities.asmx" />
        </Services>
    </asp:ScriptManager>  

    <table class="formview">
        <tr>
            <th>SN</th>
            <td><input type="text" id="cari_sn" size="50" maxlength="50"/></td>
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.load();">Cari</div></td>
        </tr>
    </table>
    
    <iframe class="frameList" id="cari_fr"></iframe>

    <div id="mdl">
        <fieldset>
            <legend></legend>
            <table class="formview">                
                <tr>
                    <th>Tanggal Masuk</th>
                    <td><label id="mdl_datein"></label></td>
                    <td style="width:50px;"></td>
                    <th>SN</th>
                    <td><label id="mdl_sn"/></td>
                </tr>
                <tr>
                    <th>Device</th>
                    <td><label id="mdl_device"/></td>
                    <td></td>
                    <th>Nama User</th>
                    <td><label id="mdl_user"/></td>
                </tr>           
                <tr>
                    <th>Garansi</th>
                    <td><input type="checkbox" id="mdl_guarantee" disabled="disabled"/></td>
                    <td colspan="3"></td>
                </tr>
                <tr>
                    <th>Kelengkapan</th>
                    <td colspan="4">
                        <table class="gridView" id="mdl_tbl">
                            <tr>                                
                                <th>Kelengkapan</th>
                            </tr>
                        </table>
                    </td>
                </tr>   
                <tr>
                    <th>Gambar</th>
                    <td colspan="4">
                        <iframe id="mdl_fr" class="frameList" style="width:800px;height:600px;"></iframe>
                    </td>
                </tr>             
            </table>

            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Close"/>
            </div>
        </fieldset>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var cari = {
            tb_sn: apl.func.get("cari_sn"),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var sn = escape("%" + cari.tb_sn.value);

                cari.fl.src = "service_device_list.aspx?sn=" + sn + "&status=%&name=%&status_opr=%&status_send=%&inventory=%&branch=%";
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                service_device_id: 0,
                device_type_id: 0,
                lb_datein: apl.func.get("mdl_datein"),
                lb_sn: apl.func.get("mdl_sn"),
                lb_device: apl.func.get("mdl_device"),
                lb_user: apl.func.get("mdl_user"),
                cb_guarantee: apl.func.get("mdl_guarantee"),
                fl:apl.func.get("mdl_fr"),
                tbl: apl.createTableWS.init("mdl_tbl",
                    [
                        apl.createTableWS.column("trimming_name")
                    ]
                ),
                tbl_load: function () {
                    activities.xml_tec_service_device_trimming_list(mdl.service_device_id, mdl.device_type_id,
                        function (arrData) {
                            mdl.tbl.load(arrData);
                        }, apl.func.showError, ""
                    );
                },
                edit:function(id)
                {
                    apl.func.showSinkMessage("Memuat Data");                    
                    activities.tec_service_device_data(id,
                        function (data) {
                            mdl.service_device_id = id;
                            mdl.device_type_id = data.device_type_id;

                            mdl.lb_datein.innerHTML = data.date_in;
                            mdl.lb_sn.innerHTML = data.sn;
                            mdl.lb_device.innerHTML = data.device;
                            mdl.cb_guarantee.checked = data.guarantee_sts;                            
                            mdl.lb_user.innerHTML = data.user_name;
                            

                            mdl.tbl_load();
                            mdl.fl.src = "<%= pict_url %>?id="+id;

                            mdl.showEdit("Gambar Device - Edit");
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                }
                
            }, undefined, undefined, undefined, "frm_page", "cover_content"
        );

        window.addEventListener("load", function () {
            document.list_edit = mdl.edit;
        });
        
    </script>
</asp:Content>

