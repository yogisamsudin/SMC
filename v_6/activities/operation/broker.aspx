<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page"%>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" src="../../js/Komponen.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <asp:ScriptManager runat="server" ID="sm">
        <Services>
            <asp:ServiceReference Path="../activities.asmx" />
        </Services>
    </asp:ScriptManager>  

    <table class="formview">
        <tr>
            <th>Broker</th>
            <td><input type="text" id="cari_name"/></td>
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.load();">Cari</div></td>
        </tr>
    </table>
    
    <iframe class="frameList" id="cari_fr"></iframe>
    
    <div id="mdl"> 
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Broker</th>
                    <td><input type="text" id="mdl_broker" size="50" maxlength="50"/></td>
                </tr>
                <tr>
                    <th>Alamat</th>
                    <td><textarea id="mdl_address" maxlength="300"></textarea></td>
                </tr>
                <tr>
                    <th>Title #1</th>
                    <td><input type="text"  id="mdl_title1" size="100" maxlength="200"/></td>
                </tr>
                <tr>
                    <th>Title #2</th>
                    <td><input type="text"  id="mdl_title2"  size="100" maxlength="200"/></td>
                </tr>
                <tr>
                    <th>Title #3</th>
                    <td><input type="text"  id="mdl_title3"  size="100" maxlength="200"/></td>
                </tr>
                <tr>
                    <th>Gambar Logo</th>
                    <td><div class="edit" title="edit gambar logo" style="float:left;" onclick="mdl_logo.open(mdl.broker_id,'logo');"></div></td>
                </tr>
                <tr>
                    <th>Gambar Header</th>
                    <td><div class="edit" title="edit gambar header" style="float:left;" onclick="mdl_logo.open(mdl.broker_id,'i_header');"></div></td>
                </tr>
                <tr>
                    <th>Gambar Title</th>
                    <td><div class="edit" title="edit gambar title" style="float:left;" onclick="mdl_logo.open(mdl.broker_id,'i_title');"></div></td>
                </tr>
                <tr>
                    <th>Gambar Footer</th>
                    <td><div class="edit" title="edit gambar footer" style="float:left;" onclick="mdl_logo.open(mdl.broker_id,'i_footer');"></div></td>
                </tr>
                <tr>
                    <th>Inisial</th>
                    <td><input type="text" id="mdl_initial" size="3" maxlength="3"/></td>
                </tr>
                <tr>
                    <th>Tax Status</th>
                    <td><input type="checkbox" id="mdl_tax"/></td>
                </tr>
                <tr>
                    <th>Rentang Garansi</th>
                    <td><input type="text" id="mdl_guaranti_term" maxlength="3" size="3" style="text-align:right;"/> Bulan</td>
                </tr>
            </table>
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Add"/>
                <input type="button" value="Save"/>
                <input type="button" value="Delete"/>
                <input type="button" value="Cancel"/>
            </div>
        </fieldset>
    </div>

    <div id="mdl_logo">
        <fieldset>
            <legend></legend>
            <iframe id="mdl_logo_if" style="border:none;width:100%;"></iframe>
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Save"/>
                <input type="button" value="Close"/>
            </div>
        </fieldset>        
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var cari = {
            tb_name: apl.func.get("cari_name"),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var name = escape(cari.tb_name.value);
                cari.fl.src = "broker_list.aspx?name=" + name;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                broker_id: 0,
                tb_broker: apl.func.get("mdl_broker"),
                tb_address: apl.func.get("mdl_address"),
                tb_title1: apl.func.get("mdl_title1"),
                tb_title2: apl.func.get("mdl_title2"),
                tb_title3: apl.func.get("mdl_title3"),
                tb_initial: apl.func.get("mdl_initial"),
                cb_tax: apl.func.get("mdl_tax"),
                tb_guaranti_term: apl.createNumeric("mdl_guaranti_term"),
                val_broker: apl.createValidator("save", "mdl_broker", function () { return apl.func.emptyValueCheck(mdl.tb_broker.value); }, "Salah input"),
                val_guaranti_term: apl.createValidator("save", "mdl_guaranti_term", function () { return apl.func.emptyValueCheck(mdl.tb_guaranti_term.value); }, "Salah input"),
                kosongkan:function()
                {
                    mdl.broker_id = 0;
                    mdl.tb_broker.value = "";
                    mdl.tb_address.value = "";
                    mdl.tb_title1.value = "";
                    mdl.tb_title2.value = "";
                    mdl.tb_title3.value = "";
                    mdl.tb_initial.value = "";
                    mdl.cb_tax.checked = true;
                    mdl.tb_guaranti_term.value = "";
                    apl.func.validatorClear("save");
                    apl.func.hideSinkMessage();
                },
                tambah: function ()
                {
                    mdl.kosongkan();
                    mdl.showAdd("Broker - Tambah");
                },
                edit:function(id)
                {
                    apl.func.showSinkMessage("Memuat Data");
                    mdl.kosongkan();
                    activities.opr_broker_data(id,
                        function (data)
                        {
                            mdl.broker_id = id;
                            mdl.tb_broker.value = data.broker_name;
                            mdl.tb_address.value = data.broker_address;
                            mdl.tb_title1.value = data.title_1;
                            mdl.tb_title2.value = data.title_2;
                            mdl.tb_title3.value = data.title_3;
                            mdl.tb_initial.value = data.initial;
                            mdl.cb_tax.checked = data.par_tax_sts;
                            mdl.tb_guaranti_term.setValue(data.guaranti_term);
                            mdl.showEdit("Broker - Edit");
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                },
                refresh:function()
                {
                    mdl.hide();
                    cari.fl_refresh();
                }
            }, 
            function ()
            {
                if(apl.func.validatorCheck("save"))
                {
                    activities.opr_broker_add(mdl.tb_broker.value, mdl.tb_address.value, mdl.tb_title1.value, mdl.tb_title2.value, mdl.tb_title3.value,mdl.tb_initial.value,mdl.cb_tax.checked,mdl.tb_guaranti_term.getIntValue(), mdl.refresh, apl.func.showError, "");
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    activities.opr_broker_edit(mdl.broker_id, mdl.tb_broker.value, mdl.tb_address.value, mdl.tb_title1.value, mdl.tb_title2.value, mdl.tb_title3.value, mdl.tb_initial.value, mdl.cb_tax.checked, mdl.tb_guaranti_term.getIntValue(), mdl.refresh, apl.func.showError, "");
                }
            },
            function ()
            {
                if(confirm("Yakin akan dihapus?"))
                {
                    activities.opr_broker_delete(mdl.broker_id, mdl.refresh, apl.func.showError, "");
                }
            }, "frm_page", "cover_content"
        );

        var mdl_logo = apl.createModal("mdl_logo",
            {
                if_logo:apl.func.get("mdl_logo_if"),
                open:function(id, field_image)
                {
                    if (id != 0) {
                        mdl_logo.if_logo.src = "broker_logo.aspx?id=" + id + "&field=" + field_image;
                        mdl_logo.showEdit("Logo - Edit");
                    }
                }
            }, undefined,
            function()
            {
                mdl_logo.if_logo.contentDocument.submit();
                mdl_logo.hide();
            }, undefined, "frm_page", "mdl"
        );

        window.addEventListener("load", function ()
        {
            cari.load();
            document.list_add = mdl.tambah;
            document.list_edit = mdl.edit;
        });
    </script>
</asp:Content>

