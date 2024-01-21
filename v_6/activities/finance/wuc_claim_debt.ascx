<%@ Control Language="C#" ClassName="wuc_claim_debt" ClientIDMode="Static" %>

<script runat="server">
    public string mdl_id;
    
    public string fin_type_id { get; set; }
    public string parent_id { get; set; }
    public string cover_id { get; set; }
    
    void Page_Load(object o, EventArgs e)
    {
        mdl_id = ClientID;
    }
</script>


    <div id="<%= mdl_id %>">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Kontak</th>
                    <td><input type="text" id="<%= mdl_id %>_contact"/></td>
                </tr>
                <tr>
                    <th style="vertical-align:top;">Note</th>
                    <td><textarea id="<%= mdl_id %>_note"></textarea></td>
                </tr>
                <tr>
                    <th>Hasil</th>
                    <td><select id="<%= mdl_id %>_result"></select></td>
                </tr>
            </table>

            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Add"/>
                <input type="button" value="Cancel"/>
            </div>
        </fieldset>
    </div>

    <div id="<%= mdl_id %>_list">
        <fieldset>
            <legend></legend>
            <table class="gridView" id="<%= mdl_id %>_list_tbl">
                <tr>
                    <th>Tanggal</th>
                    <th>Kontak</th>
                    <th>Hasil</th>
                    <th>Note</th>
                </tr>                
            </table>

            <div style="padding-top:5px;margin-top:3px;" class="button_panel">
                <input type="button" value="Close"/>
            </div>
        </fieldset>
    </div>

<script type="text/javascript">
    window.addEventListener("load", function () {
        document["<%= mdl_id %>"] = apl.createModal("<%= mdl_id %>",
            {
                servicesales_id: 0,
                tb_contact: apl.func.get("<%= mdl_id %>_contact"),
                tb_note: apl.func.get("<%= mdl_id %>_note"),
                ddl_result: apl.createDropdownWS("<%= mdl_id %>_result", activities.dl_fin_result_list),
                val_contact: apl.createValidator("<%= mdl_id %>_save", "<%= mdl_id %>_contact", function () { return apl.func.emptyValueCheck(document["<%= mdl_id %>"].tb_contact.value); }, "Harus di isi"),
                val_result: apl.createValidator("<%= mdl_id %>_save", "<%= mdl_id %>_result", function () { return apl.func.emptyValueCheck(document["<%= mdl_id %>"].ddl_result.value); }, "Harus di isi"),
                open: function (id) {
                    document["<%= mdl_id %>"].servicesales_id = id;
                    document["<%= mdl_id %>"].tb_contact.value = "";
                    document["<%= mdl_id %>"].tb_note.value = "";
                    document["<%= mdl_id %>"].ddl_result.value = "";
                    apl.func.validatorClear("<%= mdl_id %>_save");
                    document["<%= mdl_id %>"].showAdd("Penagihan - Tambah");
                }
            },
            function () {
                if (apl.func.validatorCheck("<%= mdl_id %>_save")) {
                    apl.func.showSinkMessage("Save");
                    activities.fin_claim_debt_add(document["<%= mdl_id %>"].servicesales_id, document["<%= mdl_id %>"].tb_contact.value, document["<%= mdl_id %>"].tb_note.value, document["<%= mdl_id %>"].ddl_result.value, "<%= fin_type_id %>",
                        function () {
                            document["<%= mdl_id %>"].hide();
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, "");
                }
            }, undefined, undefined, "<%= parent_id %>", "<%= cover_id %>"
        );

        document["<%= mdl_id %>_list"] = apl.createModal("<%= mdl_id %>_list",
            {
                servicesales_id: 0,
                tbl: (function () {
                    var o = apl.createTableWS.init("<%= mdl_id %>_list_tbl",
                        [
                            apl.createTableWS.column("call_date"),
                            apl.createTableWS.column("contact"),
                            apl.createTableWS.column("result"),
                            apl.createTableWS.column("note")
                        ]
                    );
                    o.loading = function (id) {
                        activities.fin_claim_debt_list(id, "<%= fin_type_id %>",
                            function (arr_data) {
                                o.load(arr_data);
                            }, apl.func.showError, "");
                    }

                    return o;
                })(),
                open: function (id) {
                    mdl_claim_debt_list.servicesales_id = id;
                    mdl_claim_debt_list.showEdit("Riwayat Penagihan");
                    mdl_claim_debt_list.tbl.loading(id);
                }
            }, undefined, undefined, undefined, "<%= parent_id %>", "<%= cover_id %>"
        );

    });
</script>