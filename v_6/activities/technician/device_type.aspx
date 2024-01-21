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
            <th>Type</th>
            <td><input type="text" id="cari_type"/></td>
        </tr>
        <tr>
            <th>Part sts</th>
            <td><input type="checkbox" id="cari_part_status"/></td>
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
                    <th>Type</th>
                    <td><input type="text" id="mdl_type" maxlength="35" size="35"/></td>
                </tr>
                <tr>
                    <th>Part Sts</th>
                    <td><input type="checkbox" id="mdl_sts"/></td>
                </tr>
                <tr>
                    <th>Kelengkapan</th>
                    <td>
                        <table class="gridView" id="mdl_tbl">
                            <tr>
                                <th style="width:25px;"><div class="tambah" title="Tambah data kelengkapan" onclick="mdl_trimming.tambah();"></div></th>
                                <th>Kelengkapan</th>
                            </tr>
                        </table>
                    </td>
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

    <div id="mdl_trimming">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Kelengkapan</th>
                    <td><div id="mdl_trimming_name"></div></td>
                </tr>
            </table>
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Add"/>
                <input type="button" value="Cancel"/>
            </div>
        </fieldset>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var cari = {
            tb_type: apl.func.get("cari_type"),
            cb_part_sts: apl.func.get("cari_part_status"),
            fl: apl.func.get("cari_fr"),            
            load: function () {
                var type = escape(cari.tb_type.value);
                var ps = cari.cb_part_sts.checked;
                cari.fl.src = "device_type_list.aspx?type=" + type + "&ps=" + ps;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                device_type_id: 0,
                tb_type: apl.func.get("mdl_type"),
                cb_sts: apl.func.get("mdl_sts"),
                val_type: apl.createValidator("save", "mdl_type", function () { return apl.func.emptyValueCheck(mdl.tb_type.value); }, "Salah input"),
                tbl: apl.createTableWS.init("mdl_tbl",
                    [
                        apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "hapus")], function (data) { mdl_trimming.hapus(data.device_type_trimming_id); }, undefined, undefined),
                        apl.createTableWS.column("trimming_name")
                    ]
                ),
                tbl_load:function()
                {
                    activities.tec_device_type_trimming_list(mdl.device_type_id,
                        function (arrData) {
                            mdl.tbl.load(arrData);
                        }, apl.func.showError, ""
                    );
                },
                kosongkan:function()
                {
                    mdl.device_type_id = 0;
                    mdl.tb_type.value = "";
                    mdl.cb_sts.checked = false;
                    mdl.tbl.Hide();
                    apl.func.validatorClear("save");
                },
                tambah:function()
                {
                    mdl.kosongkan();
                    mdl.showAdd("Type - Tambah");
                },
                edit:function(id)
                {
                    apl.func.showSinkMessage("Memuat data");
                    mdl.kosongkan();
                    mdl.device_type_id = id;
                    mdl.tbl.Show();
                    mdl.tbl_load();
                    activities.tec_device_type_data(id,
                        function (data)
                        {
                            mdl.tb_type.value=data.device_type;
                            mdl.cb_sts.checked = data.part_sts;
                            mdl.showEdit("Type - Edit");
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                },
                refresh:function()
                {
                    cari.fl_refresh();
                    mdl.hide();
                    apl.func.hideSinkMessage();
                }
            },
            function ()
            {
                if(apl.func.validatorCheck("save"))
                {
                    apl.func.showSinkMessage("Menyimpan");
                    activities.tec_device_type_add(mdl.tb_type.value, mdl.cb_sts.checked, 
                        function (id)
                        {
                            mdl.edit(id);
                        }, apl.func.showError, ""
                    );
                }
            },
            function () {
                if (apl.func.validatorCheck("Menyimpan")) {
                    apl.func.showSinkMessage("Save");
                    activities.tec_device_type_edit(mdl.device_type_id, mdl.tb_type.value, mdl.cb_sts.checked, mdl.refresh, apl.func.showError, "");
                }
            },
            function ()
            {
                if(confirm("Yakin akan dihapus?"))
                {
                    apl.func.showSinkMessage("Menghapus");
                    activities.tec_device_type_delete(mdl.device_type_id, mdl.refresh, apl.func.showError, "");
                }
            }, "frm_page", "cover_content"
        );
        
        var mdl_trimming = apl.createModal("mdl_trimming",
            {
                device_type_trimming_id: 0,
                device_type_id: 0,
                trimming_id: 0,
                ac_trimming: apl.createAutoComplete("mdl_trimming_name", activities.ac_trimming, 400),
                val_device: apl.createValidator("trimming_save", "mdl_trimming_name", function () { return apl.func.emptyValueCheck(mdl_trimming.ac_trimming.getValue()); }, "Salah input"),
                kosongkan:function()
                {
                    mdl_trimming.device_type_trimming_id = 0;
                    mdl_trimming.device_type_id = 0;
                    mdl_trimming.trimming_id = 0;
                    mdl_trimming.ac_trimming.setValue("", "");
                    apl.func.validatorClear("trimming_save");
                },
                tambah:function()
                {
                    mdl_trimming.kosongkan();
                    mdl_trimming.showAdd("Kelengkapan - Tambah");
                },
                hapus:function(id)
                {
                    if (confirm("Yakin akan dihapus?")) {
                        activities.tec_device_type_trimming_delete(id, mdl_trimming.refresh, apl.func.showError, "");
                    }
                },
                refresh:function()
                {
                    mdl_trimming.hide();
                    mdl.tbl_load();
                }
            },
            function ()
            {
                if (apl.func.validatorCheck("trimming_save"))
                {
                    activities.tec_device_type_trimming_add(mdl.device_type_id, mdl_trimming.ac_trimming.getValue(), mdl_trimming.refresh, apl.func.showError, "");
                }
            },
            undefined,
            undefined, "frm_page", "mdl"
        );

        window.addEventListener("load", function () {
            cari.load();
            document.list_add = mdl.tambah;
            document.list_edit = mdl.edit;
        });
    </script>
</asp:Content>

