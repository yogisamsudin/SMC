<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" src="../../js/Komponen.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <asp:ScriptManager runat="server" ID="sm">
        <Services>
            <asp:ServiceReference Path="http://olserver/test/activities/activities.asmx" />
        </Services>
    </asp:ScriptManager>  

    <table class="formview">
        <tr>
            <th>Location</th>
            <td><input type="text" id="cari_location" size="100"/></td>            
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.load();">Cari</div></td>
        </tr>
    </table>
    
    <iframe class="frameList" id="fr_list"></iframe> 

    <div id="mdl" class="modal">
        <fieldset>
            <legend></legend>
            
            <table class="formview">
                <tr>
                    <th>Alamat</th>
                    <td><textarea id="mdl_address"></textarea></td>
                </tr>    
                <tr>
                    <th>Jarak</th>
                    <td><input type="text" id="mdl_distance" size="3" style="text-align:right;"/></td>
                </tr>            
            </table>                    

            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Add" />
                <input type="button" value="Save"/>
                <input type="button" value="Delete" />
                <input type="button" value="Cancel"/>
            </div>
        </fieldset>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var cari = {
            tb_location: apl.func.get("cari_location"),
            fl: apl.func.get("fr_list"),            
            load: function () {
                var address = cari.tb_location.value;
                cari.fl.src = "location_list.aspx?address=" + escape(address);
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }
        
        var mdl = apl.createModal("mdl",
            {
                location_id: 0,
                tb_address: apl.func.get("mdl_address"),
                tb_distance: apl.createNumeric("mdl_distance"),
                val_address: apl.createValidator("save", "mdl_address", function () { return apl.func.emptyValueCheck(mdl.tb_address.value); }, "Salah input"),
                val_distance: apl.createValidator("save", "mdl_distance", function () { return apl.func.emptyValueCheck(mdl.tb_distance.value); }, "Salah input"),
                kosongkan: function () {
                    mdl.location_id = 0;
                    mdl.tb_address.value = "";
                    apl.func.validatorClear("save");
                },
                tambah: function () {
                    mdl.kosongkan();
                    mdl.showAdd("Location - Tambah");
                },
                edit: function (id) {
                    mdl.kosongkan();
                    apl.func.showSinkMessage("Memuat Data");
                    activities.act_location_data(id,
                        function (data)
                        {
                            mdl.location_id = id;
                            mdl.tb_address.value = data.location_address;
                            mdl.tb_distance.setValue(data.distance);
                            apl.func.hideSinkMessage();
                            mdl.showEdit("Location - Edit");
                        }, apl.func.showError, ""
                    );
                    
                },
                refresh_modal: function ()
                {
                    mdl.hide();
                    cari.fl_refresh();
                    apl.func.hideSinkMessage();
                }
                
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Simpan");
                    activities.exp_location_add(mdl.tb_address.value, mdl.tb_distance.getIntValue(), mdl.refresh_modal, apl.func.showError, "");
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Simpan");
                    activities.exp_location_edit(mdl.location_id,mdl.tb_address.value, mdl.tb_distance.getIntValue(), mdl.refresh_modal, apl.func.showError, "");                    
                }
            },
            function () {
                if (confirm("Yakin akan dihapus?")) {
                    apl.func.showSinkMessage("Hapus");
                    activities.exp_location_delete(mdl.location_id, mdl.refresh_modal, apl.func.showError, "");
                }
            }, "frm_page", "cover_content", ""
        );

        window.addEventListener("load", function () {
            document.list_edit = mdl.edit;
            document.list_add = mdl.tambah;
            cari.load();
        });
        
    </script>
</asp:Content>

