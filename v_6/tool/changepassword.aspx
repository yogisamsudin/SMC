<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" theme="Page"%>

<script runat="server">
    public _test.App a;

    void Page_Load(object o, EventArgs e)
    {
        a = new _test.App(Request, Response);
    }
    
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

    <table class="formview">
        <tr>
            <th style="width:150px;">New Password</th>
            <td><input type="password" id="tbNewPassword" value="" autocomplete="off" size="6" maxlength="6"/></td>
        </tr>
        <tr>
            <th></th>
            <td><input type="button" value="Change" onclick="changePassword()"/></td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var p = document.getElementById("tbNewPassword");
        var pv = apl.createValidator("save", "tbNewPassword", function () { return apl.func.emptyValueCheck(p.value)}, "Password kosong");

        function changePassword() {
            
            if (apl.func.validatorCheck("save")) {                
                tool.appUserChangePassword('<%= a.cookieUserIDValue %>', p.value, function () {
                    alert("Password telah dirubah, silahkan logout");
                }, apl.func.showError, "");
            }
        }
    </script>    
</asp:Content>

