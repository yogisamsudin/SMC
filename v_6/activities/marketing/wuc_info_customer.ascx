<%@ Control Language="C#" ClassName="wuc_info_customer" %>

<script runat="server">
    public string parent_id { set; get; }
    public string cover_id { set; get; }

    void Page_Load(object o, EventArgs e)
    {
        ClientIDMode = System.Web.UI.ClientIDMode.Static;
        //parent_id = "frm_page";
        //cover_id = "mdl";
    }
</script>

<div id="<%= ClientID %>_" class="modal">
    <fieldset>
        <legend>Customer</legend>
        <table class="formview">
            <tr>
                <th style="width:100px;">Cabang</th>
                <td><label id="<%= ClientID %>_branch"></label></td>                
            </tr>
            <tr>
                <th style="width:100px;">Nama</th>
                <td><label id="<%= ClientID %>_name"></label></td>                
            </tr>
            <tr>
                <th style="width:100px;">Alamat #1</th>
                <td><textarea id="<%= ClientID %>_address" readonly="readonly"></textarea></td>
            </tr>
            <tr>
                <th style="width:100px;">Alamat #2</th>
                <td><label id="<%= ClientID %>_address2" ></label></td>
            </tr>
            <tr>
                <th style="width:100px;">Telepon</th>
                <td><label id="<%= ClientID %>_phone" ></label></td>
            </tr>
            <tr>
                <th style="width:100px;">Fax</th>
                <td><label id="<%= ClientID %>_fax"></label></td>
            </tr>
            <tr>
                <th style="width:100px;">Email</th>
                <td><label id="<%= ClientID %>_email"></label></td>
            </tr>
            <tr>
                <th style="width:100px;">NPWP</th>
                <td><label id="<%= ClientID %>_npwp"></label></td>
            </tr>
            <tr>
                <th style="width:100px;">Jarak Tempuh</th>
                <td><label id="<%= ClientID %>_distance"></label></td>
            </tr>
            <tr>
                <th style="width:100px;">Marketing</th>
                <td><label id="<%= ClientID %>_marketing" ></label></td>
            </tr>
            <tr>
                <th>Kontak</th>
                <td>
                    <table id="<%= ClientID %>_tbl" class="gridView">
                        <tr>
                            <th>Name</th>
                            <th>Phone</th>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <div style="padding-top:5px;" class="button_panel">
            <input type="button" value="Close"/>
        </div>
    </fieldset>    
</div>

<script type="text/javascript">
    window.addEventListener("load", function () {

    var o = document["<%= ClientID %>"] = apl.createModal("<%= ClientID %>_",

            {
                lb_branch: apl.func.get("<%= ClientID %>_branch"),
                lb_name: apl.func.get("<%= ClientID %>_name"),
                tb_address: apl.func.get("<%= ClientID %>_address"),
                lb_address2: apl.func.get("<%= ClientID %>_address2"),
                lb_phone: apl.func.get("<%= ClientID %>_phone", false),
                lb_fax: apl.func.get("<%= ClientID %>_fax", false),
                lb_email: apl.func.get("<%= ClientID %>_email"),
                lb_npwp: apl.func.get("<%= ClientID %>_npwp"),
                lb_distance: apl.func.get("<%= ClientID %>_distance", true),
                lb_marketing: apl.func.get("<%= ClientID %>_marketing"),
                tbl: apl.createTableWS.init("<%= ClientID %>_tbl",
                    [
                        apl.createTableWS.column("contact_name"),
                        apl.createTableWS.column("contact_phone")
                    ]
                ),
                tbl_load: function (id) {
                    activities.act_customer_contact_list(id,
                        function (arrData) {
                            o.tbl.load(arrData);
                        }, apl.func.showError, ""
                    );
                },
                info: function (id) {
                    o.tbl_load(id);
                    activities.act_customer_data(id,
                        function (data) {
                            o.lb_branch.innerHTML = data.branch_name;
                            o.lb_name.innerHTML = data.customer_name;
                            o.tb_address.value = data.customer_address_location;
                            o.lb_address2.innerHTML = data.customer_address;
                            o.lb_phone.innerHTML = data.customer_phone;
                            o.lb_fax.innerHTML = data.customer_fax;
                            o.lb_npwp.innerHTML = data.npwp;
                            o.lb_email.innerHTML = data.customer_email;
                            o.lb_distance.innerHTML = data.distance;
                            o.lb_marketing.innerHTML = data.marketing_id;
                            o.showEdit("Customer - Info");
                        }, apl.func.showError, ""
                    );

                }
            }, undefined, undefined, undefined, "<%= parent_id %>", "<%= cover_id %>", ""
            //}, undefined, undefined, undefined, "frm_page", "mdl1", ""
        );
    });

</script>
