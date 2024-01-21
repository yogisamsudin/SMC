<%@ Control Language="C#" ClassName="wuc_service_inq" %>

<script runat="server">
    public string parent_id { set; get; }
    public string cover_id { set; get; }

    void Page_Load(object o, EventArgs e)
    {
        ClientIDMode = System.Web.UI.ClientIDMode.Static;        
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
                <th>NPWP</th>
                <td><label id="<%= ClientID %>_npwp"></label></td>
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
                lb_date: apl.func.get("<%= ClientID %>_date"),
                lb_branch: apl.func.get("<%= ClientID %>_branch"),
                lb_customer: apl.func.get("<%= ClientID %>_customer"),
                lb_contact: apl.func.get("<%= ClientID %>_contact"),
                tb_pickup_address: apl.func.get("<%= ClientID %>_pickup_address"),
                lb_pickup_address2: apl.func.get("<%= ClientID %>_pickup_address2"),
                tb_note: apl.func.get("<%= ClientID %>_note"),
                lb_pickup_date: apl.func.get("<%= ClientID %>_pickup_date"),                
                lb_npwp: apl.func.get("<%= ClientID %>_npwp"),
                lb_backup: apl.func.get("<%= ClientID %>_backup"),
                edit: function (id) {
                    apl.func.showSinkMessage("Memuat Data");
                    activities.act_service_data(id,
                        function (data) {
                            mdl.lb_date.innerHTML = data.service_call_date;
                            mdl.lb_branch.innerHTML = data.branch_name;
                            mdl.lb_customer.innerHTML = data.customer_name;
                            mdl.lb_contact.innerHTML = data.contact_name;
                            mdl.tb_pickup_address.value = data.pickup_address_location;
                            mdl.lb_pickup_address2.innerHTML= data.pickup_address;
                            mdl.tb_note.value = data.note;
                            mdl.lb_pickup_date.innerHTML = data.pickup_date;
                            mdl.lb_npwp.innerHTML = data.npwp;
                            mdl.lb_backup.innerHTML = data.backup_sts;
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