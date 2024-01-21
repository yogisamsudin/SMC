<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page" %>

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

    <iframe class="frameList" id="fr_list"></iframe>      

    <div id="mdl" class="modal">
        <fieldset>
            <legend>Marketing</legend>
            <table class="formview">                
                <tr>
                    <th>Nama Grup</th>
                    <td><input type="text" id="mdl_name" size="50"/></td>
                </tr>                
            </table>
            <div style="padding-top:5px;">
                <input type="button" value="Add" />
                <input type="button" value="Save"/>
                <input type="button" value="Delete"/>
                <input type="button" value="Cancel"/>
            </div>
        </fieldset>
    </div> 
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var cari = {
            fl: apl.func.get("fr_list"),
            load: function () {
                cari.fl.src = "marketing_group_list.aspx";
            },
            refresh: function () {
                cari.fl.contentWindow.location.reload(true);
            }
        }        

        var mdl = apl.createModal("mdl",
            {
                marketing_group_id: 0,
                tb_name: apl.func.get("mdl_name"),                

                val_name: apl.createValidator("save", "mdl_name", function () { return apl.func.emptyValueCheck(mdl.tb_name.value); }, "Inputan salah"),
                
                kosongkan: function () {      
                    mdl.marketing_group_id = 0;
                    mdl.tb_name.value = "";                    
                    apl.func.validatorClear("save");                    
                },
                tambah: function () {
                    mdl.kosongkan();
                    mdl.showAdd("Marketing Grup- Tambah");
                },
                edit: function (id) {
                    mdl.kosongkan();
                    mdl.marketing_group_id = id;
                    activities.act_marketing_group_data(id,
                        function (data)
                        {
                            mdl.tb_name.value = data.marketing_group_name;
                            mdl.showEdit("Marketing Group - Edit");
                        },
                        apl.func.showError, ""
                    );                    
                },
                refresh: function () {
                    mdl.hide();
                    cari.refresh();
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) activities.act_marketing_group_add(mdl.tb_name.value, mdl.refresh, apl.func.showError, "");
            },
            function () {
                if (apl.func.validatorCheck("save")) activities.act_marketing_group_edit(mdl.marketing_group_id, mdl.tb_name.value, mdl.refresh, apl.func.showError);
            },
            function () {
                if (confirm("Yakin akan dihapus?")) alert("delete");
            }, "frm_page", "cover_content"
        );

        document.list_tambah = mdl.tambah;
        document.list_edit = mdl.edit;        

        window.addEventListener("load", function () {
            cari.load();
        });        

    </script>
</asp:Content>

