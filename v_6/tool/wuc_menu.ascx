<%@ Control Language="C#" ClassName="wuc_menu" %>

<script runat="server">

</script>

<style type="text/css">
    .listMenu
    {
            
        padding:0;margin:0;
    }
    .listMenu ul
    {
        list-style-type: none;                                    
    }
    .listMenu li
    {
        clear:both;                  
    }
    .listMenu li > div:hover
    {
        background: -webkit-linear-gradient(top, #FFFFFF, #EEEEEE);
        background: -moz-linear-gradient(top, #FFFFFF, #EEEEEE);
        background: -o-linear-gradient(top, #FFFFFF, #EEEEEE);
    }
    .listMenu li div div
    {
        float:left;
        border:thin solid transparent;          
        visibility:hidden;              
    }
    .listMenu li div:hover > div
    {
        visibility:visible;
    }
    .listMenu a
    {
        cursor:pointer;                      
    }
    
    
</style>

<div class="listMenu" id="divMenu"></div>

<div id="wucmenu_modal">
    <fieldset>
        <legend style="">Menu</legend>
        <table style="" class="formview">
            <tr>
                <th style="width:100px">Urutan</th>
                <td ><input type="text" id="wucmenu_tbUrutan" size="2" maxlength="2" autocomplete="off"/></td>
            </tr>
            <tr>
                <th>Inisial</th>
                <td ><input type="text" id="wucmenu_tbMenuInisial" size="3" maxlength="3" autocomplete="off"/></td>
            </tr>
            <tr>
                <th>Nama Menu</th>
                <td ><input type="text" id="wucmenu_tbMenuName" size="35" maxlength="35" autocomplete="off"/></td>
            </tr>
            <tr>
                <th>Path</th>
                <td><input type="text" id="wucmenu_tbUrl" size="60" maxlength="100" autocomplete="off"/></td>
            </tr>
        </table>        
        <div style="padding-top:5px;">
            <input type="button" value="Add"/>
            <input type="button" value="Save"/>
            <input type="button" value="Cancel"/>
        </div>
    </fieldset>
</div>


<script type="text/javascript">
    var pv_menu = document.getElementById("divMenu").parentElement;

    var wucMenu = {
        loadMenuList: function ()
        {
            var st = pv_menu.scrollTop;
            var listMenu = document.getElementById("divMenu");
            listMenu.innerHTML = 'loading...';           

            tool.appMenu_generate_xml_menu(
            function (xml) {
                listMenu.innerHTML = xml;
                pv_menu.scrollTop = st;
                //tab.render();
            },
            apl.func.showError, "");
        }
    }

    var modal_menu;
    var intMenuID;
    var wucmenu_urutan_numeric = apl.createNumeric("wucmenu_tbUrutan", false);

    modal_menu = apl.createModal("wucmenu_modal",
        {
            tbUrutan: apl.func.get('wucmenu_tbUrutan'),
            tbInisial: apl.createTextUpper('wucmenu_tbMenuInisial'),
            tbName: apl.func.get('wucmenu_tbMenuName'),
            tbUrl: apl.func.get('wucmenu_tbUrl')
        },
        function () {
            
                tool.appMenuAdd(modal_menu.tbName.value, modal_menu.tbUrl.value, intMenuID, modal_menu.tbUrutan.value, modal_menu.tbInisial.value,
                    function () {
                        modal_menu.hide();
                        wucMenu.loadMenuList();
                    }, apl.func.showError, "");
            
        },
        function () {
            //MenuID, MenuName, MenuURL, Urutan,
            
            
            tool.appMenuSave(intMenuID, modal_menu.tbName.value, modal_menu.tbUrl.value, modal_menu.tbUrutan.value, modal_menu.tbInisial.value,
                    function () {
                        modal_menu.hide();
                        wucMenu.loadMenuList();
                    }, apl.func.showError, ""
                );
            
        },
        undefined,
        "frm_page",
        "cover_content"
    );

    function clickMenuTambah(obj, id) {
        modal_menu.showAdd("Menu - Add");
        modal_menu.tbUrutan.value = '1';
        modal_menu.tbInisial.value = '';
        modal_menu.tbName.value = '';
        modal_menu.tbUrl.value = '';

        intMenuID = id;
    }
    function clickMenuEdit(obj, id) {
        intMenuID = id;
        modal_menu.showEdit("Menu - Edit #"+id);
        tool.appMenuByMenuID(id,
            function (data) {
                modal_menu.tbUrutan.value = data.MenuUrut;
                modal_menu.tbInisial.value = data.Initial;
                modal_menu.tbName.value = data.MenuName;
                modal_menu.tbUrl.value = data.MenuUrl;
            }, apl.func.showError, ""
        );
    }
    function clickMenuHapus(obj, id) {
        if (confirm('Yakin akan dihapus?')) {
            tool.appMenudelete(id,
                function () {
                    wucMenu.loadMenuList();
                }, apl.func.showError, ""
            );
        }
    }

    window.addEventListener("load", wucMenu.loadMenuList);    
</script>