<%@ Page Title="" Language="C#" MasterPageFile="~/page.master"  Theme="Page"%>

<script runat="server">
public string g_marketing_id = "", branch_disabled = "", branch_id, html_all_access_disabled = "";    
    public Boolean all_access_sts = false;
    public _test.App a;

    void Page_Load(object o, EventArgs e)
    {
        a = new _test.App(Request, Response);
        string strSQL = "select marketing_id,all_access from v_act_marketing where user_id='" + a.cookieUserIDValue + "' or assistant_user_id='" + a.cookieUserIDValue + "'";

        _test._DBcon c = new _test._DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            g_marketing_id = row["marketing_id"].ToString();
            all_access_sts=Convert.ToBoolean(row["all_access"]);
        }
        g_marketing_id = (g_marketing_id == "") ? "semua" : g_marketing_id;
        branch_disabled = (a.BranchID == "") ? "" : "disabled";
        branch_id = (a.BranchID == "") ? "%" : a.BranchID;
        html_all_access_disabled = (all_access_sts == true) ? "" : "disabled='disabled'";
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
        </Services>
    </asp:ScriptManager>  

    <table class="formview">
        <tr>
            <th>Pelanggan</th>
            <td><input type="text" id="cari_customer" size="35" value="<%--POP Net Indonesia, PT--%>%"/></td>            
        </tr>        
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.load();">Cari</div></td>
        </tr>
    </table>

    <div class="modal" id="mdl">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Asal Data</th>
                    <td><label id="mdl_source"></label></td>
                </tr>
                <tr>
                    <th>Nama</th>
                    <td><span id="mdl_name"></span></td>
                </tr>
                <tr>
                    <th>Alamat #1</th>
                    <td><span id="mdl_location"></span></td>
                </tr>
                <tr>
                    <th>Alamat #2</th>
                    <td><textarea id="mdl_address" readonly="readonly"></textarea></td>
                </tr>
                <tr>
                    <th>Telepon</th>
                    <td><span id="mdl_phone"></span></td>
                </tr>
                <tr>
                    <th>Fax</th>
                    <td><span id="mdl_fax"></span></td>
                </tr>
                <tr>
                    <th>NPWP</th>
                    <td><span id="mdl_npwp"></span></td>
                </tr>
                <tr>
                    <th>Marketing</th>
                    <td><span id="mdl_marketing"></span></td>
                </tr>
                <tr>
                    <th>Kontak</th>
                    <td>
                        <table class="gridView" id="mdl_tbl" style="min-width:800px">
                            <tr>                                
                                <th>Nama</th>
                                <th style="width:200px">Telp.</th>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <th>Status</th>
                    <td><label id="mdl_status"></label></td>
                </tr>
            </table>
            <div class="button_panel">               
                <input type="button" value="Add" /> 
                <input type="button" value="Close" />
            </div>
        </fieldset>
    </div>

    <label id="info" style="display:none;"></label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var new_marketing_id = '<%= g_marketing_id %>';

        let g = new gridjs.Grid({
            columns: [
                { id: 'customer_id', name: '#' },
                { id: 'customer_name', name: 'Pelanggan' },
                { id: 'customer_phone', name: 'Phone Number' },
                { id: 'marketing_id', name: 'Marketing' }
            ],
            sort: true,
            multiColumn: false,
            pagination: {
                enabled: true,
                limit: 10,

            },
            data: []

        }).render(document.getElementById("grid_list"));

        function httpRequest(url, funcRetrieve)
        {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", url, true);

            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    var data = JSON.parse(xhr.responseText);
                    funcRetrieve(data);
                }
            };
            xhr.send();
        }

        var cari = {
            tb_customer: apl.func.get("cari_customer"),
            load_customer_list:function(arr1)
            {
                //alert(JSON.stringify(arr1));
                activities.croscheckDataCustumerAPI(arr1,
                    function (arr2) {
                        //alert(JSON.stringify(arr2));

                        rows = new Array();

                        for (var i = 0; i < arr2.length; i++)
                        {
                            d = arr2[i];
                            rows.push([gridjs.html('<div class="edit" onclick="cari.edit(' + d.customer_id + ')"></div>'), d.customer_name, d.customer_phone, d.marketing_id]);
                        }
                        //alert(JSON.stringify(rows));

                        g.updateConfig({
                            data: rows
                        }).forceRender();

                        apl.func.hideSinkMessage();
                    },
                    apl.func.showError
                );
            },
            load:function()
            {
                activities.appParameter_nilai("urlapi",
                    function (url) {
                        mdl.lb_source.innerHTML = url;

                        var name = escape(cari.tb_customer.value);
                        var _url = url + '/@gridcustomer.ashx?code=1&name=' + name;
                        apl.func.showSinkMessage("Load Data");
                        httpRequest(_url, cari.load_customer_list);


                        //alert(_url);
                        //apl.func.get("info").innerHTML = _url;
                        /*
                        activities.croscheckDataCustumerAPI(data,
                            function (arr) {
                                data = arr;
                            },
                            apl.func.showError
                        );

                        alert(JSON.stringify(data));
                        */
                        

                        //g.updateConfig({
                            
                        //    data: [
                        //        [gridjs.html('<div class="edit" onclick="cari.edit(1)"></div>'), "yogi", "0215656", "marketing1"]
                        //    ],
                            
                            
                        //    server: {
                        //        url: _url,

                        //        then: function (data) {

                                    
                        //            alert(JSON.stringify(data));
                        //            return data.map(function (d) {
                        //                return [
                        //                    gridjs.html('<div class="edit" onclick="cari.edit(' + d.customer_id + ')"></div>'),
                        //                    d.customer_name, d.customer_phone, d.marketing_id]
                        //            })
                        //        },
                        //        handle:function(res)
                        //        {
                        //            if (res.ok) return res.json();
                        //        },
                        //        total: function (data) { return data.count; }

                        //    }

                        //}).forceRender();
                    },
                    apl.func.showError, ""
                );
            },
            edit:function(id)
            {
                apl.func.showSinkMessage("Load Data");
                activities.appParameter_nilai("urlapi",
                    function (url) {
                        var _url = url + '/@gridcustomer.ashx?code=2&custid=' + id;
                        apl.func.get("info").innerHTML = _url;
                        httpRequest(_url,mdl.edit);
                    },
                    apl.func.showError, ""
                );                
            }
        }

        var mdl = apl.createModal("mdl",
            {
                data:{},
                lb_source:apl.func.get("mdl_source"),
                lb_name: apl.func.get("mdl_name"),
                lb_address1: apl.func.get("mdl_location"),
                tb_address2: apl.func.get("mdl_address"),
                lb_phone: apl.func.get("mdl_phone"),
                lb_fax: apl.func.get("mdl_fax"),
                lb_npwp: apl.func.get("mdl_npwp"),
                lb_marketing: apl.func.get("mdl_marketing"),
                tbl: apl.createTableWS.init("mdl_tbl",
                        [
                            apl.createTableWS.column("contact_name"),
                            apl.createTableWS.column("contact_phone")
                        ]
                ),
                lb_status: apl.func.get("mdl_status"),

                edit: function (data) {
                    mdl.data = data;
                    mdl.data.customer_address_location_id = 0;
                    //alert(JSON.stringify(data));
                    mdl.lb_name.innerHTML = data.customer_name;
                    mdl.lb_address1.innerHTML = data.customer_address_location;
                    mdl.tb_address2.value = data.customer_address;
                    mdl.lb_phone.innerHTML = data.customer_phone;
                    mdl.lb_fax.innerHTML = data.customer_fax;
                    mdl.lb_npwp.innerHTML = data.npwp;
                    mdl.lb_marketing.innerHTML = data.marketing_id;
                    mdl.tbl.load(data.arr_contact);
                    apl.func.hideSinkMessage();

                    activities.act_customer_altcode_check(data.alt_code,
                        function (status) {
                            mdl.lb_status.innerHTML = status;
                            if (status == "Unexists") mdl.showAdd("Customer"); else mdl.showEdit("Customer");
                        },
                        apl.func.showError, ""
                    );
                    
                    
                }
            },
            function () {
                if(confirm("Anda yakin akan ditambahkan?"))
                {
                    apl.func.showSinkMessage("Save data");
                    activities.act_customer_inc_contact(mdl.data,new_marketing_id,
                        function (data) {
                            //alert(JSON.stringify(data));
                            mdl.hide();
                            apl.func.hideSinkMessage();
                        },
                        apl.func.showError, ""
                    );
                    //alert("data telah ditambahkan");
                }
            }
            , undefined, undefined, "main_panel", "second_panel"
        );
    </script>
</asp:Content>

