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
            <th>Tipe</th>
            <td><select id="cari_type"></select></td>
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
                    <th>Type</th>
                    <td><select id="mdl_type"></select></td>
                </tr>
                <tr>
                    <th>Kode</th>
                    <td><input type="text" id="mdl_code" size="3" maxlength="3"/></td>
                </tr>
                <tr>
                    <th>Keterangan</th>
                    <td><input type="text" id="mdl_description" size="80" maxlength="100"/></td>
                </tr>
                <tr>
                    <th>Active</th>
                    <td><input type="checkbox" id="mdl_active" /></td>
                </tr>
            </table>
            <div class="button_panel">
                <input type="button" value="Save" />
                <input type="button" value="Cancel" />
            </div>
        </fieldset>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var cari = {
            if_list: apl.func.get("cari_list"),
            ddl_type:apl.createDropdownWS("cari_type",activities.dl_parameter_user),
            load:function()
            {
                var type = escape(cari.ddl_type.value);
                cari.if_list.src = "parameter_user_list.aspx?type=" + type;
            },
            refresh:function()
            {
                cari.if_list.contentDocument.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                ddl_type: apl.createDropdownWS("mdl_type", activities.dl_parameter_user),
                tb_code: apl.func.get("mdl_code"),
                tb_description: apl.func.get("mdl_description"),
                cb_active: apl.func.get("mdl_active"),

                val1: apl.createValidator("save", "mdl_type", function () { return apl.func.emptyValueCheck(mdl.ddl_type.value); }, "Invalid input"),
                val2: apl.createValidator("save", "mdl_code", function () { return apl.func.emptyValueCheck(mdl.tb_code.value); }, "Invalid input"),
                val3: apl.createValidator("save", "mdl_description", function () { return apl.func.emptyValueCheck(mdl.tb_description.value); }, "Invalid input"),

                kosongkan:function()
                {
                    apl.func.validatorClear("save");
                    mdl.tb_code.value = "";
                    mdl.tb_description.value = "";
                    mdl.cb_active.checked = true;
                },
                tambah:function()
                {
                    mdl.kosongkan();
                    mdl.showEdit("Parameter - Tambah");
                },
                edit:function(code,type_id)
                {
                    mdl.kosongkan();
                    activities.app_parameter_user_data(code, type_id,
                        function (data) {
                            mdl.ddl_type.value = type_id;
                            mdl.tb_code.value = code,
                            mdl.tb_description.value = data.description;
                            mdl.cb_active.checked = data.active;
                            mdl.showEdit("Parameter - Edit");
                        }, apl.func.showError, ""
                    );                    
                },
                save:function()
                {
                    if (apl.func.validatorCheck("save"))
                    {
                        activities.app_parameter_user_save(mdl.tb_code.value, mdl.ddl_type.value, mdl.tb_description.value, mdl.cb_active.checked,
                            function () {
                                mdl.hide();
                                cari.refresh();
                            }, apl.func.showError, ""
                        );
                    }
                }
            },
            function () { mdl.save() }, function () { mdl.save() }, undefined, "frm_page", "cover_content"
        );

        document.list_add = mdl.tambah;
        document.list_edit = mdl.edit;

    </script>
</asp:Content>

