<%@ Control Language="C#" ClassName="wuc_group" %>

<script runat="server">

</script>

<div style="padding: 5px;overflow:auto;height:400px;">
    
     
    <table class="gridView" id="wucgroup_List">
        <tr>
            <th style="width:25px;"><div class="tambah" title="tambah" onclick="wucGroup.tambah()"></div></th>
            <th style="width:25px;"></th>
            <th style="text-align:left;">Group</th>        
        </tr>        
    </table>
</div>

<div id="wucGroup_modal" class="modal">
    <fieldset>
        <legend>Group</legend>
        <table class="formview">
            <tr>
                <th style="width:100px;">Name</th>
                <td><input type="text" id="wucGroup_Name" size="25" maxlength="25"/></td>
            </tr>
        </table>
        <div style="padding-top:5px;">
            <input type="button" value="Save"/>
            <input type="button" value="Cancel"/>
        </div>
    </fieldset>
</div>


<script type="text/javascript">


    //public variabel
    var modal_group;
    var wucGroup;
    var intGroupID;
    var pv = document.getElementById("wucgroup_List").parentElement;

    wucGroup = {
        list: apl.createTableWS.init("wucgroup_List",
            [
                apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "edit"), apl.createTableWS.attribute("title", "edit")],
                    function (data) {
                        modal_group.showEdit('Group - Edit');
                        intGroupID = data.GroupID;
                        modal_group.tbName.value = data.GroupName;
                        apl.func.validatorClear("group_simpan");
                    }
                ),
                apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "hapus"), apl.createTableWS.attribute("title", "hapus")],
                    function (data) {
                        if (confirm("Yakin akan dihapus?")) {
                            tool.appGroupDelete(data.GroupID, function () {
                                wucGroup.refresh();
                            }, apl.func.showError, "");
                        }
                    }
                ),
                "GroupName"
            ]
        ),
        tambah: function () {
            modal_group.showEdit("Group - Tambah");
            modal_group.tbName.value = "";
            intGroupID = 0;
            apl.func.validatorClear("group_simpan");
        },
        refresh: function () {
            modal_group.hide();
            wucGroup.load();

        },
        load: function () {
            var st = pv.scrollTop;
            tool.appGroupList("",
                function (data) {
                    wucGroup.list.load(data);

                    pv.scrollTop = st;
                }, apl.func.showError, "");
        }
    }

    modal_group = apl.createModal("wucGroup_modal",
        {
            tbName: apl.func.get("wucGroup_Name"),
            valName: apl.createValidator("group_simpan", "wucGroup_Name", function () { return apl.func.emptyValueCheck(modal_group.tbName.value);}, "Invalid Input")
        },
        undefined,
        function () {
            if (apl.func.validatorCheck("group_simpan")) {
                tool.appGroupSave(intGroupID, modal_group.tbName.value, function () {
                    wucGroup.refresh();
                }, apl.func.showError, "");
            }
        },
        undefined,
        "frm_page",
        "cover_content"
    );

    
</script>