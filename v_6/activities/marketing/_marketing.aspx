<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" theme="Page" %>

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
    <label for="f_ttd">
        <img id="i_ttd" src="" style="border:solid black thin; width:200px;height:90px;cursor:pointer;" />
    </label>
    <input type="file" id="f_ttd" style="display:none;"/>
    <label onclick="simpan_data_image()" style="cursor:pointer;">Save</label>
    
    

    <iframe class="frameList" id="fr_list"></iframe>  
    <p><label style="cursor:pointer;font-weight:bold;" onclick="refresh_dashboard();">Refresh dashboard</label></p>

    <div id="mdl" class="modal">
        <fieldset>
            <legend>Marketing</legend>
            <table class="formview">
                <tr>
                    <th>Tim</th>
                    <td><select id="mdl_group"></select></td>
                </tr>
                <tr>
                    <th style="width:200px;">ID</th>
                    <td><input type="text" id="mdl_id" size="15" maxlength="15"/></td>
                </tr>
                <tr>
                    <th>Name</th>
                    <td><input type="text" id="mdl_name"/></td>
                </tr>
                <tr>
                    <th>Telepon</th>
                    <td><input type="text" id="mdl_phone" size="15" maxlength="15"/></td>
                </tr>                
                <tr>
                    <th>User</th>
                    <td><select id="mdl_user"></select></td>
                </tr>                
                <tr>
                    <th>Akses Semua Data</th>
                    <td><input type="checkbox" id="mdl_access"/></td>
                </tr>
                <tr>
                    <th>Status Dashboard</th>
                    <td><input type="checkbox" id="mdl_dashboard_sts"/></td>
                </tr>
                <tr>
                    <th>Nilai Target</th>
                    <td><input type="text" id="mdl_target" style="text-align:right" size="20"/></td>
                </tr>
                <tr>
                    <th>Tandatangan</th>
                    <td><iframe id="mdl_ifttd" style="width:500px;height:25px;border:thin solid #CCCCCC;"></iframe></td>
                </tr>
                <tr>
                    <th style="vertical-align:central;">2000 x 900</th>
                    <td><img id="mdl_ttd" style="padding: 0px; margin: 0px; border: thin solid #CCCCCC; width: 200px; height: 90px;"/></td>
                </tr>
            </table>
            <div style="padding-top:5px;">
                <input type="button" value="Add" />
                <input type="button" value="Save"/>
                <input type="button" value="Delete"/>
                <input type="button" value="Cancel"/>
            </div>
        </fieldset>
    </div> 

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var fl = apl.func.get("fr_list");
        fl.fl = {
            load: function ()
            {
                fl.src = "marketing_list.aspx";
            },
            refresh:function()
            {
                fl.contentWindow.location.reload(true);
            }
        }
        
        var mdl = apl.createModal("mdl",
            {
                tb_id: apl.func.get("mdl_id"),
                ddl_group: apl.createDropdownWS("mdl_group", activities.dl_act_marketing_group),
                tb_name: apl.func.get("mdl_name"),
                tb_phone: apl.func.get("mdl_phone"),
                dl_user: apl.createDropdownWS("mdl_user", activities.ddl_user),
                cb_access: apl.func.get("mdl_access"),
                cb_dasboard: apl.func.get("mdl_dashboard_sts"),
                tb_target: apl.createNumeric("mdl_target", true),
                i_ttd: apl.func.get("mdl_ttd"),
                if_ttd: apl.func.get("mdl_ifttd"),

                val_id: apl.createValidator("save", "mdl_id", function () { return apl.func.emptyValueCheck(mdl.tb_id.value); }, "Inputan salah"),
                val_group: apl.createValidator("save", "mdl_group", function () { return apl.func.emptyValueCheck(mdl.ddl_group.value); }, "Inputan salah"),
                val_name: apl.createValidator("save", "mdl_name", function () { return apl.func.emptyValueCheck(mdl.tb_name.value); }, "Inputan salah"),
                val_phone: apl.createValidator("save", "mdl_phone", function () { return apl.func.emptyValueCheck(mdl.tb_phone.value); }, "Inputan salah"),
                val_user: apl.createValidator("save", "mdl_user", function () { return apl.func.emptyValueCheck(mdl.dl_user.value); }, "Inputan salah"),
                kosongkan:function()
                {
                    mdl.tb_id.value = "";
                    mdl.tb_name.value = "";
                    mdl.tb_phone.value = "";
                    mdl.cb_access.checked = false;
                    mdl.cb_dasboard.checked = false;
                    mdl.tb_target.value = "0";
                    apl.func.validatorClear("save");
                    mdl.i_ttd.Hide();
                    mdl.if_ttd.Hide();
                    mdl.tb_id.readOnly = false;
                },
                tambah:function()
                {
                    mdl.kosongkan();
                    mdl.showAdd("Marketing - Tambah");
                },
                edit: function (marketing_id) {
                    mdl.kosongkan();
                    mdl.i_ttd.Show();
                    mdl.if_ttd.Show();
                    mdl.tb_id.readOnly = true;
                    mdl.i_ttd.src = "../../generate_file.ashx?jenis=marketing&param1=" + marketing_id;
                    mdl.if_ttd.src = "../../upload_image.aspx?jenis=marketing&param1=" + marketing_id;

                    activities.act_marketing_data(marketing_id,
                        function (data) {
                            mdl.tb_id.value = data.marketing_id;
                            mdl.tb_name.value = data.marketing_name;
                            mdl.tb_phone.value = data.marketing_phone;
                            mdl.dl_user.value = data.user_id;
                            mdl.cb_access.checked = data.all_access;
                            mdl.cb_dasboard.checked = data.dashboard_visible;
                            mdl.tb_target.setValue(data.target_value);
                            mdl.ddl_group.value = data.marketing_group_id;
                            mdl.showEdit("Marketing - Edit");
                        }, apl.func.showError, ""
                    );                    
                },
                refresh:function()
                {
                    //mdl.hide();                    
                    fl.fl.refresh();
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) activities.act_marketing_save(mdl.tb_id.value, mdl.tb_name.value, mdl.tb_phone.value, mdl.dl_user.value, mdl.cb_access.checked, mdl.cb_dasboard.checked, mdl.tb_target.getIntValue(), mdl.ddl_group.value, mdl.refresh, apl.func.showError, "");
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    mdl.if_ttd.contentDocument.simpan();                    
                    activities.act_marketing_save(mdl.tb_id.value, mdl.tb_name.value, mdl.tb_phone.value, mdl.dl_user.value, mdl.cb_access.checked, mdl.cb_dasboard.checked, mdl.tb_target.getIntValue(), mdl.ddl_group.value, mdl.refresh, apl.func.showError, "");
                }
            }, 
            function ()
            {
                if(confirm("Yakin akan dihapus?")) activities.act_marketing_delete(mdl.tb_id.value,mdl.refresh, apl.func.showError, "");
            }, "frm_page", "cover_content"
        );

        document.list_tambah = mdl.tambah;
        document.list_edit = mdl.edit;
        document.doc_save = function()
        {
            mdl.if_ttd.src = "../../upload_image.aspx?jenis=marketing&param1=" + mdl.tb_id.value;
            
        }

        window.addEventListener("load", function () {
            fl.fl.load();
        });

        function refresh_dashboard()
        {
            apl.func.showSinkMessage("Proses Refresh");
            activities.dashboard_refresh(function () {                
                apl.func.hideSinkMessage();
            }, apl.func.showError, "");
        }

        var fttd = apl.func.get("f_ttd");
        var ittd = apl.func.get("i_ttd");

        var files = ('files' in fttd);

        function handleFiles(files) {
            for (let i = 0; i < files.length; i++) {
                const file = files[i];

                if (!file.type.startsWith('image/')) { continue }

                const img = document.createElement("img");
                img.classList.add("obj");
                img.file = file;
                preview.appendChild(img); // Assuming that "preview" is the div output where the content will be displayed.

                const reader = new FileReader();
                reader.onload = (function (aImg) { return function (e) { aImg.src = e.target.result; }; })(img);
                reader.readAsDataURL(file);
            }
        }

        function test()
        {
            var x = fttd;
            var txt = "";
            if ('files' in x) {
                if (x.files.length == 0) {
                    txt = "Select one or more files.";
                } else {
                    for (var i = 0; i < x.files.length; i++) {
                        
                        var file = x.files[i];

                        const reader = new FileReader();
                        reader.onload = function (e) { ittd.src=e.target.result; };
                        reader.readAsDataURL(file);
                        
                        /*
                        if ('name' in file) {
                            txt += "name: " + file.name + " | ";
                        }
                        if ('size' in file) {
                            txt += "size: " + file.size ;
                        }
                        if ('type' in file) {
                            txt += "type: " + file.type;
                        }
                        */
                    }
                }
            }
            
            //alert(txt);
        }

        fttd.addEventListener("change", test);

        //mdl.edit("marketing2");
        function simpan_data_image()
        {
            activities.save_image([1, 2], function (keterangan) { alert(keterangan);}, apl.func.showError, "");
        }
        
    </script>
</asp:Content>

