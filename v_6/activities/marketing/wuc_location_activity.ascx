<%@ Control Language="C#" ClassName="wuc_location_activity" %>

<script runat="server">
    public string parent_id { set; get; }
    public string cover_id { set; get; }
    public string selected_function { set; get; }

    void Page_Load(object o, EventArgs e)
    {
        ClientIDMode = System.Web.UI.ClientIDMode.Static;
        //parent_id = "frm_page";
        //cover_id = "mdl";
    }    
    /*
     * sintax    
     * document."id name".open(select_option, customer_id)
     * if select option = 1, put customer id to it
    */
</script>


<div id="<%= ClientID %>_" class="modal">
    <fieldset>
        <legend>Customer</legend>
        <div id="<%= ClientID %>_panel1">
            <table class="gridView" id="<%= ClientID %>_panel1_tbl">
                <tr>
                    <th style="width:25px;"></th>
                    <th>Alamat #1</th>
                    <th>Alamat #2</th>
                </tr>
            </table>
        </div>
        <div id="<%= ClientID %>_panel2">
            <table>
                <tr>
                    <td style="vertical-align:top;">
                        <table class="formView" style="float:left;">
                            <tr>
                                <th style="vertical-align:top;">Alamat</th>
                                <td><textarea id="<%= ClientID %>_panel2_address"></textarea></td>
                            </tr>
                            <tr>
                                <th style="vertical-align:top;">Jarak</th>
                                <td><input type="text" id="<%= ClientID %>_panel2_distance" size="3" maxlength="3" style="text-align:right;"></input></td>
                            </tr>
                        </table>
                    </td>
                    <td style="vertical-align:top;">
                        <a style="text-decoration:underline;font-weight:bold;cursor:pointer;" id="<%= ClientID %>_panel2_link">Cek</a>
                    </td>
                    <td>
                        <div style="height:200px">
                            <table style="float:left;min-width:200px;" class="gridView" id="<%= ClientID %>_panel2_tbl">
                                <tr>
                                    <th style="width:25px;"></th>
                                    <th>Address</th>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>                        
        </div>
        <br />
        <div style="padding-top:5px;" class="button_panel">
            <input type="button" value="Add" />
            <input type="button" value="Close"/>
        </div>
    </fieldset>    
</div>


<script type="text/javascript">
    window.addEventListener("load", function () {
        var o = document["<%= ClientID %>"] = apl.createModal("<%= ClientID %>_",
            {
                panel1: apl.func.get("<%= ClientID %>_panel1"),
                panel2: apl.func.get("<%= ClientID %>_panel2"),
                tb_panel2_address: apl.func.get("<%= ClientID %>_panel2_address"),
                tb_panel2_distance: apl.createNumeric("<%= ClientID %>_panel2_distance",true),
                val_panel2_address: apl.createValidator("<%= ClientID %>_panel2_save", "<%= ClientID %>_panel2_address", function () { return apl.func.emptyValueCheck(o.tb_panel2_address.value); }, "Salah input"),                
                val_panel2_distance: apl.createValidator("<%= ClientID %>_panel2_save", "<%= ClientID %>_panel2_distance", function () { return apl.func.emptyValueCheck(o.tb_panel2_distance.value); }, "Salah input"),                
                lb_check: (function () {
                    var _o = apl.func.get("<%= ClientID %>_panel2_link");
                    _o.onclick = function () { o.tbl2_load(); }
                    return _o;
                })(),
                tbl1: apl.createTableWS.init("<%= ClientID %>_panel1_tbl",
                    [
                        apl.createTableWS.column("", undefined, [apl.func.createAttribute("class", "select")],
                            function (data)
                            {
                                <%= selected_function %>(data.location_id, data.location_address,data.customer_address, data.latitude, data.longitude);
                                o.hide();
                            }),
                        apl.createTableWS.column("location_address"),
                        apl.createTableWS.column("customer_address")
                    ]
                ),
                tbl2: apl.createTableWS.init("<%= ClientID %>_panel2_tbl",
                    [
                        apl.createTableWS.column("", undefined, [apl.func.createAttribute("class", "select")],
                            function (data) {
                                <%= selected_function %>(data.location_id, data.location_address, "", "", "");
                                o.hide();
                            }),
                        apl.createTableWS.column("location_address")
                    ]
                ),
                tbl1_load: function (id) {
                    activities.xml_act_customer_location_list(id,
                        function (arrData) {
                            o.tbl1.load(arrData);
                        }, apl.func.showError, ""
                    );
                },
                tbl2_load: function () {
                    if (apl.func.emptyValueCheck(o.tb_panel2_address.value) == false) {
                        activities.xml_exp_location_check_address_list(o.tb_panel2_address.value,
                            function (arrData) {
                                o.tbl2.load(arrData);
                            }, apl.func.showError, ""
                        );
                    }
                },
                open: function (select_option, id) {                    
                    switch(select_option)
                    {
                        case 1:
                            o.panel1.Show();
                            o.panel2.Hide();
                            o.tbl1_load(id);//filter by customer id
                            o.showEdit("Lokasi- Pilih");
                            break;
                        case 2:
                            o.panel1.Hide();
                            o.panel2.Show();
                            o.tb_panel2_address.value = "";
                            o.tb_panel2_distance.value = "0";
                            o.tbl2.clearAllRow();
                            apl.func.validatorClear("<%= ClientID %>_panel2_save");
                            o.showAdd("Lokasi- Tambah");
                            break;
                    }
                    
                }                
            }, 
            function ()
            {
                if (apl.func.validatorCheck("<%= ClientID %>_panel2_save"))
                {
                    activities.exp_location_add(o.tb_panel2_address.value, o.tb_panel2_distance.value,
                        function (value) {
                            <%= selected_function %>(value, o.tb_panel2_address.value, "","","");
                            o.hide();
                        }, apl.func.showError, ""
                    );
                }
            }, undefined, undefined, "<%= parent_id %>", "<%= cover_id %>", ""
        );
    });

</script>


