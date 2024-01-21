<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" theme="Page"%>

<%@ Register Src="~/tool/wuc_menu.ascx" TagPrefix="uc1" TagName="wuc_menu" %>
<%@ Register Src="~/tool/wuc_group.ascx" TagPrefix="uc1" TagName="wuc_group" %>
<%@ Register Src="~/tool/priviledge.ascx" TagPrefix="uc1" TagName="priviledge" %>
<%@ Register Src="~/tool/wuc_user.ascx" TagPrefix="uc1" TagName="wuc_user" %>





<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script type="text/javascript" src="../js/Komponen.js"></script> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <asp:ScriptManager runat="server" ID="sm">
        <Services>
            <asp:ServiceReference Path="tool.asmx" />
        </Services>
    </asp:ScriptManager>  

    <div style="padding:3px;">
        <div id="Div1"  class="viewTab">
            <div id="Div11" style="margin: 1px 5px 1px 5px; padding: 0px; overflow:auto; height:400px; ">            
                <uc1:wuc_menu runat="server" ID="wuc_menu" />
            </div>            
        </div> 
        <div id="Div2" class="viewTab">
            <div id="Div5" style="margin: 1px 5px 1px 5px; padding: 0px; overflow:auto; height:400px; ">            
                <uc1:wuc_group runat="server" ID="wuc_group" />
            </div>
        </div>
        <div id="Div3" class="viewTab">
            <div id="Div6" style="margin: 1px 5px 1px 5px; padding: 0px; overflow:auto; height:400px; ">            
                <uc1:priviledge runat="server" ID="priviledge" />
            </div>
        </div>        
        <div id="Div4" class="viewTab">
            <div id="Div7" style="margin: 1px 5px 1px 5px; padding: 0px; overflow:auto; height:400px; ">            
                <uc1:wuc_user runat="server" ID="wuc_user" />
            </div>
        </div>        
    </div>                  
    <div onclick="refreshMenu()" style="padding-top: 10px; cursor: pointer;font-weight:bold;">
        <i>Dengan mengclick ini maka perubahan pada menu akan dilakukan dan logout setelah itu</i>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var tab = apl.createTab(
            [
                new apl.func.createTab("Div1", "Menu", wucMenu.loadMenuList),
                new apl.func.createTab("Div2", "Group", wucGroup.load),
                new apl.func.createTab("Div3", "Group Privilege", wucPrivilege.load),
                new apl.func.createTab("Div4", "User", wucUser.refreshData)
            ]
        );

        function refreshMenu() {
            apl.func.showSinkMessage("Simpan");
            tool.appGroupCreateMenuXML(function () {
                apl.func.refreshDoc("", "");
                apl.func.hideSinkMessage();
            }, apl.func.showError, "");
        }


        function test_scroll()
        {
            var v = document.getElementById("Div11");
            v.scrollTop = 1000;
            //v.parentElement
        }
    </script>
</asp:Content>

