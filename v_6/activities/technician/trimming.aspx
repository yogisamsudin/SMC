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
            <th>Kelengkapan</th>
            <td><input type="text" id="cari_device"/></td>
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
                    <th>Kelengkapan</th>
                    <td><input type="text" id="mdl_device" size="50" maxlength="50"/></td>
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
        var cari = {
            tb_type: apl.func.get("cari_device"),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var name = escape(cari.tb_type.value);
                cari.fl.src = "trimming_list.aspx?name=" + name;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                trimming_id: 0,
                tb_device: apl.func.get("mdl_device"),
                val_device: apl.createValidator("save", "mdl_device", function () { return apl.func.emptyValueCheck(mdl.tb_device.value); }, "Salah input"),                
                kosongkan:function()
                {
                    mdl.device_type_trimming_id = 0;
                    mdl.tb_device.value = "";
                    apl.func.validatorClear("save");
                    apl.func.hideSinkMessage();
                },
                tambah:function()
                {
                    mdl.kosongkan();
                    mdl.showAdd("Kelengkapan- Tambah");
                },
                edit:function(id)
                {
                    apl.func.showSinkMessage("Memuat Data");
                    mdl.kosongkan();
                    activities.tec_trimming_data(id,
                        function (data)
                        {
                            mdl.trimming_id = id;
                            mdl.tb_device.value = data.trimming_name;
                            mdl.showEdit("Kelengkapan- Edit");
                            apl.func.hideSinkMessage();
                        },
                        apl.func.showError, ""
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
                if (apl.func.validatorCheck("save"))
                {
                    apl.func.showSinkMessage("Menambah data");
                    activities.tec_trimming_add(mdl.tb_device.value, mdl.refresh, apl.func.showError, "");
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    activities.tec_trimming_edit(mdl.trimming_id, mdl.tb_device.value, mdl.refresh, apl.func.showError, "");
                }
            },
            function ()
            {
                if(confirm("Yakin akan dihapus?"))
                {
                    activities.tec_trimming_delete(mdl.trimming_id, mdl.refresh, apl.func.showError, "");
                }
            }, "frm_page", "cover_content"
        );

        window.addEventListener("load", function () {
            cari.load();
            document.list_add = mdl.tambah;
            document.list_edit = mdl.edit;
        });
    </script>
</asp:Content>

