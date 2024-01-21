<%@ Control Language="C#" ClassName="wuc_service_inq_full" %>

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

<div id="<%= ClientID %>" class="modal">
    <fieldset>
        <legend></legend>
            
        <table class="formview">
            <tr>
                <th>Tanggal</th>
                <td><label id="<%= ClientID %>_date"></label></td>
            </tr>
            <tr>
                <th>Cabang</th>
                <td><label id="<%= ClientID %>_branch"></label></td>
            </tr>
            <tr>
                <th>Nama Pelanggan</th>
                <td><label id="<%= ClientID %>_customer" style="float:left;"></label></td>
            </tr>
            <tr>
                <th>Cabang Pelanggan</th>
                <td><span id="<%= ClientID %>_branch_customer"></span></td>
            </tr>
            <tr>
                <th>NPWP</th>
                <td><label id="<%= ClientID %>_npwp" style="float:left;"></label></td>
            </tr>
            <tr>
                <th>Telepon</th>
                <td><label id="<%= ClientID %>_phone"></label></td>
            </tr>
            <tr>
                <th>Fax</th>
                <td><label id="<%= ClientID %>_fax"></label></td>
            </tr>
            <tr>
                <th>Email</th>
                <td><label id="<%= ClientID %>_email"></label></td>
            </tr>
            <tr>
                <th>Atas Nama</th>
                <td><label id="<%= ClientID %>_an"></label></td>
            </tr>
            <tr>
                <th>Kontak</th>
                <td><label id="<%= ClientID %>_contact"></label></td>
            </tr>
            <tr>
                <th>Alamat Kurir #1</th>
                <td><textarea id="<%= ClientID %>_pickup_address" style="float:left" disabled="disabled"></textarea></td>
            </tr>
            <tr>
                <th>Alamat Kurir #2</th>
                <td><label id="<%= ClientID %>_pickup_address2" ></label></td>
            </tr>
            <tr>
                <th>Catatan</th>
                <td><textarea id="<%= ClientID %>_note" style="max-width:100%;width:600px;height:200px;font-family:'Courier New';" disabled="disabled"></textarea></td>
            </tr>
            <tr>
                <th>Tgl.Kurir</th>
                <td><label id="<%= ClientID %>_pickup_date" ></label></td>
            </tr>
            <tr>
                <th>Fee</th>
                <td><label id="<%= ClientID %>_fee" ></label></td>
            </tr>
            <tr>
                <th>Status Backup</th>
                <td><label id="<%= ClientID %>_backup"></label></td>
            </tr> 
        </table>                    

        <div style="padding-top:5px;" class="button_panel">
            <input type="button" value="Close"/>
        </div>
    </fieldset>
</div>


<script type="text/javascript">
    window.addEventListener("load",
        function () {
            var mdl = document["<%= ClientID %>"] = apl.createModal("<%= ClientID %>",
            {
                lb_branch: apl.func.get("<%= ClientID %>_branch"),
                lb_date: apl.func.get("<%= ClientID %>_date"),
                lb_customer: apl.func.get("<%= ClientID %>_customer"),
                lb_phone: apl.func.get("<%= ClientID %>_phone"),
                lb_fax: apl.func.get("<%= ClientID %>_fax"),
                lb_email: apl.func.get("<%= ClientID %>_email"),
                lb_an: apl.func.get("<%= ClientID %>_an"),
                lb_contact: apl.func.get("<%= ClientID %>_contact"),
                tb_pickup_address: apl.func.get("<%= ClientID %>_pickup_address"),
                lb_pickup_address2: apl.func.get("<%= ClientID %>_pickup_address2"),
                tb_note: apl.func.get("<%= ClientID %>_note"),
                lb_pickup_date: apl.func.get("<%= ClientID %>_pickup_date"),
                lb_npwp: apl.func.get("<%= ClientID %>_npwp"),
                lb_fee: apl.func.get("<%= ClientID %>_fee", true),
                lb_backup: apl.func.get("<%= ClientID %>_backup"),
                lb_branch_customer: apl.func.get("<%= ClientID %>_branch_customer"),
                edit: function (id) {
                    apl.func.showSinkMessage("Memuat Data");
                    activities.act_service_data(id,
                        function (data) {
                            mdl.lb_date.innerHTML = data.service_call_date;
                            mdl.lb_branch.innerHTML = data.branch_name;
                            mdl.lb_customer.innerHTML = data.customer_name;
                            mdl.lb_an.innerHTML = data.an;
                            mdl.lb_contact.innerHTML = data.contact_name;
                            mdl.tb_pickup_address.value = data.pickup_address_location;
                            mdl.lb_pickup_address2.innerHTML = data.pickup_address;
                            mdl.tb_note.value = data.note;
                            mdl.lb_pickup_date.innerHTML = data.pickup_date;
                            mdl.lb_fee.innerHTML = apl.func.formatNumeric(data.fee);
                            mdl.lb_npwp.innerHTML = data.npwp;
                            mdl.lb_phone.innerHTML = data.customer_phone;
                            mdl.lb_fax.innerHTML = data.customer_fax;
                            mdl.lb_email.innerHTML = data.customer_email;
                            mdl.lb_backup.innerHTML = data.backup_sts;
                            mdl.lb_branch_customer.innerHTML = data.branch_customer;
                            mdl.showEdit("Servis - Edit");
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                }
            },
            undefined,
            undefined,
            undefined, "<%= parent_id%>", "<%= cover_id %>", ""
        );
    });
</script>