<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" theme="Page" %>


<script runat="server">    
    public string branch_id, disabled_sts;

    void Page_Load(object o, EventArgs e)
    {
        _test.App a = new _test.App(Request, Response);
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" src="../../js/Komponen.js"></script>
    <script type="text/javascript" src="../../js/gridjs.development.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <asp:ScriptManager runat="server" ID="sm">
        <Services>
            <asp:ServiceReference Path="../activities.asmx" />
            <asp:ServiceReference Path="~/gridslist.asmx" />
        </Services>
    </asp:ScriptManager>

    <table class="formview">
        <tr>
            <th>SN</th>
            <td>
                <input type="text" id="cari_sn" size="50" maxlength="50" value="%" /></td>
        </tr>
        <tr>
            <th>Pelanggan</th>
            <td>
                <input type="text" size="50" maxlength="50" id="cari_customer" value="%"/></td>
        </tr>
        <tr>
            <th></th>
            <td>
                <div class="buttonCari" onclick="cari.load();">Cari</div>
            </td>
        </tr>
    </table>



    <div id="mdl">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th colspan="2" style="background-color: gray; color: white; text-align: center;">Info Penawaran</th>
                </tr>
                <tr>
                    <th>No.Penawaran</th>
                    <td>
                        <label id="mdl_offer_no"></label>
                    </td>
                </tr>
                <tr>
                    <th>Sts.Penawaran</th>
                    <td>
                        <label id="mdl_service_status"></label>
                    </td>
                </tr>
                <tr>
                    <th>Sts.Konfirmasi</th>
                    <td>
                        <label id="mdl_service_status_marketing"></label>
                    </td>
                </tr>
                <tr>
                    <th>SN</th>
                    <td><label id="mdl_sn"></label></td>
                </tr>
                <tr>
                    <th>Device</th>
                    <td><label id="mdl_device"></label></td>
                </tr>
                <tr>
                    <th>Teknisi</th>
                    <td><label id="mdl_teknisi"></label></td>
                </tr>
                <tr>
                    <th colspan="2" style="background-color: gray; color: white; text-align: center;">Info Komponen</th>
                </tr>
                <tr>
                    <th>Komponen</th>
                    <td><label id="mdl_component"></label></td>
                </tr>
                <tr>
                    <th>Nilai</th>
                    <td><input type="text" size="15" maxlength="15" style="text-align: right;" id="mdl_cost" /></td>
                </tr>
                <tr>
                    <th>Total</th>
                    <td><label id="mdl_total"></label></td>
                </tr>
                <tr>
                    <th>Sts.Purchase </th>
                    <td><input type="checkbox" id="mdl_purchasedone" /></td>
                </tr>
                <tr>
                    <th>Nm.Vendor</th>
                    <td><input type="text" id="mdl_vendor" size="100" disabled="disabled"/></td>
                </tr>
            </table>

            <div style="padding-top: 5px;" class="button_panel">
                <input type="button" value="Save" />
                <input type="button" value="Close" />
            </div>
        </fieldset>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        let g = new gridjs.Grid({
            columns: [
                { id: 'service_device_id', name: '#' },
                { id: 'sn', name: 'Serial Number' },
                { id: 'device', name: 'Device' },
                { id: 'customer_name', name: 'Customer' },
                { id: 'component', name: 'Komponen' },
                { id: 'total', name: 'Total' }
            ],
            sort: true,
            multiColumn: false,
            pagination: {
                enabled: true,
                limit: 10,

            },
            data: []

        }).render(document.getElementById("grid_list"));

        function load_grid() {
            var sn = escape("%" + cari.tb_sn.value);
            var name = escape("%" + cari.tb_customer.value);
            var _url = '@gridlist.ashx?kode=service_device_component&sn=' + sn + '&custname=' + name;
            //alert(_url);

            g.updateConfig({
                server: {
                    url: _url,

                    then: function (data) {
                        //alert(JSON.stringify(data));
                        return data.map(function (d) {
                            return [
                                gridjs.html('<div class="edit" onclick="mdl.edit(' + d.service_device_id + ',' + d.device_id +','+d.service_id+ ')"></div>'),
                                d.sn, d.device, d.customer_name, d.component,d.total]
                        })
                    },

                    total: function (data) { return data.count; }
                }
            }).forceRender();
            //alert("refresh");
        }

        var cari = {
            tb_sn: apl.func.get("cari_sn"),
            tb_customer: apl.func.get("cari_customer"),
            load: function () {
                load_grid();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                service_device_id: 0,
                device_id: 0,
                service_id: 0,
                

                lb_offerno: apl.func.get("mdl_offer_no"),
                lb_servicestatus: apl.func.get("mdl_service_status"),
                lb_servicestatusmarketing: apl.func.get("mdl_service_status_marketing"),
                lb_sn: apl.func.get("mdl_sn"),
                lb_device: apl.func.get("mdl_device"),
                lb_teknisi: apl.func.get("mdl_teknisi"),

                lb_component: apl.func.get("mdl_component"),
                tb_nilai: apl.createNumeric("mdl_cost", true),
                lb_total: apl.func.get("mdl_total"),
                cb_purchasedone: apl.func.get("mdl_purchasedone"),
                tb_vendor:apl.func.get("mdl_vendor"),

                val01: apl.createValidator("save", "mdl_cost", function () { return apl.func.emptyValueCheck(mdl.tb_nilai.value) }, "Salah input"),

                edit: function (service_device_id, device_id, service_id) {
                    apl.func.showSinkMessage("Memuat Data");
                    activities.tec_service_device_data(service_device_id,
                        function (data) {
                            mdl.service_device_id = service_device_id;
                            mdl.device_id = device_id;
                            mdl.service_id = service_id;


                            mdl.lb_offerno.innerHTML = data.offer_no;
                            mdl.lb_servicestatus.innerHTML = data.service_status;
                            mdl.lb_servicestatusmarketing.innerHTML = data.service_status_marketing;

                            mdl.lb_sn.innerHTML = data.sn;
                            mdl.lb_device.innerHTML = data.device;
                            mdl.lb_teknisi.innerHTML = data.technician_name;

                            activities.tec_service_device_component_data(service_device_id, device_id,
                                function (d) {
                                    mdl.lb_component.innerHTML = d.device;
                                    mdl.tb_nilai.setValue(d.cost);
                                    mdl.lb_total.innerHTML = d.total;
                                    mdl.tb_vendor.value = d.vendorname;

                                    mdl.cb_purchasedone.checked = data.purchasedone_sts;
                                }, apl.func.showError, ""
                            );

                            mdl.showEdit("Edit");
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );

                },
                refresh: function () {
                    apl.func.hideSinkMessage();
                    mdl.hide();
                    load_grid();
                },
            },
            undefined,
            function ()
            {
                if(apl.func.validatorCheck("save"))
                {
                    apl.func.showSinkMessage("Menyimpan");
                    activities.tec_service_device_component_save(mdl.service_device_id, mdl.device_id, mdl.tb_nilai.getIntValue(), mdl.lb_total.innerHTML, true, mdl.cb_purchasedone.checked,mdl.tb_vendor.value, mdl.refresh, apl.func.showError, "");
                }
            },
            undefined,
            "main_panel",
            //"frm_page",
            "second_panel"
            //"cover_content"
        );
    </script>
</asp:Content>

