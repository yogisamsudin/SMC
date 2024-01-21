<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" theme="Page" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" src="../../js/Komponen.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <asp:ScriptManager runat="server" ID="sm">
        <Services>
            <asp:ServiceReference Path="../report.asmx" />
        </Services> 
    </asp:ScriptManager>  

    <table class="formview">
        <tr>
            <th style="width:100px;vertical-align:middle;">Module</th>
            <td style="width:300px"><input type="text" autocomplete="off" size="50" id="cari_module"/></td>            
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.load()">Cari</div></td>
        </tr>
    </table>
    
    <iframe class="frameList" id="cari_fr" style="height:420px;"></iframe>

    <div class="modal" id="mdl">
        <fieldset>
            <legend>Edit</legend>
            <table class="formview" style="width:100%;">
                <tr>
                    <th style="width:150px;">Kode</th>
                    <td><label id="mdl_id"></label></td>
                </tr>
                <tr>
                    <th >Module Name</th>
                    <td><input type="text" id="mdl_name" autocomplete="off" size="50" maxlength="50"/></td>
                </tr>
                <tr>
                    <th style="vertical-align:top;">Report List</th>
                    <td>
                        <table class="gridView" id="mdl_tbl" style="width:100%;">
                            <tr>
                                <td style="width:25px;"><div class="tambah" title="Tambah data repot" onclick="mdl_list.tambah()"></div></td>
                                <th style="text-align:left;">ID</th>
                                <th style="text-align:left;">Display Name</th>
                                <th style="text-align:left;">File Name</th>
                            </tr>
                        </table>                        
                    </td>
                </tr>
            </table>
            <br />
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Add" />
                <input type="button" value="Save"/>
                <input type="button" value="Delete" />
                <input type="button" value="Cancel"/>
            </div>
        </fieldset>
    </div>

    <div class="modal" id="mdl_list">
        <fieldset>
            <legend></legend>
            <table class="formview" style="width:100%;">
                <tr>
                    <th style="width:100px;">Display Name</th>
                    <td><input type="text" id="mdl_list_display" autocomplete="off" size="50" maxlength="50"/></td>
                </tr>
                <tr>
                    <th>File Name</th>
                    <td><input type="text" id="mdl_list_filename" autocomplete="off" size="60"/></td>
                </tr>
                <tr>
                    <th>Setting List</th>
                    <td>
                        <table class="gridView" id="mdl_list_tbl" style="width:100%;">
                            <tr>
                                <td style="width:25px"><div class="tambah" title="Tambah setting data" onclick="mdl_setting.tambah()"></div></td>
                                <th>Parameter</th>
                                <th>Prompt Text</th>
                                <th>Input</th>
                                <th>Type</th>
                                <th>Size</th>
                            </tr>                            
                        </table>
                    </td>
                </tr>
            </table>
            <br />
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Add" />
                <input type="button" value="Save"/>
                <input type="button" value="Delete" />
                <input type="button" value="Cancel"/>
            </div>
        </fieldset>
    </div>

    <div class="modal" id="mdl_setting">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th style="width:100px;">Parameter</th>
                    <td><input type="text" size="25" maxlength="25" id="mdl_setting_Parameter"/></td>
                </tr>
                <tr>
                    <th>Prompt Text</th>
                    <td><input type="text" size="25" maxlength="25" id="mdl_setting_Prompt"/></td>
                </tr>
                <tr>
                    <th>Type</th>
                    <td><select id="mdl_setting_Type"></select></td>
                </tr>
                <tr>
                    <th>Input</th>
                    <td><select id="mdl_setting_Input"></select></td>
                </tr>
                <tr>
                    <th>Size</th>
                    <td><input type="text" id="mdl_setting_Size" size="3" maxlength="3" style="text-align:right;"/></td>
                </tr>
                <tr>
                    <th>Field Value</th>
                    <td><input type="text" size="35" maxlength="35" id="mdl_setting_FieldValue"/></td>
                </tr>
                <tr>
                    <th>Field Text</th>
                    <td><input type="text" size="35" maxlength="35" id="mdl_setting_FieldText"/></td>
                </tr>
                <tr>
                    <th>Condition</th>
                    <td><input type="text" size="50" maxlength="100" id="mdl_setting_Condition"/></td>
                </tr>
                <tr>
                    <th>Source</th>
                    <td><input type="text" size="50" maxlength="100" id="mdl_setting_Source"/></td>
                </tr>                        
                    
            </table>
            <br />
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
            tb_module: apl.func.get("cari_module"),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var module = cari.tb_module.value;                
                cari.fl.src = "Modul_list.aspx?name=" + escape(module);
                document.list_add = mdl.tambah;
                document.list_edit = mdl.edit;
                
            },
            fl_refresh: function () {
                cari.fl.contentWindow.location.reload(true);
            }
        }

        var mdl = apl.createModal("mdl",
            {
                lb_id: apl.func.get("mdl_id"),
                tb_name: apl.func.get("mdl_name"),
                val_name: apl.createValidator("module_save", "mdl_name", function () { return apl.func.emptyValueCheck(mdl.tb_name.value); }, "Salah input"),
                tbl: apl.createTableWS.init("mdl_tbl",
                    [
                        apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "edit"), apl.createTableWS.attribute("title", "edit")], function (data) { mdl_list.edit(data.ListID); }),
                        apl.createTableWS.column("ListID"),
                        apl.createTableWS.column("DisplayName"),
                        apl.createTableWS.column("FileName")
                    ]
                ),
                tbl_load:function(id)
                {
                    report.rptList(id, function (arrData) { mdl.tbl.load(arrData); }, apl.func.showError, "");
                },
                kosongkan:function()
                {
                    mdl.lb_id.innerHTML = "";
                    mdl.tb_name.value = "";
                    mdl.tbl.clearAllRow();
                    apl.func.validatorClear("module_save");
                },
                tambah:function()
                {
                    mdl.kosongkan()
                    mdl.tbl.Hide();
                    mdl.showAdd("Modul - Tambah");
                },
                edit:function(id)
                {
                    mdl.kosongkan();
                    mdl.tbl.Show();
                    mdl.tbl_load(id);
                    report.rptModulByModuleCode(id,
                        function (data) {
                            mdl.lb_id.innerHTML = data.moduleCode;
                            mdl.tb_name.value = data.Name;                            
                            mdl.showEdit("Modul - Edit");                        
                        },
                        apl.func.showError, ""
                    );
                },
                close:function()
                {
                    mdl.hide();
                    cari.fl_refresh();
                }
            },
            function ()
            {
                if (apl.func.validatorCheck("module_save")) {
                    report.rptModuleAdd(mdl.tb_name.value,
                        function (id) {
                            cari.fl_refresh();
                            mdl.edit(id);
                        }, apl.func.showError, ""
                    );
                }
            },
            function () {
                if (apl.func.validatorCheck("module_save")) {
                    report.rptModuleSave(mdl.lb_id.innerHTML, mdl.tb_name.value, mdl.close, apl.func.showError, "");
                }
            },
            function () {
                if (confirm('Yakin akan dihapus?')) {
                    report.rptModuleDelete(mdl.lb_id.innerHTML, mdl.close, apl.func.showError, "");
                }
            },
            "frm_page",
            "cover_content"
        );


        var mdl_list = apl.createModal("mdl_list",
            {
                list_id: 0,
                tb_display: apl.func.get("mdl_list_display"),
                tb_filename: apl.func.get("mdl_list_filename"),
                val_display: apl.createValidator("list_save", "mdl_list_display", function () { return apl.func.emptyValueCheck(mdl_list.tb_display.value); }, "Salah input"),
                val_filename: apl.createValidator("list_save", "mdl_list_filename", function () { return apl.func.emptyValueCheck(mdl_list.tb_filename.value); }, "Salah input"),
                tbl: apl.createTableWS.init("mdl_list_tbl",
                    [
                        apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "edit"), apl.createTableWS.attribute("title", "edit")],
                            function (data) {
                                mdl_setting.edit(data.ParameterID);
                            }
                        ),
                        apl.createTableWS.column("Parameter"),
                        apl.createTableWS.column("PromptText"),
                        apl.createTableWS.column("FieldDataType"),
                        apl.createTableWS.column("FieldInputType"),
                        apl.createTableWS.column("Size")
                    ]
                ),
                tbl_load: function (id) {                    
                    report.rptSettingList(id, function (arrData) { mdl_list.tbl.load(arrData); }, apl.func.showError, "");
                },
                kosongkan:function()
                {
                    mdl_list.list_id = 0;
                    mdl_list.tb_display.value = "";
                    mdl_list.tb_filename.value = "";
                    mdl_list.tbl.clearAllRow();
                    apl.func.validatorClear("list_save");
                },
                tambah: function ()
                {
                    mdl_list.kosongkan();
                    mdl_list.tbl.Hide();
                    mdl_list.showAdd("Laporan - Tambah")
                },
                edit:function(id)
                {
                    mdl_list.kosongkan();
                    mdl_list.tbl_load(id);
                    report.rptListByCodeID(mdl.lb_id.innerHTML, id,
                        function (data) {                            
                            mdl_list.tbl.Show();
                            mdl_list.list_id = data.ListID;
                            mdl_list.tb_display.value = data.DisplayName;
                            mdl_list.tb_filename.value = data.FileName;
                            mdl_list.showEdit("laporan - Edit");
                        }, apl.func.showError, ""
                    );
                },
                close:function()
                {
                    mdl.tbl_load(mdl.lb_id.innerHTML);
                    mdl_list.hide();
                }
            },
            function ()
            {
                if (apl.func.validatorCheck("list_save"))
                {
                    report.rptListAdd(mdl.lb_id.innerHTML, mdl_list.tb_display.value, mdl_list.tb_filename.value,
                        function (id) {
                            mdl.tbl_load(mdl.lb_id.innerHTML);
                            mdl_list.edit(id);
                        }, apl.func.showError, ""
                    );
                }
            },
            function ()
            {
                if (apl.func.validatorCheck("list_save"))
                {
                    report.rptListEdit(mdl_list.list_id, mdl_list.tb_display.value, mdl_list.tb_filename.value, mdl_list.close, apl.func.showError, "");
                }                    
            },
            function () {
                if (confirm("Yakin akan dihapus?")) {
                    report.rptListDelete(mdl_list.list_id, mdl_list.close, apl.func.showError, "");
                }
            },
            "frm_page", "mdl"
        );

        var mdl_setting = apl.createModal("mdl_setting",
            {
                parameter_id: 0,
                tb_parameter: apl.func.get("mdl_setting_Parameter"),
                tb_prompt: apl.func.get("mdl_setting_Prompt"),
                dl_type: apl.createDropdownWS("mdl_setting_Type", report.dl_setting_type),
                dl_input: apl.createDropdownWS("mdl_setting_Input", report.dl_setting_input),
                tb_size: apl.createNumeric("mdl_setting_Size"),
                tb_fieldvalue: apl.func.get("mdl_setting_FieldValue"),
                tb_fieldtext: apl.func.get("mdl_setting_FieldText"),
                tb_condition: apl.func.get("mdl_setting_Condition"),
                tb_source: apl.func.get("mdl_setting_Source"),

                val_parameter: apl.createValidator("setting_save", "mdl_setting_Parameter", function () { return apl.func.emptyValueCheck(mdl_setting.tb_parameter.value); }, "Salah input"),
                val_prompt: apl.createValidator("setting_save", "mdl_setting_Prompt", function () { return apl.func.emptyValueCheck(mdl_setting.tb_prompt.value); }, "Salah input"),
                val_type: apl.createValidator("setting_save", "mdl_setting_Type", function () { return apl.func.emptyValueCheck(mdl_setting.dl_type.value); }, "Salah input"),
                val_input: apl.createValidator("setting_save", "mdl_setting_Input", function () { return apl.func.emptyValueCheck(mdl_setting.dl_input.value); }, "Salah input"),
                val_size: apl.createValidator("setting_save", "mdl_setting_Size", function () { return apl.func.emptyValueCheck(mdl_setting.tb_size.value); }, "Salah input"),

                kosong:function()
                {
                    mdl_setting.parameter_id = 0;
                    mdl_setting.tb_parameter.value = "";
                    mdl_setting.tb_prompt.value = "";
                    mdl_setting.dl_type.value = "";
                    mdl_setting.dl_input.value = "";
                    mdl_setting.tb_prompt.value = "";
                    mdl_setting.tb_fieldvalue.value = "";
                    mdl_setting.tb_fieldtext.value = "";
                    mdl_setting.tb_condition.value = "";
                    mdl_setting.tb_source.value = "";
                    apl.func.validatorClear("setting_save");
                },
                tambah:function()
                {
                    mdl_setting.kosong();
                    mdl_setting.showAdd("Seting - Tambah");
                },
                edit: function (id)
                {
                    mdl_setting.kosong();
                    report.rptSettingByParameterID(id,
                        function (data) {
                            mdl_setting.parameter_id = data.ParameterID;
                            mdl_setting.tb_parameter.value = data.Parameter;
                            mdl_setting.tb_prompt.value = data.PromptText;
                            mdl_setting.dl_type.value = data.FieldDataTypeID;
                            mdl_setting.dl_input.value = data.FieldInputTypeID;
                            mdl_setting.tb_size.value = data.Size;
                            mdl_setting.tb_fieldvalue.value = data.FieldName;
                            mdl_setting.tb_fieldtext.value = data.FieldText;
                            mdl_setting.tb_condition.value = data.FieldCondition;
                            mdl_setting.tb_source.value = data.Source;
                            mdl_setting.showEdit("Seting - Edit");
                        }, apl.func.showError, ""
                    );
                },
                close: function ()
                {
                    mdl_list.tbl_load(mdl_list.list_id);
                    mdl_setting.hide();
                }
            },
            function ()
            {
                if(apl.func.validatorCheck("setting_save")) report.rptSettingAdd(mdl_list.list_id, mdl_setting.tb_parameter.value, mdl_setting.tb_prompt.value, mdl_setting.dl_type.value, mdl_setting.dl_input.value, mdl_setting.tb_size.getIntValue(), mdl_setting.tb_fieldvalue.value, mdl_setting.tb_fieldtext.value, mdl_setting.tb_condition.value, mdl_setting.tb_source.value,mdl_setting.close, apl.func.showError, "");                
            },
            function () {
                if (apl.func.validatorCheck("setting_save")) report.rptSettingEdit(mdl_setting.parameter_id, mdl_setting.tb_parameter.value, mdl_setting.tb_prompt.value, mdl_setting.dl_type.value, mdl_setting.dl_input.value, mdl_setting.tb_size.getIntValue(), mdl_setting.tb_fieldvalue.value, mdl_setting.tb_fieldtext.value, mdl_setting.tb_condition.value, mdl_setting.tb_source.value, mdl_setting.close, apl.func.showError, "");                
            },
            function () {
                if (confirm("Yakin dihapus?")) report.rptSettingDelete(mdl_setting.parameter_id, mdl_setting.close, apl.func.showError, "");
            }, "frm_page", "mdl_list");

        window.addEventListener("load",
            function () {
                cari.load();
            }
        );
    </script>
</asp:Content>

