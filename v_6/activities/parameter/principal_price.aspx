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

    <iframe class="frameList" id="cari_list"></iframe>

    <div class="modal" id="mdl">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th><label for="mdl_type">Tipe</label></th>
                    <td><select id="mdl_type"></select></td>
                </tr>
                <tr>
                    <th><label for="mdl_active">Status</label></th>
                    <td><input type="checkbox" id="mdl_active"/></td>
                </tr>
                <tr>
                    <th><label for="mdl_active_date">Tgl.Aktif</label></th>
                    <td><input type="text" id="mdl_active_date" size="10" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th><label for="mdl_deactive_date">Tgl.Non Aktif</label></th>
                    <td><input type="text" id="mdl_deactive_date" size="10" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th>Detail</th>
                    <td>
                        <table class="gridView" id="mdl_tbl">
                            <tr>
                                <th style="width:25px;"><div class="tambah" onclick="mdl1.add();"></div></th>
                                <th>Nilai A</th>
                                <th>Nilai B</th>
                                <th>Pcg</th>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <div class="button_panel">
                <input type="button" value="Add" />
                <input type="button" value="Save" />
                <input type="button" value="Cancel" />
            </div>
        </fieldset>
    </div>

    <div class="modal" id="mdl1">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th><label for="mdl1_range1">Nilai A</label></th>
                    <td><input type="text" id="mdl1_range1" size="15" maxlength="15" style="text-align:right;"/></td>
                </tr>
                <tr>
                    <th><label for="mdl1_range2">Nilai B</label></th>
                    <td><input type="text" id="mdl1_range2" size="15" maxlength="15" style="text-align:right;"/></td>
                </tr>
                <tr>
                    <th><label for="mdl1_pcg">Percentase</label></th>
                    <td><input type="text" id="mdl1_pcg" size="5" maxlength="5" style="text-align:right;"/></td>
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
            fl_list: apl.func.get("cari_list"),
            load: function () {
                cari.fl_list.src = "principal_price_list.aspx?";
            },
            refresh: function () {
                cari.fl_list.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                param_pp_id: 0,
                cb_status: apl.func.get("mdl_active"),
                tb_activedate: apl.func.get("mdl_active_date"),
                tb_deactivedate: apl.func.get("mdl_deactive_date"),
                ddl_type: apl.createDropdownWS("mdl_type", activities.dl_par_price_principal_type),
                tbl: apl.createTableWS.init("mdl_tbl",
                    [
                        apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "edit")], function (data) { mdl1.edit(data.param_pp_dtl_id); }),
                        apl.createTableWS.column("range1", undefined, [apl.func.createAttribute("style", "text-align:right")], undefined, true),
                        apl.createTableWS.column("range2", undefined, [apl.func.createAttribute("style", "text-align:right")], undefined, true),
                        apl.createTableWS.column("pcg", undefined, [apl.func.createAttribute("style", "text-align:right")], undefined, true)
                    ]
                ),
                tbl_load: function (id) {                    
                    activities.par_principal_price_dtl_list(id,
                        function (arrData) {                            
                            mdl.tbl.load(arrData);
                        }, apl.func.showError, ""
                    );
                },

                valtype: apl.createValidator("save", "mdl_type", function () { return apl.func.emptyValueCheck(mdl.ddl_type.value); }, "Salah input"),
                
                kosongkan:function()
                {
                    param_pp_id: 0,
                    mdl.ddl_type.value = "";
                    mdl.ddl_type.disabled = false;
                    mdl.cb_status.Hide();                    
                    mdl.tb_activedate.Hide();
                    mdl.tb_deactivedate.Hide();
                    mdl.tbl.Hide();
                },
                add:function()
                {
                    mdl.kosongkan();
                    mdl.showAdd("Parameter - Tambah");
                },
                edit:function(id)
                {
                    mdl.kosongkan();                    
                    mdl.param_pp_id = id;
                    mdl.tbl_load(id);
                    activities.par_principal_price_data(id,
                        function (data)
                        {
                            mdl.ddl_type.disabled = true;
                            mdl.cb_status.Show();
                            mdl.tb_activedate.Show();
                            mdl.tb_deactivedate.Show();
                            mdl.tbl.Show();

                            mdl.ddl_type.value = data.par_principal_price_type_id;
                            mdl.cb_status.checked = data.active_sts;
                            mdl.tb_activedate.value = data.active_date;
                            mdl.tb_deactivedate.value = data.deactive_date;
                            mdl.showEdit("Parameter - Edit");
                        },
                        apl.func.showError, ""
                    );                    

                }
            },
            function ()
            {
                if(apl.func.validatorCheck("save"))
                {
                    apl.func.showSinkMessage("Save...");
                    activities.par_principal_price_add(mdl.ddl_type.value,
                        function (id)
                        {
                            apl.func.hideSinkMessage();
                            mdl.edit(id);
                        },
                        apl.func.showError, ""
                    );                    
                }
            },
            function ()
            {
                apl.func.showSinkMessage("Simpan...");
                activities.par_principal_price_edit(mdl.param_pp_id, mdl.cb_status.checked,
                    function () {
                        mdl.hide();
                        cari.refresh();

                        apl.func.hideSinkMessage();
                    }, apl.func.showError, ""
                );
            }, undefined, "frm_page", "cover_content"
        );

        var mdl1 = apl.createModal("mdl1",
            {
                param_pp_id: 0,
                param_pp_dtl_id: 0,
                tb_range1: apl.createNumeric("mdl1_range1"),
                tb_range2: apl.createNumeric("mdl1_range2"),
                tb_pcg: apl.createNumeric("mdl1_pcg", false, 2),

                valrang1: apl.createValidator("dsave", "mdl1_range1", function () { return apl.func.emptyValueCheck(mdl1.tb_range1.value); }, "Salah input"),
                valrang2: apl.createValidator("dsave", "mdl1_range2", function () { return apl.func.emptyValueCheck(mdl1.tb_range2.value); }, "Salah input"),
                valpcg: apl.createValidator("dsave", "mdl1_pcg", function () { return apl.func.emptyValueCheck(mdl1.tb_pcg.value); }, "Salah input"),

                kosongkan: function(id)
                {
                    mdl1.param_pp_dtl_id = id;
                    mdl1.param_pp_id = mdl.param_pp_id;
                    mdl1.tb_range1.value = "";
                    mdl1.tb_range2.value = "";
                    mdl1.tb_pcg.value = "";
                },
                add:function()
                {
                    mdl1.kosongkan(0);
                    mdl1.showAdd("Detail: Add");
                },
                edit:function(id)
                {
                    mdl1.kosongkan(id);                    
                    activities.par_principal_price_dtl_data(id,
                        function (data) {
                            mdl1.tb_range1.setValue(data.range1);
                            mdl1.tb_range2.setValue(data.range2);
                            mdl1.tb_pcg.setValue(data.pcg);
                            mdl1.showEdit("Detail: edit");
                        }, apl.func.showError, ""
                    );                    
                }

            },
            function ()
            {
                if(apl.func.validatorCheck("dsave"))
                {
                    apl.func.showSinkMessage("Simpan...");
                    activities.par_principal_price_dtl_add(mdl1.param_pp_id, mdl1.tb_range1.getIntValue(), mdl1.tb_range2.getIntValue(), mdl1.tb_pcg.getIntValue(),
                        function ()
                        {
                            mdl1.hide();
                            mdl.tbl_load(mdl.param_pp_id);
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                }
            },
            function () {
                if (apl.func.validatorCheck("dsave"))
                {
                    activities.par_principal_price_dtl_edit(mdl1.param_pp_dtl_id, mdl1.tb_range1.getIntValue(), mdl1.tb_range2.getIntValue(), mdl1.tb_pcg.getIntValue(),
                        function () {
                            mdl1.hide();
                            mdl.tbl_load(mdl.param_pp_id);
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                }
            }, 
            function ()
            {
                if(confirm("Yakin dihapus?"))
                {
                    activities.par_principal_price_dtl_delete(mdl1.param_pp_dtl_id,
                        function () {
                            mdl1.hide();
                            mdl.tbl_load(mdl.param_pp_id);
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                }
            }, "frm_page", "mdl"
        );
        

        window.addEventListener("load",
            function ()
            {
                cari.load()
                document.list_add = mdl.add;
                document.list_edit = mdl.edit;
            }
        );
    </script>
</asp:Content>

