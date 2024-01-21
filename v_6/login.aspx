<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" theme="Default"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Test</title>
    <link href="Image/AplShortcut.png" rel="shortcut icon" type="image/x-icon" />
    <script type="text/javascript" src="js/Komponen.js"></script>
</head>
<body>
    <form id="frmLogin" runat="server">
    <br />        
    <div class="Logo"></div>
    <h2>Masukan akun anda</h2>    
    <center>
    <div class="Login">
        <center>
        <div class="LoginLogo"></div>
        </center>
        <table>
            <tr>
                <td style="height:35px">
                    <input type="text" id="tbUser" value="sa" autocomplete="off"/>
                </td>
            </tr>
            <tr>
                <td  style="height:35px">
                    <input type="password" id="tbPassword" value="123" autocomplete="off"/>                    
                </td>
            </tr>
            <tr>
                <td style="height:35px">
                    <input type="button" value="Login" id="btnLogin" />
                </td>
            </tr>
        </table>
    </div>
    </center>    
    <asp:ScriptManager runat="server" ID="sm">
        <Services>
            <asp:ServiceReference Path="login.asmx" />
        </Services>
    </asp:ScriptManager>
    <asp:HiddenField runat="server" ID="hfSess" />
    <asp:HiddenField runat="server" ID="hfValid" />
    <asp:HiddenField runat="server" ID="hfUser" />
    </form>
    <script type="text/javascript">
        var cLogin = {
            user: apl.createWatermark($$get("tbUser"), "User ID"),
            pass: apl.createWatermark($$get("tbPassword"), "Password"),
            ses: $$get("<%= hfSess.ClientID %>"),
            val: $$get("<%= hfValid.ClientID %>"),
            usr: $$get("<%= hfUser.ClientID %>")
        };

        document.getElementById("btnLogin").onclick = function () {
            if (cLogin.user.checkValueEmpty()) {
                alert("user ID harus di isi");
            } else {
                login.loginCheck(cLogin.user.value, cLogin.pass.value, cLogin.ses.value,
                function (hasil) {
                    if (hasil == "valid") {
                        cLogin.val.value = "valid";
                        cLogin.usr.value = cLogin.user.value;
                        apl.func.refreshDoc();
                    } else {
                        alert(hasil);
                    }
                }, apl.func.showError, "");
            }
        }

    </script>
</body>
</html>
