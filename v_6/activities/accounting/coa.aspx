<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page" %>

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
            <th>Kode COA</th>
            <td><input type="text" id="cari_kode"/></td>
        </tr>
        <tr>
            <th>COA</th>
            <td><input type="text" id="cari_coa" value="%"/></td>
        </tr>
        <tr>
            <th>Root Sts</th>
            <td><input type="checkbox" id="cari_root" checked="checked"/></td>
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
                    <th>Kode COA</th>
                    <td><input type="text" id="mdl_code" size="10" maxlength="10"/></td>
                </tr>                
                <tr>
                    <th>COA</th>
                    <td><input type="text" id="mdl_coa" size="100" maxlength="100"/></td>
                </tr>
                <tr>
                    <th>Tipe</th>
                    <td><select id="mdl_type"></select></td>
                </tr>
                <tr>
                    <th>Parent</th>
                    <td><a id="mdl_parent" onclick="mdl.back();" style="font-weight:bold;text-decoration:underline;cursor:pointer;"></a></td>
                </tr>                
                <tr id="mdl_tr">
                    <th>Child Detail</th>
                    <td>
                        <table id="mdl_tbl" class="gridView">
                            <tr>
                                <th style="width:25px"><div class="tambah" onclick="mdl.tambah(mdl.coa_id);"></div></th>
                                <th>Code</th>
                                <th>Coa Name</th>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Add"/>
                <input type="button" value="Save"/>                
                <input type="button" value="Close"/>                
            </div>
        </fieldset>
    </div>    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var cari = {
            tb_kode: apl.func.get("cari_kode"),
            tb_coa: apl.func.get("cari_coa"),
            fl: apl.func.get("cari_fr"),
            cb_root:apl.func.get("cari_root"),
            load: function () {
                var kode = escape(cari.tb_kode.value);
                var coa = escape(cari.tb_coa.value);
                var root = escape((cari.cb_root.checked) ? "0" : "%");
                cari.fl.src = "coa_list.aspx?kode=" + kode + "&coa=" + coa+"&root="+root;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                coa_id: 0,
                parent_coa_id: 0,
                tb_code: apl.func.get("mdl_code"),
                tb_coa: apl.func.get("mdl_coa"),
                ddl_type: apl.createDropdownWS("mdl_type", activities.dl_acc_coa_type_list),
                lb_parent: apl.func.get("mdl_parent"),
                tbl: apl.createTableWS.init("mdl_tbl",
                    [
                        apl.createTableWS.column("", "", [apl.func.createAttribute("class", "edit")], function (data) {
                            mdl.edit(data.coa_id);
                        }, false),
                        apl.createTableWS.column("coa_code"),
                        apl.createTableWS.column("coa_name"),
                    ]
                ),
                tr:apl.func.get("mdl_tr"),

                val_01: apl.createValidator("save", "mdl_code", function () { return apl.func.emptyValueCheck(mdl.tb_code.value); }, "Salah input"),
                val_02: apl.createValidator("save", "mdl_coa", function () { return apl.func.emptyValueCheck(mdl.tb_coa.value); }, "Salah input"),
                val_03: apl.createValidator("save", "mdl_type", function () { return apl.func.emptyValueCheck(mdl.ddl_type.value); }, "Salah input"),

                tbl_load:function(id)
                {
                    activities.acc_coa_child_list(id,
                        function (arrdata) { mdl.tbl.load(arrdata);}, apl.func.showError, "");
                },

                kosongkan: function () {
                    mdl.coa_id = 0;
                    mdl.tb_coa.value = "";
                    mdl.tb_code.value = "";
                    mdl.ddl_type.value = "";
                    mdl.ddl_type.disabled = false;
                    mdl.lb_parent.innerHTML = "";
                    mdl.tbl.clearAllRow();
                    mdl.tr.Show();
                    apl.func.validatorClear("save");
                    apl.func.hideSinkMessage();
                },
                tambah: function (parent_coa_id) {
                    mdl.kosongkan();                    
                    mdl.tr.Hide();
                    if (parent_coa_id > 0) {
                        activities.acc_coa_data(parent_coa_id,
                            function (data) {
                                mdl.ddl_type.value = data.coa_type_id;
                                mdl.parent_coa_id = parent_coa_id;                                
                                mdl.lb_parent.innerHTML = data.coa_name;
                                mdl.ddl_type.disabled = true;

                                mdl.showAdd("COA - Tambah");
                            }, apl.func.showError, ""
                        );
                    } else {
                        mdl.showAdd("COA- Tambah");
                        mdl.parent_coa_id = 0;//root
                    }
                },
                edit: function (id) {
                    apl.func.showSinkMessage("Memuat Data");
                    mdl.kosongkan();
                    mdl.coa_id = id;
                    mdl.tbl_load(id);

                    activities.acc_coa_data(id,
                        function (data) {
                            mdl.tb_code.value = data.coa_code;
                            mdl.tb_coa.value = data.coa_name;
                            mdl.ddl_type.value = data.coa_type_id;
                            mdl.ddl_type.disabled = true;
                            mdl.parent_coa_id = data.parent_coa_id;
                            mdl.lb_parent.innerHTML = data.parent_coa_name;                            

                            mdl.showEdit("COA - Edit");                            
                        }, apl.func.showError, ""
                    );
                },
                refresh: function () {
                    cari.fl_refresh();
                    apl.func.hideSinkMessage();
                },
                back:function()
                {
                    mdl.edit(mdl.parent_coa_id);
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menambah Data");
                    activities.acc_coa_add(mdl.tb_code.value, mdl.tb_coa.value, mdl.ddl_type.value, mdl.parent_coa_id,
                        function (id)
                        {
                            mdl.refresh();
                            if (mdl.parent_coa_id == 0) mdl.edit(id);else mdl.edit(mdl.parent_coa_id);
                        }, apl.func.showError, ""
                    );
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menyimpan Data");
                    activities.acc_coa_edit(mdl.coa_id,mdl.tb_code.value, mdl.tb_coa.value, mdl.ddl_type.value, mdl.parent_coa_id, mdl.refresh, apl.func.showError, "");
                }
            },
            undefined, "frm_page", "cover_content"
        );

        window.addEventListener("load", function () {
            cari.load();
            document.list_add = mdl.tambah;
            document.list_edit = mdl.edit;
        });
    </script>
</asp:Content>

