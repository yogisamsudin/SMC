<%@ Control Language="C#" ClassName="wuc_user"  %>

<script runat="server">

</script>

<div style="padding: 5px;overflow:auto;height:390px;">
    <iframe src="menugroupuser_user_list.aspx" class="frameList" id="wucUser_frame_list"></iframe>
</div>

<div id="wucuser_modal" class="modal">
    <fieldset>
        <legend>User</legend>
        <table class="formview">
            <tr>
                <th style="width:100px;">User ID</th>
                <td><input type="text" id="wucuser_ID" size="15" maxlength="15" autocomplete="off"/></td>
            </tr>
            <tr>
                <th style="width:100px;">User Name</th>
                <td><input type="text" id="wucuser_Name" size="50" maxlength="50" autocomplete="off"/></td>
            </tr>
            <tr>
                <th style="width:100px;">Password</th>
                <td>
                    <input type="password" id="wucuser_Sandi" size="15" maxlength="15" autocomplete="off"/>
                    <i id="wucuser_sandititle">Kosongkan jika password tidak diganti</i>
                </td>
            </tr>
            <tr>
                <th style="width:100px;">Active</th>
                <td><input type="checkbox" id="wucuser_Active" /></td>
            </tr>
            <tr>
                <th style="width:100px;">Group</th>
                <td><select id="wucuser_Group"></select></td>
            </tr>
            <tr>
                <th>Cabang</th>
                <td><select id="wucuser_cabang"></select></td>
            </tr>
        </table>
        <div style="padding-top:5px;">
            <input type="button" value="Add"/>
            <input type="button" value="Save"/>
            <input type="button" value="Delete"/>
            <input type="button" value="Cancel"/>
        </div>
    </fieldset>
</div>

<script type="text/javascript">
    

    var strPassing = "";
    var wucuser_id_val_add = apl.createValidator("user_simpan", "wucuser_ID", function () { return apl.func.emptyValueCheck(modal_User.tbUserID.value); }, "Field harus diisi");
    var wucuser_sandi_val_add = apl.createValidator("user_simpan", "wucuser_Sandi", function () { return apl.func.emptyValueCheck(modal_User.status == 0 && modal_User.tbUserSandi.value); }, "Field harus diisi");
    var wucuser_Group_ddl = apl.createDropdownWS("wucuser_Group", tool.appGroupList, "GroupID", "GroupName");
    
    var wucUser = document.wucUser = {
        list: document.getElementById("wucUser_frame_list"),        
        refreshData: function () {
            wucUser.list.contentWindow.location.reload(true);
        }
    }

    var modal_User = apl.createModal("wucuser_modal",
        {
            status: 0,
            tbUserID: apl.func.get("wucuser_ID"),
            tbUserName: apl.func.get("wucuser_Name"),
            tbUserSandi: apl.func.get("wucuser_Sandi"),
            cbUserActive: apl.func.get("wucuser_Active"),
            ddlUserGroup: apl.func.get("wucuser_Group"),
            ddlcabang: apl.createDropdownWS("wucuser_cabang", tool.par_branch_list),
            iSandiTitle: apl.func.get("wucuser_sandititle"),
            tambah:function()
            {
                modal_User.status = 0;
                modal_User.showAdd('User - Add');
                modal_User.tbUserID.value = "";
                modal_User.tbUserID.disabled = false;
                modal_User.tbUserName.value = "";
                modal_User.tbUserSandi.value = "";
                modal_User.cbUserActive.checked = true;
                modal_User.ddlcabang.setValue("", "");
                apl.func.validatorClear("user_simpan");
                modal_User.iSandiTitle.Hide();
            },
            edit:function(UserID)
            {
                modal_User.status = 1;
                apl.func.validatorClear("wucuser_add");                
                modal_User.tbUserID.value = UserID;
                modal_User.tbUserID.disabled = true;                
                modal_User.iSandiTitle.Show();
                apl.func.validatorClear("user_simpan");
                apl.func.showSinkMessage("Loading");
                tool.appUserByUserID(UserID,
                    function (data) {
                        modal_User.tbUserName.value = data.UserName;
                        modal_User.tbUserSandi.value = "";
                        modal_User.cbUserActive.checked = data.Active;                        
                        modal_User.ddlUserGroup.setValue(data.GroupID);
                        modal_User.ddlcabang.setValue(data.branch_id, data.branch_name);

                        apl.func.hideSinkMessage();
                        modal_User.showEdit("User - Edit");
                    }, apl.func.showError, ""
                );
            }
        },
        function () {
            if (apl.func.validatorCheck("user_simpan")) {
                apl.func.showSinkMessage("Simpan");
                tool.appUserSave(modal_User.tbUserID.value, modal_User.tbUserSandi.value, modal_User.ddlUserGroup.value, modal_User.cbUserActive.checked, modal_User.tbUserName.value,modal_User.ddlcabang.value,
                    function () {
                        modal_User.hide();
                        wucUser.refreshData();
                        apl.func.hideSinkMessage();
                    }, apl.func.showError, ""
                );
            }            
        },
        function () {
            if (apl.func.validatorCheck("user_simpan")) {
                apl.func.showSinkMessage("Simpan");
                tool.appUserSave(modal_User.tbUserID.value, modal_User.tbUserSandi.value, modal_User.ddlUserGroup.value, modal_User.cbUserActive.checked, modal_User.tbUserName.value, modal_User.ddlcabang.value,
                    function () {
                        modal_User.hide();
                        wucUser.refreshData();
                        apl.func.hideSinkMessage();
                    }, apl.func.showError, ""
                );
            }
        },
        function () {
            if (confirm("Yakin didelete?")) {
                apl.func.showSinkMessage("Simpan");
                tool.appUserDelete(modal_User.tbUserID.value,
                function () {
                    modal_User.hide();
                    wucUser.refreshData();
                    apl.func.hideSinkMessage();
                }, apl.func.showError, ""
                );
            }
        },
        "frm_page",
        "cover_content"
    );
    
    document.list_edit = modal_User.edit;
    document.list_tambah = modal_User.tambah;
</script>