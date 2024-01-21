<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page" %>

<script runat="server">
    void Page_Load()
    {
        string nama = "b@andung";
        Response.Write(nama.Replace("@","a"));
    }
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
                    <th>NIK</th>
                    <td><input type="text" id="mdl_nik" size="10" maxlength="10"/></td>
                </tr>
                <tr>
                    <th>Nama</th>
                    <td><input type="text" id="mdl_name" size="50" maxlength="50"/></td>
                </tr>                
                
                <tr>
                    <th>Jabatan</th>
                    <td><select id="mdl_position"></select></td>
                </tr>
                <tr>
                    <th>Tgl.Masuk</th>
                    <td><input type="text" id="mdl_datein" size="10" maxlength="10" readonly="readonly"/></td>
                </tr>
                <tr>
                    <th>Tgl.Keluar</th>
                    <td><input type="text" id="mdl_dateout" size="10" maxlength="10" readonly="readonly"/></td>
                </tr>
                <tr>
                    <th>Status</th>
                    <td><input type="checkbox" id="mdl_status"/></td>
                </tr>
                <tr>
                    <th>Pokok Pengupahan</th>
                    <td>
                        <table class="gridView" id="mdl_tbl">
                            <tr>
                                <th style="width:25px;"><div class="tambah"  onclick="mdldtl.prop.tambah()"></div></th>
                                <th>Keterangan</th>
                                <th>Tipe</th>
                                <th>Nilai</th>
                                <th>Sts.Pengali</th>
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

    <div id="mdldtl">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Param.Pengupahan</th>
                    <td>
                        <select id="mdldtl_wageparam"></select>
                        <label id="mdldtl_wageparam2"></label>
                    </td>
                </tr>
                <tr>
                    <th>Nilai</th>
                    <td><input id="mdldtl_nilai" type="text" size="20" maxlength="20" style="text-align:right;"/></td>
                </tr>
                <tr>
                    <th>Buka Pengali</th>
                    <td><input type="checkbox" id="mdldtl_openmulti" /></td>
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
        var cari = {
            tb_name: apl.func.get("cari_name"),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var nama = escape(cari.tb_name.value);
                cari.fl.src = "employee_list.aspx?nama=" + nama;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.create_modal("mdl",
            {
                id: 0,
                tb_nik: apl.func.get("mdl_nik"),
                tb_name: apl.func.get("mdl_name"),
                dl_position: apl.createDropdownWS("mdl_position",activities.dl_hr_position),
                tb_datein: apl.createCalender("mdl_datein"),
                tb_dateout: apl.createCalender("mdl_dateout"),
                cb_status: apl.func.get("mdl_status"),
                tbl: apl.createTableWS.init("mdl_tbl", [
                    apl.createTableWS.column("employeewageparam_id", undefined, [apl.createTableWS.attribute("class", "edit")], function (d) { mdldtl.prop.edit(d.employeewageparam_id); }, undefined, "DIV", "D"),
                    apl.createTableWS.column("wageparam_name"),
                    apl.createTableWS.column("type_name"),
                    apl.createTableWS.column("nilai", undefined, [apl.createTableWS.attribute("style", "text-align:right;")], undefined, true),
                    apl.createTableWS.column("open_multiplier_sts", undefined, [apl.createTableWS.attribute("type", "checkbox"), apl.createTableWS.attribute("disabled", "disabled"), apl.createTableWS.attribute("style", "text-align:center;")], undefined, undefined, "input", "checked")
                ]),
                

                val1: apl.createValidator("save", "mdl_nik", function () { return apl.func.emptyValueCheck(mdl.prop.tb_nik.value); }, "Salah input"),
                val2: apl.createValidator("save", "mdl_name", function () { return apl.func.emptyValueCheck(mdl.prop.tb_name.value); }, "Salah input"),
                val3: apl.createValidator("save", "mdl_position", function () { return apl.func.emptyValueCheck(mdl.prop.dl_position.value); }, "Salah input"),
                val4: apl.createValidator("save", "mdl_datein", function () { return apl.func.emptyValueCheck(mdl.prop.tb_datein.value); }, "Salah input"),

                init: function () {
                    mdl.prop.id = 0;
                    mdl.prop.tb_nik.value = "";
                    mdl.prop.tb_name.value = "";
                    mdl.prop.dl_position.value = "";
                    mdl.prop.tb_datein.value = "";
                    mdl.prop.tb_dateout.value = "";
                    mdl.prop.cb_status.checked = true;
                    mdl.prop.tbl.Hide();
                    mdl.prop.tbl.clearAllRow();

                    apl.func.validatorClear("save");
                    apl.func.hideSinkMessage();
                },
                tbl_load:function()
                {
                    activities.hr_employee_wageparam_list(mdl.prop.id, function (arr) { mdl.prop.tbl.load(arr); }, apl.func.showError, "");
                    mdl.prop.tbl.Show();
                },
                tambah: function () {
                    mdl.prop.init();
                   
                    mdl.showAdd("Tambah Data");
                        
                },
                edit: function (id) {
                    apl.func.showSinkMessage("Memuat Data");
                    mdl.prop.init();
                    mdl.prop.id = id;
                    mdl.prop.tbl_load();

                    activities.hr_employee_data(id,
                        function (data) {
                            mdl.prop.tb_nik.value = data.nik;
                            mdl.prop.tb_name.value = data.employee_name;
                            mdl.prop.dl_position.value = data.position_id;
                            mdl.prop.tb_datein.value = data.date_in;
                            mdl.prop.tb_dateout.value = data.date_out;
                            mdl.prop.cb_status.checked = data.status;

                            mdl.showEdit("Edit Data");
                        }, apl.func.showError, ""
                    );
                },
                close: function () {
                    mdl.hide();
                    cari.fl_refresh();
                    apl.func.hideSinkMessage();
                },
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menambah Data");
                    activities.hr_employee_add(mdl.prop.tb_nik.value, mdl.prop.tb_name.value, mdl.prop.tb_datein.value, mdl.prop.tb_dateout.value, mdl.prop.dl_position.value, mdl.prop.cb_status.checked, 
                        function (id) {
                            mdl.prop.edit(id);
                        }, apl.func.showError, ""
                    );
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menyimpan Data");
                    activities.hr_employee_edit(mdl.prop.id, mdl.prop.tb_nik.value, mdl.prop.tb_name.value, mdl.prop.tb_datein.value, mdl.prop.tb_dateout.value, mdl.prop.dl_position.value, mdl.prop.cb_status.checked, mdl.prop.close, apl.func.showError, "");
                }
            },
            function () {
                if (confirm("Yakin akan dihapus?")) activities.hr_employee_delete(mdl.prop.id, mdl.prop.close, apl.func.showError, "");
            }, "frm_page", "cover_content"
        );

        var mdldtl = apl.create_modal("mdldtl",
            {
                id: 0,
                dl_wageparam: apl.createDropdownWS("mdldtl_wageparam", activities.dl_hr_wageparam_vs_employee, undefined, undefined, true, function () { return " delete_sts=0 and employee_id="+mdl.prop.id; }),
                tb_nilai: apl.createNumeric("mdldtl_nilai"),
                lb_wageparam2: apl.func.get("mdldtl_wageparam2"),
                cb_openmulti:apl.func.get("mdldtl_openmulti"),

                val1: apl.createValidator("simpandtl", "mdldtl_wageparam", function () { return (apl.func.emptyValueCheck(mdldtl.prop.dl_wageparam.value) && mdldtl.prop.id==0); }, "Invalid input"),
                val2: apl.createValidator("simpandtl", "mdldtl_nilai", function () { return apl.func.emptyValueCheck(mdldtl.prop.tb_nilai.value); }, "Invalid input"),

                init:function()
                {
                    mdldtl.prop.id = 0;
                    mdldtl.prop.dl_wageparam.value = "";
                    mdldtl.prop.tb_nilai.value = "";
                    mdldtl.prop.lb_wageparam2.innerHTML = "";
                    mdldtl.prop.cb_openmulti.checked = false;

                    mdldtl.prop.dl_wageparam.Show();
                    mdldtl.prop.lb_wageparam2.Hide();

                    apl.func.validatorClear("save");
                    apl.func.hideSinkMessage();
                },
                tambah:function()
                {
                    mdldtl.prop.init();
                    mdldtl.showAdd("Tambah Data");
                },
                edit:function(id)
                {
                    mdldtl.prop.init();
                    mdldtl.prop.id = id;

                    activities.hr_employee_wageparam_data(id,
                        function (data)
                        {
                            //mdldtl.prop.dl_wageparam.setValue(data.wageparam_id);
                            mdldtl.prop.lb_wageparam2.innerHTML = data.wageparam_name;
                            mdldtl.prop.tb_nilai.setValue(data.nilai);
                            mdldtl.prop.cb_openmulti.checked = data.open_multiplier_sts;

                            mdldtl.prop.dl_wageparam.Hide();
                            mdldtl.prop.lb_wageparam2.Show();
                            mdldtl.showEdit("Edit Data");
                        },
                        apl.func.showError, ""
                    );
                },
                close:function()
                {
                    mdldtl.hide();
                    mdl.prop.tbl_load();
                }
            },
            function () {                
                if (apl.func.validatorCheck("simpandtl")) activities.hr_employee_wageparam_add(mdl.prop.id, mdldtl.prop.dl_wageparam.value, mdldtl.prop.tb_nilai.getIntValue(), mdldtl.prop.cb_openmulti.checked, mdldtl.prop.close, apl.func.showError, "");
            }, 
            function () {
                if (apl.func.validatorCheck("simpandtl")) activities.hr_employee_wageparam_edit(mdldtl.prop.id, mdldtl.prop.tb_nilai.getIntValue(), mdldtl.prop.cb_openmulti.checked, mdldtl.prop.close, apl.func.showError, "");
            }, 
            function () {
                if (confirm("Yakin akan dihapus?")) activities.hr_employee_wageparam_delete(mdldtl.prop.id, mdldtl.prop.close, apl.func.showError, "");
            }, "frm_page", "mdl"
        );

        window.addEventListener("load", function () {
            document.list_add = mdl.prop.tambah;
            document.list_edit = mdl.prop.edit;
        });
    </script>
</asp:Content>

