<%@ Control Language="C#" ClassName="wuc_service_device_update" %>

<script runat="server">
    public string parent_id { set; get; }
    public string cover_id { set; get; }
    public string function_parent_refresh{ set; get; }    

    void Page_Load(object o, EventArgs e)
    {
        ClientIDMode = System.Web.UI.ClientIDMode.Static;
        function_parent_refresh = (function_parent_refresh == null) ? "" : function_parent_refresh;
    }
</script>
<div id="<%= ClientID %>" class="modal">
    <fieldset>
        <legend></legend>
            
        <table class="formview">
            <tr>
                <th>Tanggal</th>
                <td><input type="text" id="<%= ClientID %>_date" size="10" maxlength="10"/></td>
            </tr>
            <tr>
                <th>SN</th>
                <td>
                    <input type="text" id="<%= ClientID %>_sn" size="50" maxlength="50" style="float:left;"/>
                    <div class="info" title="Info sn sebelumnya" id="<%= ClientID %>_sn_info" style="float:left;"></div>
                </td>
            </tr>
            <tr>
                <th>Device</th>
                <td>
                    <input type="text" id="<%= ClientID %>_device" />                    
                </td>
            </tr>
            <tr>
                <th>Nama User</th>
                <td><input type="text" size="50" maxlength="50" id="<%= ClientID %>_user"/></td>
            </tr>
            <tr>
                <th>Catatan Customer</th>
                <td><textarea id="<%= ClientID %>_note"></textarea></td>
            </tr>
            <tr>
                <th>Garansi Sts.</th>
                <td>
                    <input type="checkbox" id="<%= ClientID %>_guarantee"/>
                    <label style="color:red;" id="<%= ClientID %>_guarantee_info">! Barang garansi</label>
                </td>
            </tr>
            <tr>
                <th>Kelengkapan</th>
                <td>
                    <table class="gridView" id="<%= ClientID %>_tbl">
                        <tr>
                            <th style="width:25px;"></th>
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
            <input type="button" value="Close"/>
        </div>
    </fieldset>
</div>


<script type="text/javascript">
    window.addEventListener("load",
        function () {
            var mdl = document["<%= ClientID %>"] = apl.createModal("<%= ClientID %>",
            {
                sts_userdevicemandatory: false,
                service_device_id: 0,
                service_id: 0,
                device_register_id: 0,
                device_type_id: 0,
                tb_date: apl.createCalender("<%= ClientID %>_date"),
                tb_sn: (function () {
                    var _o = apl.createCharFiltering("<%= ClientID %>_sn");

                    _o.onkeyup = function () {
                        var kata = this.value;
                        this.value = kata.toUpperCase();
                    }

                    _o.addEventListener("blur", function () {
                        var sn = _o.value;                        

                        apl.func.showSinkMessage("Mencari Data");
                        activities.tec_device_register_data_by_sn(sn,
                            function (data) {
                                mdl.device_register_id = data.device_register_id;
                                mdl.ac_device.set_value(data.device_id, data.device);
                                //mdl.ac_device.input.disabled = true;
                                apl.func.hideSinkMessage();

                                if (data.device_register_id == 0)
                                {
                                    mdl.ac_device.set_value("", "");
                                    //mdl.ac_device.input.disabled = false;
                                }
                                
                            }, apl.func.showError, ""
                        );
                    });
                    return _o;
                })(),                    
                dv_sn: apl.func.get("<%= ClientID %>_sn_info"),
                ac_device: apl.create_auto_complete_text("<%= ClientID %>_device", activities.ac_device),
                tb_user: apl.func.get("<%= ClientID %>_user"),
                tb_note: apl.func.get("<%= ClientID %>_note"),
                cb_guarantee: apl.func.get("<%= ClientID %>_guarantee"),
                lb_guarantee: apl.func.get("<%= ClientID %>_guarantee_info"),
                val_user: apl.createValidator("<%= ClientID %>_save", "<%= ClientID %>_user", function () { return (apl.func.emptyValueCheck(mdl.tb_user.value) && mdl.sts_userdevicemandatory); }, "Salah input"),
                val_date: apl.createValidator("<%= ClientID %>_save", "<%= ClientID %>_date", function () { return apl.func.emptyValueCheck(mdl.tb_date.value); }, "Salah input"),
                val_sn: apl.createValidator("<%= ClientID %>_save", "<%= ClientID %>_sn", function () { return apl.func.emptyValueCheck(mdl.tb_sn.value); }, "Salah input"),
                val_device: apl.createValidator("<%= ClientID %>_save", "<%= ClientID %>_device", function () { return apl.func.emptyValueCheck(mdl.ac_device.id); }, "Salah input"),
                val_note: apl.createValidator("<%= ClientID %>_save", "<%= ClientID %>_note", function () { return apl.func.emptyValueCheck(mdl.tb_sn.value); }, "Salah input"),
                tbl: apl.createTableWS.init("<%= ClientID %>_tbl",
                    [
                        apl.createTableWS.column("status", undefined, [apl.createTableWS.attribute("type", "checkbox")],
                            function (data)
                            {
                                activities.tec_service_device_trimming_add(data.service_device_id, data.device_type_trimming_id, this.checked, undefined, apl.func.showError, "");
                            },
                            undefined, "input", "checked", function (elm, datum) { }),
                        apl.createTableWS.column("trimming_name")
                    ]
                ),
                tbl_load: function () {
                    activities.xml_tec_service_device_trimming_list(mdl.service_device_id,mdl.device_type_id,
                        function (arrData) {
                            mdl.tbl.load(arrData);
                        }, apl.func.showError, ""
                    );
                },
                kosongkan:function()
                {
                    mdl.service_device_id = 0;
                    mdl.service_id = 0;
                    mdl.device_register_id = 0;
                    mdl.device_type_id = 0;
                    mdl.tb_date.value = "";
                    mdl.tb_sn.value = "";
                    mdl.tb_user.value = "";
                    mdl.ac_device.set_value("", "");
                    //mdl.ac_device.input.disabled = true;
                    mdl.tb_note.value = "";
                    mdl.cb_guarantee.checked = false;
                    mdl.lb_guarantee.Hide();
                    mdl.sts_userdevicemandatory = false;
                    mdl.dv_sn.Hide();
                    mdl.tbl.Hide();
                    apl.func.validatorClear("<%= ClientID %>_save");
                    apl.func.hideSinkMessage();
                },
                tambah: function (id, date, user_device_mandatory)
                {
                    mdl.kosongkan();
                    mdl.tb_date.value = date;
                    mdl.service_id = id;
                    mdl.sts_userdevicemandatory = user_device_mandatory;
                    mdl.showAdd("SN - Tambah");
                },
                edit: function (id, user_device_mandatory) {
                    apl.func.showSinkMessage("Memuat Data");
                    mdl.kosongkan();
                    mdl.sts_userdevicemandatory = user_device_mandatory;
                    activities.tec_service_device_data(id,
                        function (data)
                        {
                            mdl.service_device_id = id;
                            mdl.service_id = data.service_id;
                            mdl.device_register_id = data.device_register_id;
                            mdl.device_type_id = data.device_type_id;
                            mdl.tb_date.value = data.date_in;
                            mdl.tb_sn.value = data.sn;
                            mdl.tb_user.value = data.user_name;
                            mdl.ac_device.set_value(data.device_id, data.device);                            
                            mdl.tb_note.value = data.customer_note;
                            mdl.cb_guarantee.checked = data.guarantee_sts;
                            //mdl.sts_userdevicemandatory = data.user_device_mandatory;
                            mdl.dv_sn.Hide();
                            mdl.tbl_load();
                            mdl.tbl.Show();
                            mdl.showEdit("SN - Edit");
                            if (data.service_device_sts_id == '1')
                            {
                                mdl.btnSave.show();
                                mdl.btnDelete.show();
                            } else {
                                mdl.btnSave.hide();
                                mdl.btnDelete.hide();
                            }
                            
                            apl.func.hideSinkMessage();

                            activities.tec_service_device_guarantee_check(mdl.tb_sn.value, mdl.tb_date.value,
                                function (status) {
                                    if (status) mdl.lb_guarantee.Show();
                                }, apl.func.showError, ""
                            );
                        }, apl.func.showError, ""
                    );                    
                },
                refresh_child:function()
                {
                    mdl.hide();
                    apl.func.hideSinkMessage();
                },
                refresh:function()
                {
                    mdl.refresh_child();
                    <%= function_parent_refresh %>
                }
            },
            function ()
            {
                if(apl.func.validatorCheck("<%= ClientID %>_save"))
                {
                    apl.func.showSinkMessage("Menyimpan");
                    activities.tec_service_device_register_add(mdl.service_id, mdl.tb_date.value, mdl.tb_sn.value, mdl.ac_device.id, mdl.tb_note.value, mdl.cb_guarantee.checked, mdl.tb_user.value,
                        function (id) {
                            mdl.edit(id);
                        }, apl.func.showError, ""
                    );
                }
            },
            function () {
                if (apl.func.validatorCheck("<%= ClientID %>_save")) {
                    apl.func.showSinkMessage("Menyimpan");
                    activities.tec_service_device_register_edit(mdl.service_device_id, mdl.tb_date.value, mdl.device_register_id, mdl.tb_sn.value, mdl.ac_device.id, mdl.tb_note.value, mdl.cb_guarantee.checked, mdl.tb_user.value,mdl.refresh, apl.func.showError, "");
                }
            },
            function ()
            {
                if(confirm("Yakin akan dihapus?"))
                {
                    apl.func.showSinkMessage("Menghapus");
                    activities.tec_service_device_register_delete(mdl.service_device_id, mdl.refresh, apl.func.showError, "");
                }
            }, "<%= parent_id%>", "<%= cover_id %>"
        );
    });
</script>