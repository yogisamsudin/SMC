<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page" %>

<script runat="server">
    public string ListID;

    void page_load()
    {
        string where = "6;SL";
        string[] data = where.Split(';');
        //Response.Write(where.Split(';')[0]);

        ListID = "33";
        if (Request.QueryString["ListID"] != null)
        {
            ListID = Request.QueryString["ListID"].ToString();
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="../../js/Komponen.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <asp:ScriptManager runat="server" ID="sm">
        <Services>
            <asp:ServiceReference Path="../activities.asmx" />
        </Services>
    </asp:ScriptManager>

    <table class="formview">
        <tr>
            <th>ID</th>
            <td>
                <input type="text" id="cari_no" /></td>
        </tr>
        <tr>
            <th></th>
            <td>
                <div class="buttonCari" onclick="cari.load();">Cari</div>
            </td>
        </tr>
    </table>

    <iframe class="frameList" id="cari_fr"></iframe>

    <div id="mdl" class="modal">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>ID</th>
                    <td>
                        <label id="mdl_id"></label>
                    </td>
                </tr>
                <tr>
                    <th>Pelanggan</th>
                    <td>
                        <input type="text" id="mdl_customer" size="50" maxlength="50" /></td>
                </tr>
            </table>

            <table class="formview" style="min-width: 800px;" id="mdl_fv">
                <tr>
                    <th>List</th>
                    <td colspan="3">
                        <table class="gridView" id="mdl_tbl" style="min-width: 800px">
                            <tr>
                                <th style="width: 25px">
                                    <div class="tambah" onclick="mdl2.tambah()"></div>
                                </th>
                                <th>No.Invoice</th>
                                <th>No.Surat Jalan</th>
                                <th>Jumlah</th>
                                <th>Keterangan</th>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <th colspan="2" style="text-align: center; background-color: gray; padding: 3px;">Penerima</th>
                    <th colspan="2" style="text-align: center; background-color: gray; padding: 3px;">Pengirim</th>
                </tr>
                <tr>
                    <th>Nama</th>
                    <td>
                        <input id="mdl_name" size="50" /></td>
                    <th>Kurir</th>
                    <td>
                        <select id="mdl_messanger"></select></td>
                </tr>
                <tr>
                    <th>Tgl.Terima</th>
                    <td>
                        <input type="text" id="mdl_receivedate" size="10" maxlength="10" readonly="readonly" /></td>
                    <th>Tgl.Kirim</th>
                    <td>
                        <input type="text" id="mdl_deliverdate" size="10" maxlength="10" readonly="readonly" /></td>
                </tr>
            </table>
            <div style="padding-top: 5px;" class="button_panel">
                <input type="button" value="Add" />
                <input type="button" value="Save" />
                <input type="button" value="Delete" />
                <input type="button" value="Cancel" />
                <select id="mdl_cetak_type" style="float:right;">
                    <option value="">PDF</option>
                    <option value="3">Word</option>
                    <option value="2">Excel</option>
                </select>
                <input type="button" value="Print" onclick="mdl.print(document.getElementById('mdl_cetak_type').value);" style="float:right;"/>
            </div>
        </fieldset>
    </div>

    <div class="modal" id="mdl2">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Jenis</th>
                    <td>
                        <select id="mdl2_jenis">
                            <option value="SL">Sales</option>
                            <option value="SC">Service</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>No.Invoice</th>
                    <td>
                        <input type="text" id="mdl2_invoiceno" /></td>
                </tr>
            </table>
            <div style="padding-top: 5px;" class="button_panel">
                <input type="button" value="Add" />
                <input type="button" value="Close" />
            </div>
        </fieldset>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="Server">
    <script type="text/javascript">
        var cari = {
            tb_no: apl.func.get("cari_no"),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var no = escape(cari.tb_no.value);
                cari.fl.src = "fin_receipt_list.aspx?no=" + no;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                invoice_receipt_id: 0,
                fv: apl.func.get("mdl_fv"),
                lb_id: apl.func.get("mdl_id"),
                tb_name: apl.func.get("mdl_name"),
                tb_receivedate: apl.create_calender("mdl_receivedate"),
                tb_deliverydate: apl.create_calender("mdl_deliverdate"),
                ac_customer: apl.create_auto_complete_text("mdl_customer", activities.ac_customer, undefined, 600,
                    function (data) {
                        //mdl.dl_an.clearItem();
                        //mdl.dl_contact.clearItem();
                        //mdl.group_customer_id = data.other_value;
                        /*
                        activities.act_customer_data(data.value,
                            function (data) {
                                mdl.group_customer_id = data.group_customer_id;
                            }, apl.func.showError, ""
                        );
                        */
                    },
                    function () { return "branch_id like '%'"; }
                ),
                dl_messanger: apl.createDropdownWS("mdl_messanger", activities.dl_messanger),
                tbl: apl.createTableWS.init("mdl_tbl", [
                    apl.createTableWS.column("invoice_receipt_id", undefined, [apl.createTableWS.attribute("class", "hapus")], function (d) { mdl2.hapus(d); }, undefined, "div", "-"),
                    apl.createTableWS.column("invoice_no"),
                    apl.createTableWS.column("receipt_no"),
                    apl.createTableWS.column("grand_price", undefined, [apl.createTableWS.attribute("style", "text-align: right;")], undefined, true),
                ]),

                //val_deld: apl.createValidator("save", "mdl_deliverdate", function () { return apl.func.emptyValueCheck(mdl.tb_deliverydate.value); }, "Salah input"),
                val_name: apl.createValidator("save", "mdl_customer", function () { return apl.func.emptyValueCheck(mdl.ac_customer.value); }, "Salah input"),
                //val_bank: apl.createValidator("save", "mdl_messanger", function () { return apl.func.emptyValueCheck(mdl.dl_messanger.value); }, "Salah input"),

                kosongkan: function () {
                    mdl.invoice_receipt_id = 0;
                    mdl.lb_id.innerHTML = "";
                    mdl.ac_customer.set_value("", "");
                    mdl.tb_name.value = "";
                    mdl.tb_receivedate.value = "";
                    mdl.tb_deliverydate.value = "";
                    mdl.dl_messanger.value = "";
                    apl.func.validatorClear("save");
                    apl.func.hideSinkMessage();
                    mdl.ac_customer.input.disabled = false;
                    mdl.fv.Show();
                    mdl.tbl.clearAllRow();
                },
                tbl_load: function () {
                    activities.fin_invoice_receipt_detail_list(mdl.invoice_receipt_id, function (arrdata) { mdl.tbl.load(arrdata); }, apl.func.showError, "");
                },
                tambah: function () {
                    mdl.kosongkan();
                    mdl.fv.Hide();
                    mdl.showAdd("Tanda Terima - Tambah");
                },
                edit: function (id) {
                    mdl.kosongkan();
                    mdl.showEdit("Tanda Terima - Edit");
                    mdl.ac_customer.input.disabled = true;
                    apl.func.showSinkMessage("Memuat Data");
                    mdl.invoice_receipt_id = id;
                    mdl.tbl_load();
                    activities.invoice_receipt_data(id,
                        function (data) {
                            mdl.lb_id.innerHTML = id;
                            mdl.ac_customer.set_value(data.customer_id, data.customer_name);
                            mdl.tb_name.value = data.receipt_name;
                            mdl.tb_receivedate.value = data.receipt_date;
                            mdl.tb_deliverydate.value = data.deliver_date;
                            mdl.dl_messanger.value = data.messanger_id;
                            apl.func.validatorClear("save");
                            apl.func.hideSinkMessage();

                        },
                        apl.func.showError, ""
                    );
                },
                print: function (file_type) {
                    if (mdl.invoice_receipt_id != 0) {
                        var fName = mdl.ac_customer.text + "_" + mdl.lb_id.innerHTML;
                        fName = window.escape(fName.replace(/ /g, "_"));
                        window.location = "../../report/report_generator.ashx?ListID=<%= ListID %>&id=" + mdl.invoice_receipt_id + "&pdfName=" + fName + "&fileType=" + file_type;
                    }
                },
                refresh: function () {
                    mdl.hide();
                    cari.fl_refresh();
                    apl.func.hideSinkMessage();
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menambah Data");
                    activities.fin_invoice_receipt_add(mdl.ac_customer.id,
                        function (id) {
                            apl.func.hideSinkMessage();
                            mdl.edit(id);
                            cari.fl_refresh();
                        },
                        apl.func.showError, ""
                    );
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menyimpan Data");
                    activities.fin_invoice_receipt_edit(mdl.invoice_receipt_id, mdl.tb_deliverydate.value, mdl.dl_messanger.value, mdl.tb_receivedate.value, mdl.tb_name.value,
                        function () {
                            apl.func.hideSinkMessage();
                            mdl.hide();
                        },
                        apl.func.showError, ""
                    );
                }
            },
            function () {
                if (confirm("Yakin akan dihapus?")) {
                    apl.func.showSinkMessage("Menghapus Data");
                    activities.fin_invoice_receipt_delete(mdl.invoice_receipt_id,
                        function () {
                            apl.func.hideSinkMessage();
                            mdl.hide();
                            cari.fl_refresh();
                        }, apl.func.showError, "");
                }
            }, "frm_page", "cover_content"
        );

        var mdl2 = apl.createModal("mdl2",
            {
                dl_jenis: apl.func.get("mdl2_jenis"),
                ac_invoice: apl.create_auto_complete_text("mdl2_invoiceno", activities.ac_fin_invoice_receipt_allinvoicedata, undefined, undefined, undefined, function () { var val = mdl.ac_customer.id + ";" + mdl2.dl_jenis.value; return val; }),

                val_name: apl.createValidator("savemdl2", "mdl2_invoiceno", function () { return apl.func.emptyValueCheck(mdl2.ac_invoice.value); }, "Salah input"),

                kosongkan: function () {
                    mdl2.ac_invoice.set_value("", "");

                    apl.func.validatorClear("savemdl2");
                    apl.func.hideSinkMessage();
                },
                tambah: function () {
                    mdl2.kosongkan();
                    mdl2.showAdd("Tambah Invoice");
                },
                hapus: function (d) {
                    //alert(d.invoice_receipt_id + ":" + d.id + ":" + d.jenis);
                    if (confirm("Yakin akan dihapus?")) activities.fin_invoice_receipt_detail_delete(d.invoice_receipt_id, d.jenis, d.id, function () { mdl.tbl_load(); }, apl.func.showError, "");
                    //alert(activities.fin_invoice_receipt_detail_delete);
                },
            },
            function () {
                if (apl.func.validatorCheck("savemdl2")) {
                    apl.func.showSinkMessage("Save");
                    activities.fin_invoice_receipt_detail_add(mdl.invoice_receipt_id, mdl2.dl_jenis.value, mdl2.ac_invoice.id,
                        function () {
                            apl.func.hideSinkMessage();
                            mdl2.hide();
                            mdl.tbl_load();
                        },
                        apl.func.showError, ""
                    );
                }
            }, undefined, undefined, "frm_page", "mdl"
        );

        window.addEventListener("load", function () {
            cari.load();
            document.list_add = mdl.tambah;
            document.list_edit = mdl.edit;
        });

    </script>
</asp:Content>

