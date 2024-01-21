<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page" %>

<script runat="server">
    public _test.App a;

    void Page_Load(object o, EventArgs e)
    {
        a = new _test.App(Request, Response);
    }
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
            <th style="width:100px;">Tanggal</th>
            <td><input type="text" id="cari_date" size="10" maxlength="10" style="float:left;" value="<%= a.cookieApplicationDateValue %>"/></td> 
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.load();">Cari</div></td>
        </tr>        
    </table>
    <table class="gridView" id="tbl" style="width:100%;">
        <tr>
            <th style="width:25px;"></th>
            <th>Kurir</th>
        </tr>
    </table>

    <div id="mdl" class="modal">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Kurir</th>
                    <td><span id="mdl_messanger"></span></td>
                </tr>
            </table>
            <table class="gridView" style="width:100%;" id="mdl_tbl">
                <tr>
                    <th style="width:25px;"><div class="tambah" onclick="mdl_rute.tambah();"></div></th>
                    <th>Rute</th>
                </tr>
            </table>
            <div class="button_panel">
                <input type="button" value="Delete" />
                <input type="button" value="Close" />
            </div>
        </fieldset>
    </div>

    <div class="modal" id="mdl_rute">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Rute Awal</th>
                    <td><select id="mdl_rute_begin"></select></td>
                </tr>
                <tr>
                    <th>Rute Akhir</th>
                    <td><select id="mdl_rute_end"></select></td>
                </tr>
                <tr>
                    <th></th>
                    <td><div style="width:600px;height:400px" id="mdl_rute_map"></div></td>
                </tr>
            </table>
            <div class="button_panel">
                <input type="button" value="Delete" />
                <input type="button" value="Cancel" />
            </div>
        </fieldset>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var cari = {
            tb_date: apl.createCalender("cari_date"),
            tbl: apl.createTableWS.init("tbl",
                [
                     apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "edit")], function (data) { mdl.edit(data.messanger_id, data.messanger_name, data.latitude, data.longitude); }, undefined, undefined),
                    apl.createTableWS.column("messanger_name")
                ]
            ),
            load:function()
            {
                activities.exp_schedule_messanger(cari.tb_date.value,
                    function (arrData)
                    {
                        cari.tbl.load(arrData);
                    }, apl.func.showError, ""
                );
            }
        }

        var mdl = apl.createModal("mdl",
            {
                messanger_id: 0,
                latitude: "",
                longitude: "",
                arr_beginend: [],
                lb_messanger: apl.func.get("mdl_messanger"),
                set_beginend:function()
                {
                    mdl.arr_beginend = [];                    
                    apl.func.createSelectOption(mdl.arr_beginend, "", "Free")
                    apl.func.createSelectOption(mdl.arr_beginend, mdl.latitude + "," + mdl.longitude, mdl.lb_messanger.innerHTML);
                    apl.func.createSelectOption(mdl.arr_beginend, sessionStorage.getItem("lat") + "," + sessionStorage.getItem("lng"), "HQ");
                },
                edit: function (messanger_id, messanger_name, latitude, longitude)
                {
                    mdl.messanger_id = messanger_id;
                    mdl.lb_messanger.innerHTML = messanger_name;
                    mdl.latitude = latitude;
                    mdl.longitude = longitude;
                    mdl.showEdit("Rute Kurir - Edit");
                    mdl.set_beginend();
                }
            }, undefined, undefined, undefined, "frm_page", "cover_content"
        );

        var mdl_rute = apl.createModal("mdl_rute",
            {
                ddl_begin: apl.func.get("mdl_rute_begin"),
                ddl_end: apl.func.get("mdl_rute_end"),
                tambah:function()
                {
                    apl.func.createDropdownListFromArray("mdl_rute_begin", mdl.arr_beginend);
                    apl.func.createDropdownListFromArray("mdl_rute_end", mdl.arr_beginend);
                    mdl_rute.showAdd("Rute Kurir - Tambah");
                    //mdl_rute.ddl_begin.options.ins
                    
                }
            }, undefined, undefined, undefined, "frm_page", "mdl"
        );

        apl.func["createDropdownListFromArray"] = function (strID, arr_data) {
            var o = apl.func.get(strID);

            if (o == undefined) {
                alert("object :" + strID + " tidak ditemukan");
                return null;
            }
            if (arr_data == undefined) {
                alert("data tidak ditemukan");
                return null;
            }

            o.clearItem = function () {
                var o = this;
                for (var ctr = o.childNodes.length - 1; ctr >= 0; ctr--) {
                    o.removeChild(o.childNodes[ctr]);
                }
            }

            o.clearItem();
            
            for (var i in arr_data) {
                o.appendChild(apl.func.createOption(arr_data[i].value, arr_data[i].text));
            }            
            return o;
        }
        apl.func["createSelectOption"]=function(arr,_value,_text)
        {
            //return { value: _value, text: _text };
            arr.push({ value: _value, text: _text });
        }
    </script>
</asp:Content>

