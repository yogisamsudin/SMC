<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page"%>

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
            <th>Nama</th>
            <td><input type="text" id="cari_name"/></td>
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
                    <th>Tanggal</th>
                    <td><input type="text" id="mdl_date" size="10" maxlength="10" readonly="readonly"/></td>
                </tr>
                <tr>
                    <th>Nama</th>
                    <td><input type="text" id="mdl_name" size="50" maxlength="50"/></td>
                </tr>
                <tr>
                    <th>Bulan</th>
                    <td><select id="mdl_month"></select></td>
                </tr>
                <tr>
                    <th>Tahun</th>
                    <td><input type="text" size="4" maxlength="4" id="mdl_year"/></td>
                </tr>
                <tr>
                    <th>Karyawan</th>
                    <td>
                        <table class="gridView" id="mdl_tbl">
                            <tr>
                                <th style="width:25px"><div class="tambah"></div></th>
                                <th>Nama</th>
                                <th>Total</th>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Add"/>
                <input type="button" value="Save"/>                
                <input type="button" value="Delete"/>                
                <input type="button" value="Close"/>    
                
                <select id="mdl_cetak_type_mdl" style="float:right;">
                    <option value="">PDF</option>
                    <option value="3">Word</option>
                    <option value="2">Excel</option>
                </select>
                <input type="button" value="Print" onclick="mdl.prop.print(document.getElementById('mdl_cetak_type_mdl').value);" style="float:right;"/>             
            </div>
        </fieldset>
    </div>

    <div class="modal" id="mdldtl">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Nama</th>
                    <td><label id="mdldtl_name"></label></td>
                </tr>               
                <tr>
                    <th>Rincian</th>
                    <td>
                        <table class="gridView" id="mdldtl_tbl">
                            <tr>
                                <th style="width:25px"><div class="tambah" onclick="mdldtl1.prop.tambah();"></div></th>
                                <th>Parameter</th>
                                <th>Tipe</th>
                                <th>Nilai</th>
                                <th>Note</th>                                
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Close"/> 
                <select id="mdl_cetak_type" style="float:right;">
                    <option value="">PDF</option>
                    <option value="3">Word</option>
                    <option value="2">Excel</option>
                </select>
                <input type="button" value="Print" onclick="mdldtl.prop.print(document.getElementById('mdl_cetak_type').value);" style="float:right;"/>               
            </div>
        </fieldset>
    </div>
    <div class="modal" id="mdldtl1">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Pengupahan</th>
                    <td>
                        <select id="mdldtl1_wageparam"></select>
                        <label id="mdldtl1_wageparam2"></label>
                    </td>
                </tr>
                <tr>
                    <th>Nilai</th>
                    <td><input type="text" id="mdldtl1_nilai" size="20" maxlength="20" style="text-align:right"/></td>
                </tr>
                <tr>
                    <th>Total</th>
                    <td><input type="text" id="mdldtl1_total" size="3" maxlength="3" style="text-align:right"/></td>
                </tr>
                <tr>
                    <th>Note</th>
                    <td><textarea id="mdldtl1_note"></textarea></td>
                </tr>
            </table>
            
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Add"/>  
                <input type="button" value="Save"/>  
                <input type="button" value="Delete"/>  
                <input type="button" value="Close"/>                
            </div>
        </fieldset>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        let waktu = new Date();
        let cur_month = waktu.getMonth() + 1;
        let cur_year = waktu.getFullYear();
        
        var cari = {
            tb_name: apl.func.get("cari_name"),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var name = escape(cari.tb_name.value);
                cari.fl.src = "salary_list.aspx?name=" + name;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.create_modal("mdl",
            {
                id: 0,
                tb_date: apl.createCalender("mdl_date"),
                tb_name: apl.func.get("mdl_name"),
                dl_month: apl.createDropdownWS("mdl_month", activities.dl_list_month),
                tb_year: apl.func.get("mdl_year"),
                tbl: apl.createTableWS.init("mdl_tbl", [
                    apl.createTableWS.column("salary_employee_id", undefined, [apl.createTableWS.attribute("class", "edit")], function (d) { mdldtl.prop.edit(d.salary_employee_id, d.employee_name, d.employee_id); }, undefined, "DIV", "D"),
                    apl.createTableWS.column("employee_name"),
                    apl.createTableWS.column("total_salary", undefined, [apl.createTableWS.attribute("style", "text-align:right;")], undefined, true)
                ]),

                val1: apl.createValidator("save", "mdl_name", function () { return apl.func.emptyValueCheck(mdl.prop.tb_name.value); }, "Salah input"),
                val2: apl.createValidator("save", "mdl_date", function () { return apl.func.emptyValueCheck(mdl.prop.tb_date.value); }, "Salah input"),
                val3: apl.createValidator("save", "mdl_month", function () { return apl.func.emptyValueCheck(mdl.prop.dl_month.value); }, "Salah input"),
                val4: apl.createValidator("save", "mdl_year", function () { return apl.func.emptyValueCheck(mdl.prop.tb_year.value); }, "Salah input"),

                init: function () {
                    mdl.prop.id = 0;
                    mdl.prop.tb_name.value = "";
                    mdl.prop.tb_date.value = "";
                    mdl.prop.dl_month.value = "";
                    mdl.prop.tb_year.value = "";

                    mdl.prop.tbl.clearAllRow();
                    mdl.prop.tbl.Hide();

                    apl.func.validatorClear("save");
                    apl.func.hideSinkMessage();
                },
                tbl_load: function () {                    
                    activities.hr_salary_employee_list(mdl.prop.id, function (arr) { mdl.prop.tbl.load(arr);  }, apl.func.showError, "");                },
                tambah: function () {
                    mdl.prop.init();

                    mdl.showAdd("Tambah Data");

                },
                edit: function (id) {
                    apl.func.showSinkMessage("Memuat Data");
                    mdl.prop.init();
                    mdl.prop.id = id;
                    mdl.prop.tbl_load();
                    mdl.prop.tbl.Show();

                    activities.hr_salary_data(id,
                        function (data) {
                            mdl.prop.tb_name.value = data.salary_name;
                            mdl.prop.tb_date.value = data.salary_date;
                            mdl.prop.dl_month.value = data.month_issue;
                            mdl.prop.tb_year.value = data.year_issue;
                            mdl.showEdit("Edit Data");

                            if (data.month_issue >= cur_month && data.year_issue >= cur_year) {
                                mdl.btnSave.show();
                                mdl.btnDelete.show();
                            } else {
                                mdl.btnSave.hide();
                                mdl.btnDelete.hide();
                            }
                            
                        }, apl.func.showError, ""
                    );
                },
                close: function () {
                    mdl.hide();
                    cari.fl_refresh();
                    apl.func.hideSinkMessage();
                },
                print: function (file_type) {
                    if (mdl.prop.id != 0) {
                        var fName = mdl.prop.tb_name.value;
                        fName = window.escape(fName.replace(/ /g, "_"));
                        window.location = "../../report/report_generator.ashx?ListID=29&salary_id=" + mdl.prop.id + "&pdfName=" + fName + "&fileType=" + file_type;
                    }
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menambah Data");
                    activities.hr_salary_add(mdl.prop.tb_name.value, mdl.prop.dl_month.value, mdl.prop.tb_year.value, mdl.prop.tb_date.value,
                        function (id) {
                            mdl.prop.edit(id);
                        },
                        apl.func.showError, ""
                    );
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menyimpan Data");
                    activities.hr_salary_edit(mdl.prop.id, mdl.prop.tb_name.value, mdl.prop.dl_month.value, mdl.prop.tb_year.value, mdl.prop.tb_date.value, mdl.prop.close, apl.func.showError, "");
                }
            },
            function () {
                if (confirm("Yakin akan dihapus?")) activities.hr_salary_delete(mdl.prop.id, mdl.prop.close, apl.func.showError, "");
            }, "frm_page", "cover_content"
        );

        var mdldtl = apl.create_modal("mdldtl",
            {
                salary_employee_id: 0,

                lb_name: apl.func.get("mdldtl_name"),
                tbl: apl.createTableWS.init("mdldtl_tbl", [
                    apl.createTableWS.column("salary_employee_wageparam_id", undefined, [apl.createTableWS.attribute("class", "edit")], function (d) { mdldtl1.prop.edit(d.salary_employee_wageparam_id); }, undefined, "DIV", "D",
                        function (e,d) {
                            if (d.tetap_sts == true) e.style.display = "none";else e.style.display = "";
                        }
                    ),
                    apl.createTableWS.column("wageparam_name"),
                    apl.createTableWS.column("type_name"),
                    apl.createTableWS.column("total_nilai", undefined, [apl.createTableWS.attribute("style", "text-align:right;")], undefined, true),
                    apl.createTableWS.column("note"),
                ]),

                tbl_load:function()
                {
                    activities.hr_salary_employee_wageparam_list(mdldtl.prop.salary_employee_id, function (arr) { mdldtl.prop.tbl.load(arr);}, apl.func.showError, "");
                },
                edit: function (salary_employee_id, employee_name, employee_id)
                {
                    mdldtl.prop.salary_employee_id = salary_employee_id;
                    mdldtl.prop.lb_name.innerHTML = employee_name;
                    mdldtl.prop.tbl_load();
                    mdldtl.showEdit("Edit Data");
                },
                print: function (file_type) {
                    if (mdldtl.prop.salary_employee_id != 0) {
                        var fName = mdldtl.prop.lb_name.innerHTML+"_"+mdl.prop.tb_year.value+"-"+mdl.prop.dl_month.value;
                        fName = window.escape(fName.replace(/ /g, "_"));
                        window.location = "../../report/report_generator.ashx?ListID=28&salary_employee_id=" + mdldtl.prop.salary_employee_id + "&pdfName=" + fName + "&fileType=" + file_type;
                    }
                }
            },
            undefined, undefined, undefined, "frm_page", "mdl"
        );

        var mdldtl1 = apl.create_modal("mdldtl1",
            {
                id: 0,
                                
                dl_wageparam: apl.createDropdownWS("mdldtl1_wageparam", activities.dl_hr_wageparam_vs_salary_employee_wageparam, undefined, undefined, true, function () { return "salary_employee_id=" + mdldtl.prop.salary_employee_id }),
                tb_nilai: apl.createNumeric("mdldtl1_nilai"),
                tb_total: apl.createNumeric("mdldtl1_total"),
                tb_note: apl.func.get("mdldtl1_note"),
                lb_wageparam: apl.createNumeric("mdldtl1_wageparam2"),

                val1: apl.createValidator("savedtl1", "mdldtl1_wageparam", function () { return (apl.func.emptyValueCheck(mdldtl1.prop.dl_wageparam.value) && mdldtl1.prop.salary_employee_wageparam_id==0); }, "Invalid input"),
                val2: apl.createValidator("savedtl1", "mdldtl1_nilai", function () { return apl.func.emptyValueCheck(mdldtl1.prop.tb_nilai.value); }, "Invalid input"),
                val3: apl.createValidator("savedtl1", "mdldtl1_total", function () { return apl.func.emptyValueCheck(mdldtl1.prop.tb_total.value); }, "Invalid input"),

                init:function()
                {
                    mdldtl1.prop.salary_employee_wageparam_id = 0;
                    mdldtl1.prop.dl_wageparam.value = "";
                    mdldtl1.prop.tb_nilai.value = "";
                    mdldtl1.prop.tb_total.value = "1";
                    mdldtl1.prop.tb_note.value = "";
                    mdldtl1.prop.lb_wageparam.innerHTML = "";

                    mdldtl1.prop.dl_wageparam.Show();
                    mdldtl1.prop.lb_wageparam.Hide();
                    mdldtl1.prop.tb_nilai.disabled = false;
                    
                   
                    apl.func.validatorClear("save");
                    apl.func.hideSinkMessage();
                },

                tambah: function ()
                {
                    mdldtl1.prop.init();
                    mdldtl1.showAdd("Tambah Data");
                },
                edit:function(id)
                {
                    mdldtl1.prop.init();
                    mdldtl1.prop.salary_employee_wageparam_id = id;
                    activities.hr_salary_employee_wageparam_data(id,
                        function (data) {
                            
                            mdldtl1.prop.lb_wageparam.innerHTML = data.wageparam_name;
                            mdldtl1.prop.tb_nilai.setValue(data.nilai);
                            mdldtl1.prop.tb_total.setValue(data.total);
                            mdldtl1.prop.tb_note.value = data.note;

                            mdldtl1.prop.dl_wageparam.Hide();
                            mdldtl1.prop.lb_wageparam.Show();
                            mdldtl1.prop.tb_nilai.disabled = data.delete_restrict_sts;

                            mdldtl1.showEdit("Edit Data");

                            if (mdldtl1.btnDelete != undefined && data.delete_restrict_sts==true) {

                                mdldtl1.btnDelete.hide();
                            }
                            
                        },
                        apl.func.showError, ""
                    );
                },
                close:function()
                {
                    mdldtl1.hide();
                    mdldtl.prop.tbl_load();
                    mdl.prop.tbl_load();
                }
            },
            function () {
                if(apl.func.validatorCheck("savedtl1")) activities.hr_salary_employee_wageparam_add(mdldtl.prop.salary_employee_id,mdldtl1.prop.dl_wageparam.value, mdldtl1.prop.tb_nilai.getIntValue(),mdldtl1.prop.tb_total.getIntValue(),mdldtl1.prop.tb_note.value,mdldtl1.prop.close,apl.func.showError,"");
            }, 
            function () {
                if (apl.func.validatorCheck("savedtl1")) activities.hr_salary_employee_wageparam_edit(mdldtl1.prop.salary_employee_wageparam_id, mdldtl1.prop.tb_nilai.getIntValue(), mdldtl1.prop.tb_total.getIntValue(), mdldtl1.prop.tb_note.value, mdldtl1.prop.close, apl.func.showError, "");
            }, 
            function () {
                if (confirm("Yakin akan dihapus?")) activities.hr_salary_employee_wageparam_delete(mdldtl1.prop.salary_employee_wageparam_id,  mdldtl1.prop.close, apl.func.showError, "");
            }, "frm_page", "mdldtl"
        );
       
        window.addEventListener("load", function () {
            document.list_add = mdl.prop.tambah;
            document.list_edit = mdl.prop.edit;

            
        });
    </script>
</asp:Content>

