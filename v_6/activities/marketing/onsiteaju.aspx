<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page"%>

<script runat="server">
    public string strAppDate, strUserID;
    
    void Page_Load()
    {
        _test.App a = new _test.App(Request, Response);

        strAppDate =  a.ApplicationDate;
        strUserID = a.cookieUserIDValue;
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
                    <th>Tanggal</th>
                    <td><label id="mdl_reqdate"></label></td>
                </tr>
                <tr>
                    <th style="width:200px">No.Penawaran</th>
                    <td><input type="text" id="mdl_offerno"/></td>
                </tr>
                <tr>
                    <th>Note</th>
                    <td><textarea id="mdl_note"></textarea></td>
                </tr>
                <tr>
                    <th>Status</th>
                    <td><select id="mdl_status"></select></td>
                </tr>
            </table>
            
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Add"/>
                <input type="button" value="Save"/>
                <input type="button" value="Delete"/>
                <input type="button" value="Cancel"/>
            </div>
        </fieldset>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var user_id = "<%= strUserID %>";
        var cari = {
            tb_customer: apl.func.get("cari_customer"),
            tb_offerno: apl.func.get("cari_offerno"),
            fl: apl.func.get("cari_fl"),
            load: function () {
                var custname = escape(cari.tb_customer.value);
                var offerno = escape(cari.tb_offerno.value);
                var status = '1';
                cari.fl.src = "onsiteaju_list.aspx?custname=" + custname + "&offerno=" + offerno + "&status=" + status;

            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                onsite_id: 0,
                sales_id: 0,

                lb_reqdate:apl.func.get("mdl_reqdate"),
                tb_offerno: apl.create_auto_complete_text("mdl_offerno", activities.ac_sales_offerno_list, undefined, undefined, function (data) { mdl.sales_id = data.value; }, function () { return "<%= strUserID %>";}),
                tb_note: apl.func.get("mdl_note"),
                dl_status: apl.createDropdownWS("mdl_status", activities.dl_onsitests, undefined, undefined, undefined, function () { return " type='onsitests' and code in ('1','2')"; }),

                val1: apl.createValidator("onsiteadd", "mdl_offerno", function () { return apl.func.emptyValueCheck(mdl.tb_offerno.input.value); }, "Invalid input"),
                val2: apl.createValidator("onsiteadd", "mdl_note", function () { return apl.func.emptyValueCheck(mdl.tb_note.value); }, "Invalid input"),
                val3: apl.createValidator("onsiteadd", "mdl_status", function () { return apl.func.emptyValueCheck(mdl.dl_status.value); }, "Invalid input"),



                init:function()
                {
                    mdl.onsite_id = 0;
                    mdl.sales_id = 0;
                    mdl.lb_reqdate.innerHTML = "<%= strAppDate %>";
                    mdl.tb_offerno.set_value("", "");
                    mdl.tb_note.value = "";
                    mdl.dl_status.value = "";

                    apl.func.validatorClear("onsiteadd");
                    apl.func.validatorClear("onsitesave");

                },
                tambah:function()
                {
                    mdl.init();
                    
                    mdl.showAdd("Tambah Data");
                },
                edit:function(id)
                {
                    mdl.init();
                    activities.tec_onsite_data(id,
                        function (data) {
                            mdl.onsite_id = id;
                            mdl.lb_reqdate.innerHTML = data.request_date;
                            mdl.sales_id = data.sales_id;
                            mdl.tb_offerno.set_value(data.sales_id, data.offer_no);
                            mdl.tb_note.value = data.note;
                            mdl.dl_status.value = data.onsitests_id;

                            mdl.showEdit("Edit Data");
                        },
                        apl.func.showError, ""
                    );
                    
                }
            },
            function () {
                if(apl.func.validatorCheck("onsiteadd"))
                {
                    activities.tec_onsite_add(mdl.tb_offerno.id, mdl.tb_note.value, user_id,
                        function (id) {
                            cari.fl_refresh();
                            mdl.edit(id);
                        },
                        apl.func.showError, ""
                    );
                }
            }, 
            function () {
                if (apl.func.validatorCheck("onsitesave")) {
                    activities.tec_onsite_edit1(mdl.onsite_id, mdl.tb_note.value, mdl.dl_status.value,
                        function () {
                            cari.fl_refresh();
                            mdl.hide();
                        },
                        apl.func.showError, ""
                    );
                }
            }, 
            function()
            {
                if(confirm("Yakin akan dihapus?"))
                {
                    activities.tec_onsite_delete(mdl.onsite_id,
                        function () {
                            cari.fl_refresh();
                            mdl.hide();
                        },
                        apl.func.showError, ""
                    );
                }
            },
            "frm_page", "cover_content"
        );

        window.addEventListener("load", function () {
            cari.load();
            document.list_edit = mdl.edit;
            document.list_add = mdl.tambah;
        });
    </script>
</asp:Content>

