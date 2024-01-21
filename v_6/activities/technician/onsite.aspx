<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page"%>

<script runat="server">
    public string strAppDate;
    
    void Page_Load()
    {
        _test.App a = new _test.App(Request, Response);

        strAppDate =  a.ApplicationDate;
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
            <th>Customer</th>
            <td><input type="text" id="cari_customer" size="50" value="%"/></td>
        </tr>
        <tr>
            <th>No.Penawaran</th>
            <td><input type="text" id="cari_offerno" size="50" value="%"/></td>
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.load();">Cari</div></td>
        </tr>
    </table>
    
    <iframe class="frameList" id="cari_fl"></iframe> 

    <div id="mdl" class="modal">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Tgl.Aju</th>
                    <td><label id="mdl_reqdate"></label></td>
                </tr>
                <tr>
                    <th style="width:200px">No.Penawaran</th>
                    <td><label id="mdl_offerno"></label></td>
                </tr>
                <tr>
                    <th>Customer</th>
                    <td><label id="mdl_custname"></label></td>
                </tr>
                <tr>
                    <th>Alamat</th>
                    <td><textarea id="mdl_custaddress" disabled></textarea></td>
                </tr>
                <tr>
                    <th>Note</th>
                    <td><textarea id="mdl_note"></textarea></td>
                </tr>
                <tr>
                    <th style="width:200px">Tgl.Onsite</th>
                    <td><input type="text" id="mdl_onsitedate" size="10"/></td>
                </tr>
                <tr>
                    <th>No.Onsite</th>
                    <td><input type="text" id="mdl_onsiteno" disabled size="20"/></td>
                </tr>
                <tr>
                    <th>Teknisi</th>
                    <td><input type="text" id="mdl_technician" size="50"/></td>
                </tr>
                
                <tr>
                    <th>Selesai</th>
                    <td><input type="checkbox" id="mdl_donests"/></td>
                </tr>
                
            </table>
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Save"/>
                <input type="button" value="Cancel"/>
            </div>
        </fieldset>
    </div>

    <div id="mdlsel" class="modal">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>No.Penawaran</th>
                    <td><input type="text" size="20" id="mdlsel_offerno"/></td>
                </tr>
                <tr>
                    <th>Customer</th>
                    <td><input type="text" size="20" id="mdlsel_custname"/></td>
                </tr>
                <tr>
                    <th></th>
                    <td><div class="buttonCari" onclick="mdlsel.load();">Cari</div></td>
                </tr>
            </table>
            <iframe class="frameList" id="mdlsel_fl"></iframe>
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Close"/>
            </div>
        </fieldset>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var cari = {
            tb_customer: apl.func.get("cari_customer"),
            tb_offerno: apl.func.get("cari_offerno"),
            fl: apl.func.get("cari_fl"),
            load: function () {
                var custname = escape(cari.tb_customer.value);
                var offerno = escape(cari.tb_offerno.value);
                var status = '3';
                cari.fl.src = "onsite_list.aspx?custname=" + custname + "&offerno=" + offerno + "&status=" + status;

            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                onsite_id: 0,
                sales_id: 0,

                lb_offerno: apl.func.get("mdl_offerno"),
                lb_custname: apl.func.get("mdl_custname"),
                tb_custaddress:apl.func.get("mdl_custaddress"),
                lb_reqdate: apl.func.get("mdl_reqdate"),
                tb_note:apl.func.get("mdl_note"),
                tb_onsitedate: apl.createCalender("mdl_onsitedate"),
                tb_onsiteno: apl.func.get("mdl_onsiteno"),
                tb_technician: apl.func.get("mdl_technician"),
                cb_done: apl.func.get("mdl_donests"),

                val1: apl.createValidator("save", "mdl_onsitedate", function () { return apl.func.emptyValueCheck(mdl.tb_onsitedate.value); }, "Invalid input"),
                val2: apl.createValidator("save", "mdl_technician", function () { return apl.func.emptyValueCheck(mdl.tb_technician.value); }, "Invalid input"),

                init:function()
                {
                    mdl.onsite_id = 0;
                    mdl.sales_id = 0;
                    mdl.lb_offerno.innerHTML = "";
                    mdl.lb_reqdate.innerHTML = "";
                    mdl.lb_custname.innerHTML = "";
                    mdl.tb_custaddress.value = "";
                    mdl.tb_note.vlaue = "";
                    mdl.tb_onsitedate.value = "<%= strAppDate%>";
                    mdl.tb_onsiteno.value = "";
                    mdl.tb_technician.value = "";
                    mdl.cb_done.checked = false;
                },
                tambah:function()
                {
                    mdl.init();
                    mdl.showAdd("Tambah Data");
                },
                edit:function(id)
                {
                    mdl.init();
                    mdl.onsite_id = id;
                    activities.tec_onsite_data(id,
                        function (data) {
                            mdl.lb_offerno.innerHTML = data.offer_no;
                            mdl.lb_reqdate.innerHTML = data.offer_date;
                            mdl.lb_custname.innerHTML = data.customer_name;
                            mdl.tb_custaddress.value = data.customer_address + " " + data.customer_address_location;
                            mdl.tb_note.value = data.note;
                            mdl.tb_onsitedate.value = data.onsite_date;
                            mdl.tb_onsiteno.value = data.onsite_no;
                            mdl.tb_technician.value = data.technician_name;
                            mdl.showEdit("Edit Data");
                        },
                        apl.func.showError, ""
                    );
                    
                }
            },
            undefined, 
            function () {
                if(apl.func.validatorCheck("save"))
                {
                    activities.tec_onsite_edit2(mdl.onsite_id, mdl.tb_note.value, mdl.tb_onsitedate.value, mdl.tb_technician.value, mdl.cb_done.checked,
                        function () {
                            mdl.hide();
                            cari.fl_refresh();
                        },
                        apl.func.showError, ""
                    );
                }
            }, undefined,
            "frm_page", "cover_content"
        );

        var mdlsel = apl.createModal("mdlsel",
            {
                tb_offerno: apl.func.get("mdlsel_offerno"),
                tb_custname: apl.func.get("mdlsel_custname"),
                fl: apl.func.get("mdlsel_fl"),

                open:function()
                {
                    mdlsel.fl.src = "";
                    mdlsel.showEdit("Pilih Pengajuan");
                },
                select:function(id)
                {
                    mdlsel.hide();
                    mdl.edit(id);
                },
                load:function()
                {
                    var custname = escape(mdlsel.tb_custname.value);
                    var offerno = escape(mdlsel.tb_offerno.value);
                    var status = '2';
                    mdlsel.fl.src = "../marketing/onsiteaju_list.aspx?displayadd=1&edit=select&custname=" + custname + "&offerno=" + offerno + "&status=" + status;
                }
            },
            undefined, undefined, undefined, "frm_page", "cover_content"
        );

        window.addEventListener("load", function () {
            cari.load();
            document.list_edit = mdl.edit;
            document.list_add = mdlsel.open;
            document.select = mdlsel.select;
        });
    </script>
</asp:Content>

