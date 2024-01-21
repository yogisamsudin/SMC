<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" theme="Page"%>

<script runat="server">

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
            <th>Kode</th>
            <td><input type="text" id="cari_kode"/></td>
        </tr>
        <tr>
            <th>Nama</th>
            <td><input type="text" id="cari_name" value="%"/></td>
        </tr>        
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.load();">Cari</div></td>
        </tr>
    </table>
    
    <iframe class="frameList" id="cari_fr"></iframe>

    <div id="mdl" class="modal"> 
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Kode</th>
                    <td><input type="text" id="mdl_code" size="3" maxlength="3"/></td>
                </tr>                
                <tr>
                    <th>Nama Fungsi</th>
                    <td><input type="text" id="mdl_name" size="50" maxlength="50"/></td>
                </tr>
                <tr id="mdl_tr">
                    <th>Detail</th>
                    <td>
                        <table class="gridView" id="mdl_tbl">
                            <tr>
                                <th style="width:25px;"><div class="tambah" onclick="mdl_dtl.tambah();"></div></th>
                                <th>Kode</th>
                                <th>Nama</th>
                                <th>COA</th>
                                <th>DB/CR</th>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Add"/>
                <input type="button" value="Save"/>                
                <input type="button" value="Cancel"/>                
            </div>
        </fieldset>
    </div>  

    <div class="modal" id="mdl_dtl">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Kode</th>
                    <td><input type="text" id="mdl_dtl_code" maxlength="3" size="3"/></td>
                </tr>
                <tr>
                    <th>Nama</th>
                    <td><input type="text" id="mdl_dtl_name" maxlength="50" size="50"/></td>
                </tr>                
                <tr>
                    <th>COA</th>
                    <td><input type="text" id="mdl_dtl_coa" /></td>
                </tr>
                <tr>
                    <th>Debet/Credit</th>
                    <td><select id="mdl_dtl_dbcr"></select></td>
                </tr>
            </table>
            <div class="button_panel">
                <input type="button" value="Add" />
                <input type="button" value="Save" />                
                <input type="button" value="Cancel" />
            </div>
        </fieldset>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var cari = {
            tb_kode: apl.func.get("cari_kode"),
            tb_name: apl.func.get("cari_name"),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var kode = escape(cari.tb_kode.value);
                var name = escape(cari.tb_name.value);                
                cari.fl.src = "journal_function_list.aspx?kode=" + kode + "&name=" + name;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                tb_code: apl.func.get("mdl_code"),
                tb_name: apl.func.get("mdl_name"),
                tr: apl.func.get("mdl_tr"),
                tbl: apl.createTableWS.init("mdl_tbl",
                    [
                         apl.createTableWS.column("", "", [apl.func.createAttribute("class", "edit")], function (data) {
                             //alert(data.journal_function_detail_code);
                             mdl_dtl.edit(data.journal_function_detail_code);
                         }, false),
                        apl.createTableWS.column("journal_function_detail_code"),
                        apl.createTableWS.column("journal_function_detail_name"),
                        apl.createTableWS.column("coa_name"),
                        apl.createTableWS.column("dbcr_name"),
                    ]
                ),
                
                val_01: apl.createValidator("save", "mdl_code", function () { return apl.func.emptyValueCheck(mdl.tb_code.value); }, "Salah input"),
                val_02: apl.createValidator("save", "mdl_name", function () { return apl.func.emptyValueCheck(mdl.tb_name.value); }, "Salah input"),

                tbl_load: function (id) {
                    activities.acc_journal_function_detail_list(id,function (arrdata) { mdl.tbl.load(arrdata); }, apl.func.showError, "");
                },

                kosongkan: function () {
                    mdl.tb_code.value = "";
                    mdl.tb_name.value = "";
                    mdl.tr.Hide();

                    apl.func.validatorClear("save");
                    apl.func.hideSinkMessage();
                },
                tambah: function () {
                    mdl.kosongkan();
                    mdl.showAdd("Fungsi-function Jurnal - Tambah");
                },
                edit: function (id) {
                    apl.func.showSinkMessage("Memuat Data");
                    mdl.kosongkan();
                    mdl.tr.Show();
                    mdl.tbl_load(id);
                    activities.acc_journal_function_data(id,
                        function (data)
                        {
                            mdl.tb_code.value = data.journal_function_code;
                            mdl.tb_name.value = data.journal_function_name;
                            mdl.showEdit("Fungsi-function Jurnal - Edit");
                        }, apl.func.showError, ""
                    );
                },
                refresh: function () {
                    cari.fl_refresh();
                    apl.func.hideSinkMessage();
                    mdl.hide();
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menambah Data");
                    activities.acc_journal_function_add(mdl.tb_code.value, mdl.tb_name.value, mdl.refresh, apl.func.showError, "");
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menyimpan Data");
                    activities.acc_journal_function_edit(mdl.tb_code.value, mdl.tb_name.value, mdl.refresh, apl.func.showError, "");
                }
            },
            undefined, "frm_page", "cover_content"
        );

        var mdl_dtl = apl.createModal("mdl_dtl",
            {
                cr_coa_id: 0,
                db_coa_id: 0,
                tb_code: apl.func.get("mdl_dtl_code"),
                tb_name: apl.func.get("mdl_dtl_name"),                
                ac_coa: apl.create_auto_complete_text("mdl_dtl_coa", activities.ac_acc_coa_list),
                dl_dbcr: apl.createDropdownWS("mdl_dtl_dbcr", activities.dl_dbcr_list),

                val1: apl.createValidator("savedtl", "mdl_dtl_code", function () { return apl.func.emptyValueCheck(mdl_dtl.tb_code.value); }, "Invalid input"),
                val2: apl.createValidator("savedtl", "mdl_dtl_name", function () { return apl.func.emptyValueCheck(mdl_dtl.tb_name.value); }, "Invalid input"),
                val3: apl.createValidator("savedtl", "mdl_dtl_coa", function () { return apl.func.emptyValueCheck(mdl_dtl.ac_coa.text); }, "Invalid input"),
                val4: apl.createValidator("savedtl", "mdl_dtl_dbcr", function () { return apl.func.emptyValueCheck(mdl_dtl.dl_dbcr.value); }, "Invalid input"),

                kosong:function()
                {
                    apl.func.validatorClear("savedtl");
                    apl.func.hideSinkMessage();
                    mdl_dtl.tb_code.value = "";
                    mdl_dtl.tb_name.value = "";                    
                    mdl_dtl.ac_coa.set_value('', '');                    
                },
                tambah:function()
                {
                    mdl_dtl.kosong();
                    mdl_dtl.showAdd("Fungsi Detail - Tambah");
                },
                edit:function(code)
                {
                    mdl_dtl.kosong();
                    activities.acc_journal_function_detail_data(code,
                        function (data) {
                            mdl_dtl.tb_code.value = data.journal_function_detail_code;
                            mdl_dtl.tb_name.value = data.journal_function_detail_name;
                            mdl_dtl.ac_coa.set_value(data.coa_id, data.coa_name);
                            mdl_dtl.dl_dbcr.value = data.dbcr_id;
                            mdl_dtl.showEdit("Fungsi Detail - Edit");
                        }, apl.func.showError, ""
                    );
                    
                },
                refresh:function()
                {
                    apl.func.hideSinkMessage();
                    mdl.tbl_load(mdl.tb_code.value);
                    mdl_dtl.hide();
                }
            }, function ()
            {
                if (apl.func.validatorCheck("savedtl")) {
                    apl.func.showSinkMessage("Menyimpan data");
                    activities.acc_journal_function_detail_save(mdl.tb_code.value, mdl_dtl.tb_code.value, mdl_dtl.tb_name.value, mdl_dtl.ac_coa.id, mdl_dtl.dl_dbcr.value, mdl_dtl.refresh, apl.func.showError, "");
                }
            }, function () {
                if (apl.func.validatorCheck("savedtl")) {
                    apl.func.showSinkMessage("Menyimpan data");
                    activities.acc_journal_function_detail_save(mdl.tb_code.value, mdl_dtl.tb_code.value, mdl_dtl.tb_name.value, mdl_dtl.ac_coa.id, mdl_dtl.dl_dbcr.value, mdl_dtl.refresh, apl.func.showError, "");
                }
            }, undefined, "frm_page", "mdl"
        );

        

        window.addEventListener("load", function () {
            cari.load();
            document.list_add = mdl.tambah;
            document.list_edit = mdl.edit;
        });
    </script>
</asp:Content>

