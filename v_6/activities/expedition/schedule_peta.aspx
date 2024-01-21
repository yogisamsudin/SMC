<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page" %>

<%@ Register Src="~/activities/map/wuc_map.ascx" TagPrefix="uc1" TagName="wuc_map" %>


<script runat="server">
    public _test.App a;

    void Page_Load(object o, EventArgs e)
    {
        a = new _test.App(Request, Response);
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" src="../../js/Komponen.js"></script>   
    <style>
        .info div
        {
            transition: all 1s Ease;
            visibility:hidden;
            opacity:0;
            position:relative;
        }
        .info:hover div
        {
            opacity:1;
            visibility:visible;
        }
    </style> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <asp:ScriptManager runat="server" ID="sm">
        <Services>
            <asp:ServiceReference Path="../activities.asmx" />
        </Services>
    </asp:ScriptManager>  

    <table class="formview">
        <tr>
            <th style="width:100px;">Filter</th>
            <td>
                <select onclick="cari.select(this);" id="cari_select">
                    <option value="1">Tanggal</option>
                    <option value="2">Nomor</option>
                </select>
            </td>
        </tr>    
        <tr id="cari_view1">
            <th style="width:100px;">Tanggal</th>
            <td>
                <input type="text" id="cari_date_list" size="10" maxlength="10" style="float:left;" value="<%= a.cookieApplicationDateValue %>"/>
                <a style="padding-left:5px; cursor:pointer;font-weight:bold;text-decoration:underline;" onclick="mdl.set_automatic()">Set Geotag otomatis</a>
            </td> 
        </tr>
        <tr id="cari_view3" style="display:none;">
            <th>Nomor</th>
            <td><input type="text" id="cari_number"/></td>
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.load();">Cari</div></td>
        </tr>        
    </table>
    
    <iframe class="frameList" id="fr_list"></iframe> 

    <div id="mdl" class="modal">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Customer</th>
                    <td><span id="mdl_customer"></span></td>
                </tr>
                <tr>
                    <th>Alamat #1</th>
                    <td><span id="mdl_address_1"></span></td>
                </tr>
                <tr>
                    <th>Alamat #2</th>
                    <td><span id="mdl_address_2"></span></td>
                </tr>
                <tr>
                    <th>Peta</th>
                    <td>
                        <uc1:wuc_map runat="server" ID="map" />
                    </td>
                </tr>
            </table>
            <div class="button_panel">
                <input type="button" value="Save"/>
                <input type="button" value="Cancel"/>
            </div>
        </fieldset>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var cari = {            
            dl_date: apl.createCalender("cari_date_list"),
            fl: apl.func.get("fr_list"),            
            tb_number: apl.createNumeric("cari_number", false),
            dl_select: apl.func.get("cari_select"),
            v1: apl.func.get("cari_view1"),            
            v3: apl.func.get("cari_view3"),
            select: function (o) {
                var nilai = "1";
                if (o) {
                    nilai = o.value;
                }

                switch (nilai) {
                    case "1":
                        cari.v1.Show();                        
                        cari.v3.Hide();
                        break;
                    case "2":
                        cari.v1.Hide();                        
                        cari.v3.Show();
                        break;
                }

            },
            load: function () {
                var tanggal = cari.dl_date.value;                
                var schedule_id = cari.tb_number.getIntValue();                
                cari.fl.src = "schedule_peta_list.aspx?date=" + escape(tanggal) + "&schedule_id=" + schedule_id + "&type=" + cari.dl_select.value;
            },
            fl_refresh: function () {
                var last_date = cari.dl_date.value;
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                id: 0,
                category_id: '1',
                location_id: 0,
                lb_customer: apl.func.get("mdl_customer"),
                lb_address1: apl.func.get("mdl_address_1"),
                lb_address2: apl.func.get("mdl_address_2"),
                kosongkan:function()
                {
                    mdl.lb_customer.innerHTML = "";
                    mdl.lb_address1.innerHTML = "";
                    mdl.lb_address1.innerHTML = "";
                },
                edit:function(category_id, id)
                {
                    mdl.kosongkan();
                    if (category_id == "1") {
                        activities.act_service_data(id,
                            function (data) {
                                mdl.id = id;
                                mdl.category_id = '1';
                                mdl.location_id = data.pickup_address_location_id;
                                mdl.lb_customer.innerHTML = data.customer_name;
                                mdl.lb_address1.innerHTML = data.pickup_address_location;
                                mdl.lb_address2.innerHTML = data.pickup_address;
                                mdl.showEdit("Edit - Peta");

                                document.map.open(data.latitude, data.longitude);

                            }, apl.func.showError, ""
                        );
                    } else {
                        activities.act_sales_data(id,
                            function(data)
                            {
                                mdl.id = id;
                                mdl.category_id = '2';
                                mdl.location_id = data.delivery_address_location_id;
                                mdl.lb_customer.innerHTML = data.customer_name;
                                mdl.lb_address1.innerHTML = data.delivery_address_location;
                                mdl.lb_address2.innerHTML = data.delivery_address;
                                mdl.showEdit("Edit - Peta");

                                document.map.open(data.latitude, data.longitude);
                            }, apl.func.showError, "");
                    }                    
                },
                set_automatic:function()
                {
                    apl.func.showSinkMessage("Menyimpan");
                    activities.exp_schedule_peta_set_geotag_automatic(cari.dl_date.value,
                        function () {
                            cari.load();
                            cari.fl_refresh();
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, "");
                }
            },
            undefined, 
            function ()
            {
                apl.func.showSinkMessage("Menyimpan");
                activities.exp_schedule_peta_save(mdl.category_id, mdl.id, mdl.location_id, mdl.lb_address2.innerHTML, document.map.latitude, document.map.longitude,
                    function () {
                        mdl.hide();
                        cari.fl_refresh();
                        apl.func.hideSinkMessage();
                    }, apl.func.showError, "");
            }, undefined, "frm_page", "cover_content"
        );
        

        document.list_edit = mdl.edit;

        window.addEventListener("load", function () { cari.select(); });
    </script>
</asp:Content>

