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
            <th>Cabang</th>
            <td><input type="text" id="cari_branch"/></td>
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.load();">Cari</div></td>
        </tr>                
    </table>

    <iframe class="frameList" id="cari_list"></iframe>

    <div class="modal" id="mdl">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Nama Cabang</th>
                    <td><input type="text" id="mdl_branch" autocomplete="off" size="50" /></td>
                </tr>
                <tr>
                    <th>Aktif</th>
                    <td><input type="checkbox" id="mdl_active"/></td>
                </tr>
                <tr>
                    <th>Alamat #1 <span id="test"></span></th>
                    <td><input type="text" id="mdl_location" size="100"/></td>
                </tr>
                <tr>
                    <th>Alamat #2</th>
                    <td><textarea id="mdl_address"></textarea></td>
                </tr>
                <tr>
                    <th>Telepon</th>
                    <td><input type="text" id="mdl_phone"/></td>
                </tr>
                <tr>
                    <th>Fax</th>
                    <td><input type="text" id="mdl_fax"/></td>
                </tr>
            </table>
            <div class="button_panel">
                <input type="button" value="Add" />
                <input type="button" value="Save" />
                <input type="button" value="Delete" />
                <input type="button" value="Cancel" />
            </div>
        </fieldset>
    </div>

    <div class="modal" id="mdl_addlocation">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Lokasi</th>
                    <td><input type="text" id="mdl_addlocation_location" autocomplete="off" size="50"/></td>
                </tr>                
            </table>
            <div class="button_panel">
                <input type="button" value="Add" />                
                <input type="button" value="Cancel" />
            </div>
        </fieldset>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <style>
        
    </style>
    <script type="text/javascript">
        

        var cari = {
            tb_branch: apl.func.get("cari_branch"),
            fl_list: apl.func.get("cari_list"),
            load: function ()
            {
                var branch = window.escape(cari.tb_branch.value);

                cari.fl_list.src = "branch_list.aspx?name=" + branch;
            },
            refresh:function()
            {
                cari.fl_list.contentWindow.document.refresh();
            }
        }
        
        var mdl = apl.createModal("mdl",
            {
                branch_id: 0,
                tb_branch: apl.func.get("mdl_branch"),
                cb_active: apl.func.get("mdl_active"),
                tb_address: apl.func.get("mdl_address"),
                tb_phone: apl.func.get("mdl_phone"),
                tb_fax: apl.func.get("mdl_fax"),
                ac_location: apl.create_auto_complete_text("mdl_location", activities.ac_location_list, function () { mdl_addlocation.tambah(); }),
                val_branch: apl.createValidator("save", "mdl_branch", function () { return apl.func.emptyValueCheck(mdl.tb_branch.value); }, "Invalid input"),
                val_location: apl.createValidator("save", "mdl_location", function () { return apl.func.emptyValueCheck(mdl.ac_location.id); }, "Invalid input"),                    
                
                kosongkan:function()
                {
                    mdl.tb_branch.value = "";
                    mdl.ac_location.set_value("", "");                    
                    mdl.tb_address.value = "";
                    mdl.tb_phone.value = "";
                    mdl.tb_fax.value = "";
                    apl.func.validatorClear("save");
                },
                tambah:function()
                {
                    mdl.kosongkan();                    
                    mdl.showAdd("Cabang - Tambah");
                    
                },
                edit: function (branch_id)
                {
                    mdl.kosongkan();
                    apl.func.showSinkMessage("Memuat...")
                    activities.par_branch_data(branch_id,
                        function (data)
                        {
                            mdl.branch_id = data.branch_id;
                            mdl.tb_branch.value = data.branch_name;
                            mdl.cb_active.checked = data.active_sts;
                            mdl.ac_location.set_value(data.location_id, data.location_address);
                            mdl.tb_address.value = data.address;
                            mdl.tb_phone.value = data.phone;
                            mdl.tb_fax.value = data.fax;
                            mdl.showEdit("Cabang - Edit");
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );                    
                }
            },
            function ()
            {
                if(apl.func.validatorCheck("save"))
                {
                    apl.func.showSinkMessage("Menyimpan...");
                    activities.par_branch_add(mdl.tb_branch.value, mdl.cb_active.checked, mdl.ac_location.id, mdl.tb_address.value,mdl.tb_phone.value, mdl.tb_fax.value, function () { mdl.hide(); apl.func.hideSinkMessage(); }, apl.func.showError, "");
                }
            }, 
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menyimpan...");
                    activities.par_branch_edit(mdl.branch_id, mdl.tb_branch.value, mdl.cb_active.checked, mdl.ac_location.id, mdl.tb_address.value, mdl.tb_phone.value, mdl.tb_fax.value, function () { mdl.hide(); apl.func.hideSinkMessage(); }, apl.func.showError, "");
                }
            },
            function ()
            {
                if(confirm("Yakin akan dihapus?"))
                {
                    apl.func.showSinkMessage("Menghapus...");
                    activities.par_branch_delete(mdl.branch_id, function () { mdl.hide(); apl.func.hideSinkMessage(); }, apl.func.showError, "");
                }
            }, "frm_page", "cover_content"
        );

        var mdl_addlocation = apl.createModal("mdl_addlocation",
            {
                tb_location: apl.func.get("mdl_addlocation_location"),
                val_location: apl.createValidator("save_location", "mdl_addlocation_location", function () { return apl.func.emptyValueCheck(mdl_addlocation.tb_location.value); }, "Invalid input"),
                tambah: function ()
                {
                    apl.func.validatorClear("save_location");
                    mdl_addlocation.tb_location.value = "";
                    mdl_addlocation.showAdd("Lokasi - Tambah");
                }
            },
            function ()
            {
                if (apl.func.validatorCheck("save_location")) {
                    apl.func.showSinkMessage("Menyimpan...");
                    activities.exp_location_add(mdl_addlocation.tb_location.value, 0, function () { mdl_addlocation.hide(); apl.func.hideSinkMessage(); }, apl.func.showError, "");
                }
            },
            undefined, undefined, "frm_page", "mdl"
        );
        
        document.list_add = mdl.tambah;
        document.list_edit = mdl.edit;
        //<div class="tambah" title="Tambah data lokasi" style="float:right;" onclick="mdl_addlocation.tambah();"></div>

        
    </script>
</asp:Content>

