<%@ Control Language="C#" ClassName="priviledge" %>

<script runat="server">

</script>

<style type="text/css">
    .menulist ul
    {
        list-style-type: none;                 
    }
</style>

<table style="width:auto;">
    <tr>
        <td style="vertical-align:top;">
            <div style="padding:0 20px 0 20px;overflow:auto;height:350px;border: thin solid #CCCCCC;border-radius: 3px 3px 3px 3px;">
                <table class="gridView" style="width:auto; border:0px" id="wucprivelege_grouplist">
                    <tr>
                        <th style="width:25px"></th>
                        <th style="text-align:left">Group</th>
                    </tr>
                </table>    
            </div>
        </td>
        <td style="vertical-align:top;">
            <label id="wucPrivilege_Name" style="font-weight:bold;padding-left:20px;background: -o-linear-gradient(top, #D4D4D4, #C0C0C0);"></label>
            <div style="padding:0 20px 0 20px;overflow:auto;height:330px;border: thin solid #CCCCCC;border-radius: 3px 3px 3px 3px;">
                <table class="gridView" style="width:auto; border:0px">                    
                    <tr>
                        <td><div id="wucprivelege_menu" class="menulist"></div></td>
                    </tr>                    
                </table>                
            </div>
            <input type="button" value="Save" id="wucPrivilege_btnsave" style="margin-left:20px;margin-top:5px;"/>
        </td>
    </tr>
</table>    


<script type="text/javascript">
    var intGroupID;
    var wucPrivilege = {
        btnSave: apl.func.get("wucPrivilege_btnsave"),
        menuList: apl.func.get("wucprivelege_menu"),
        tbl: apl.createTableWS.init("wucprivelege_grouplist",
            [
                apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "edit"), apl.createTableWS.attribute("title", "edit")],
                    function (data) {
                        intGroupID = data.GroupID;
                        document.getElementById("wucPrivilege_Name").innerHTML = data.GroupName;
                        tool.getMenuPriviledgeXML(data.GroupID,
                            function (data) {
                                wucPrivilege.menuList.innerHTML = data;
                                wucPrivilege.btnSave.Show();

                            }, apl.func.showError, "");
                    }
                ),
                "GroupName"
            ]
        ),
        load: function () {
            tool.appGroupList("",
                function (data) {
                    wucPrivilege.tbl.load(data);
                    wucPrivilege.btnSave.Hide();
                }, apl.func.showError, ""
            );
        }
    }

    wucPrivilege.btnSave.onclick = function () {
        apl.func.showSinkMessage("simpan");

        var cblist = document.getElementsByName("cbmenu");
        var checked = [];
        for (var i = 0; i < cblist.length; i++) {
            if (cblist[i].checked) checked[checked.length] = cblist[i].value;
        }
        tool.appGroupPrivilegeSave(intGroupID, checked,
            function () {                
                apl.func.hideSinkMessage();
            }, apl.func.showError, ""
        );
    }
    function setPrivilege(obj) {
        if (obj.checked) checkedUpper(obj);
        if (!obj.checked) uncheckedDowner(obj);

    }
    function checkedUpper(oCB) {
        oCB.checked = true;
        var Li_parent = oCB.parentNode.parentNode.parentNode;
        if (Li_parent.tagName == "LI") {
            var _oCB = Li_parent.getElementsByTagName("INPUT");
            checkedUpper(_oCB[0]);
        }
    }
    function uncheckedDowner(oCB) {
        oCB.checked = false;
        var LI_parent = oCB.parentNode;
        var UL = LI_parent.getElementsByTagName("UL")[0];
        if (UL != undefined) {
            var LI_list = UL.getElementsByTagName("LI");
            for (var i = 0; i < LI_list.length; i++) {
                var _oCB = LI_list[i].getElementsByTagName("INPUT")[0];
                uncheckedDowner(_oCB);
            }
        }
    }
</script>