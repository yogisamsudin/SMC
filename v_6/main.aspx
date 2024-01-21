<%@ Page Language="C#" AutoEventWireup="true" CodeFile="main.aspx.cs" Inherits="main" theme="main"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>TEST @4</title>
    <link href="Image/AplShortcut.png" rel="shortcut icon" type="image/x-icon" />    
    <script type="text/javascript" src="js/Komponen.js"></script>
</head>
<body>
    <form id="frmModul" runat="server" style="margin:0;padding:0;">  
        <div style="min-width: 855px; width:100%;padding:0;margin:0;">
            <!--tai <div class="panel_frame"><div class="frame_close"></div><div class="frame_refresh"></div></div>-->
            <div style="height:35px;margin-top:35px;margin-left:50px;">
                <table style="padding: 0; margin: 0; width:100%; border-spacing: 0px;border:0;">
                    <tr>
                        <td style="width:100px;"><div class="Logo"></div></td>
                        <td style="vertical-align: bottom;font-family: Arial, Helvetica, sans-serif; font-size: large; font-weight: bold; ">
                            ::<label id="lblJudulModul" style="padding-left: 25px" >Welcome</label>
                        </td>
                        <td style="width:18px;"><div class="frame_close" onclick="frame_close()" id="frame_close"></div></td>
                        <td style="width:18px;"><div class="frame_refresh" onclick="frame_refresh()" id="frame_refresh"></div></td>
                    </tr>
                </table>
            </div>            
            <hr />
            <div id="PanelModul" class="main_page"></div>            
        </div>      
        
        <!--<div id="modalContent"></div> -->
        <div id="modalList"></div>
        
        <!--<asp:Literal runat="server" ID="ltr_Pavorite"></asp:Literal> -->
        <!--<div class="garisatas" id="page_garis_atas"></div>        -->
        <div class="menuContent" id="menuContent">
            <table style="width:100%;">
                <tr>
                    <td>
                        <div class="menu" id="page_menu_list">
                            <asp:Literal runat="server" ID="lMenu"></asp:Literal>                    
                        </div>
                    </td>
                    <td style="text-align:right; padding-right: 10px; cursor: default;">
                        <span style="font-weight: bold;color: #0099CC; font-family: calibri; font-size: small;"><%= a.cookieApplicationDateValue %></span> | 
                        <span style="font-weight: bold;color: #0099CC; font-family: calibri;"><%= a.cookieUserIDValue %></span> | 
                        <asp:LinkButton ID="lb_logout" runat="server" OnClick="lb_logout_Click" style="text-decoration: none; cursor: pointer; font-weight: bold; color: #FF3300; font-family: calibri;">Logout</asp:LinkButton>
                        <!--<a onclick="go('logout.aspx')" style="text-decoration: none; cursor: pointer; font-weight: bold; color: #FF3300; font-family: calibri;" on>logout</a>-->
                    </td>
                </tr>
            </table>                            
        </div>                    
    </form>
    
    <script type="text/javascript">       

        function show_frame_panel()
        {
            document.getElementById("frame_close").style.display = "block";
            document.getElementById("frame_refresh").style.display = "block";
        }
        function hide_frame_panel()
        {
            document.getElementById("frame_close").style.display = "none";
            document.getElementById("frame_refresh").style.display = "none";
        }
        function tandai(ul) {
            var a;
            for (var i = 0; i < ul.childNodes.length; i++) {
                if (ul.childNodes[i].tagName == "LI") {
                    var li = ul.childNodes[i];

                    for (var j = 0; j < li.childNodes.length; j++) {
                        if (li.childNodes[j].tagName == "A") {
                            a = li.childNodes[j];
                        }
                        if (li.childNodes[j].tagName == "UL") {
                            tandai(li.childNodes[j]);
                            a.setAttribute("style", "font-weight: bold;");                            
                        }
                    }
                }
            }
        }

        var lastModul = { modalList: null, modalPanel: null };
        var oModalList = document.getElementById("modalList")

        oModalList.fl = {
            cari: function (Initial)
            {
                var o = oModalList;
                for (var i = 0; i < o.childNodes.length; i++) {
                    if (o.childNodes[i].innerHTML == Initial) {
                        return o.childNodes[i];
                        break;
                    }
                }
                return null;
            },
            setPosition:function()
            {
                var o = oModalList;
                for (var i = 0; i < o.childNodes.length; i++)
                {
                    o.childNodes[i].style.top = (85+(i * 35)).toString() + "px";
                }
            },
            Add: function (Initial, MenuName)
            {
                var o = oModalList;                
                var e = null;

                if (o.fl.cari(Initial) == null) {
                    e = apl.func.createElement("div", [apl.func.createAttribute("class", "favorite"), apl.func.createAttribute("onclick", "buka('" + Initial + "','" + MenuName + "');"), apl.func.createAttribute("title", MenuName)], Initial);
                    o.appendChild(e);
                    o.fl.setPosition();
                }
                return e;
            }

        };

        var panelModul = document.getElementById("PanelModul");
        panelModul.fl = {
            getHeight:function(){
                return (window.innerHeight - 100).toString()+"px";
            },
            updateAllHeight:function(){
                var o = panelModul;
                for(var i=0;i<o.childNodes.length;i++)
                {
                    o.childNodes[i].style.height = o.fl.getHeight();
                }
            },
            cari:function(Initial)
            {
                var o = panelModul;
                for (var i = 0; i < o.childNodes.length; i++) {
                    if (o.childNodes[i].id == "frame_" + Initial) {
                        return o.childNodes[i];
                        break;
                    }
                }
                return null;
            },
            load: function (path, Initial, MenuName)
            {
                var o = panelModul;
                var e = null;                
                
                if (o.fl.cari(Initial) == null) {                    
                    e = apl.func.createElement("iframe", [apl.func.createAttribute("id", "frame_" + Initial), apl.func.createAttribute("style", "width:100%;"), apl.func.createAttribute("src", "<%= a.getRoot()%>" + path)]);
                    e.style.height = o.fl.getHeight();
                    o.appendChild(e);                    
                }
                return e;
            },
            close:function()
            {
                
            }
        };
        function buka(Initial, MenuName)
        {
            show_frame_panel();            
            aktifkan(oModalList.fl.cari(Initial), panelModul.fl.cari(Initial),MenuName);            
        }
        function aktifkan(newList, newPanel, MenuName)
        {
            if (lastModul.modalPanel != null)
            {
                lastModul.modalPanel.style.display = "none";
                lastModul.modalList.style.backgroundColor = null;                
            }
            newList.style.backgroundColor = "black";
            newPanel.style.display = "block";

            lastModul.modalList = newList;
            lastModul.modalPanel = newPanel;

            document.getElementById("lblJudulModul").innerHTML = MenuName;
        }
        function go(path, Initial, MenuName)
        {
            
            if (path != "") {
                var newList = oModalList.fl.Add(Initial, MenuName);
                var newPanel = panelModul.fl.load(path, Initial, MenuName);
                buka(Initial, MenuName);
                //if (newPanel) { aktifkan(newList, newPanel, MenuName) } else { buka(Initial, MenuName) };            
            }
        }

        window.addEventListener("load", function () {
            try {
                apl.pubvar.spaceHeader = 50;
                window.onload = apl.func.windowOnload;
                window.onresize = apl.func.winresize.executeFunction;
            }
            catch (e) {
                alert(e);
            }

            tandai(document.getElementById("page_menu_list"));
            hide_frame_panel();
            
            var menu_url = '<%= menu_url %>';
            if (menu_url != '') go('<%= menu_url %>', '<%= initial %>', '<%= menu_name %>');

            //save geotag
            sessionStorage.setItem('lat', '<%= lat %>');
            sessionStorage.setItem('lng', '<%= lng %>');
        });

        window.addEventListener("resize", function () {
            panelModul.fl.updateAllHeight();
        });
        
        function frame_close()
        {
            panelModul.removeChild(lastModul.modalPanel);
            oModalList.removeChild(lastModul.modalList);
            if (oModalList.childNodes.length == 0) {
                hide_frame_panel();
                document.getElementById("lblJudulModul").innerHTML = "Welcome";
            } else {
                oModalList.fl.setPosition();
                oModalList.childNodes[0].onclick();
            }
        }
        function frame_refresh()
        {
            lastModul.modalPanel.contentWindow.location.reload(true);
        }        
    </script>

    <script type="text/javascript">
        var initmap = document.initmap = function () { };
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD6gIDzA2LtGhqeG_AOtZBXbWdqZSxESYA&callback=initmap&libraries=places"></script>
    <script>
        document.google = google;
    </script>
</body>
</html>
