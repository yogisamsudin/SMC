<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" theme="Page"%>

<%@ Register Src="~/activities/expedition/wuc_exp_service_inq.ascx" TagPrefix="uc1" TagName="wuc_exp_service_inq" %>
<%@ Register Src="~/activities/expedition/wuc_service_device_register.ascx" TagPrefix="uc1" TagName="wuc_service_device_register" %>



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
            <th>ID</th>
            <td><input type="text" id="cari_id"/></td>
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.load();">Cari</div></td>
        </tr>
    </table>
    
    <iframe class="frameList" id="cari_fr"></iframe> 

    <uc1:wuc_exp_service_inq runat="server" ID="mdl_service_inq" parent_id="frm_page" cover_id="mdl"/>

    <uc1:wuc_service_device_register runat="server" ID="mdl_service_device_register" parent_id="frm_page" cover_id="mdl" function_parent_refresh="document.tbl_service_load();"/>

    <div id="mdl">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>ID</th>
                    <td><label id="mdl_id"></label></td>
                </tr>
                <tr>
                    <th>Tanggal</th>
                    <td><label id="mdl_date"></label></td>
                </tr>
                <tr>
                    <th>Marketing Servic Info</th>
                    <td><div class="info" onclick="mdl.call_info()" title="Info"></div></td>
                </tr>
                <tr>
                    <th>Daftar SN</th>
                    <td>
                        <table id="mdl_tbl" class="gridView">
                            <tr>
                                <th style="width:25px;"><div class="tambah" title="Tambah register service" onclick="mdl.tambah_sn()"></div></th>
                                <th>sn</th>
                                <th>Device</th>
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
</asp:Content> 
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var cari = {
            tb_id: apl.func.get("cari_id"),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var id = escape(cari.tb_id.value);
                cari.fl.src = "service_register_list.aspx?id=" + id;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }
        
        var mdl = apl.createModal("mdl",
            {
                schedule_id: 0,
                service_id: 0,
                lb_id: apl.func.get("mdl_id"),
                lb_date: apl.func.get("mdl_date"),
                call_info:function()
                {
                    document.mdl_service_inq.edit(mdl.service_id);
                },
                tbl_service: apl.createTableWS.init("mdl_tbl",
                    [
                        apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "edit")], function (data) { mdl.edit_sn(data.service_device_id);}, undefined, undefined),
                        apl.createTableWS.column("sn"),
                        apl.createTableWS.column("device")
                    ]
                ),
                tbl_service_load:function()
                {
                    activities.tec_service_device_list_by_service_id(mdl.service_id,
                        function (arrData) {
                            mdl.tbl_service.load(arrData);
                        }, apl.func.showError, ""
                    );
                },
                edit: function (schedule_id, service_id, schedule_date)
                {
                    apl.func.showSinkMessage("Memuat Data");
                    mdl.schedule_id = schedule_id;
                    mdl.service_id = service_id;
                    mdl.lb_id.innerHTML = schedule_id;
                    mdl.lb_date.innerHTML = schedule_date;
                    mdl.tbl_service_load();
                    mdl.showEdit("Register Servis - Edit");
                    apl.func.hideSinkMessage();
                },
                tambah_sn:function()
                {
                    mdl_service_device_register.tambah(mdl.service_id,mdl.lb_date.innerHTML);
                },
                edit_sn:function(id)
                {
                    mdl_service_device_register.edit(id);
                }
            }, undefined, undefined, undefined, "frm_page", "cover_content"
        );

        window.addEventListener("load", function () {
            cari.load();
            document.list_select = mdl.edit;
            document.tbl_service_load = mdl.tbl_service_load;
        });
        
    </script>
</asp:Content>

