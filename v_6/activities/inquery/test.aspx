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

        <table class="formview">
        <tr>
            <th>Customer</th>
            <td><input type="text" size="100" id="tbcustomer" autocomplete="off"/></td>
        </tr>
        <tr>
            <th></th>
            <td><input type="text" id="myInput" placeholder="Ketik sesuatu..."/></td>
        </tr>
        <tr>
            <th></th>
            <td><label id="lbinfo"></label></td>
        </tr>

    </table>


    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        apl["create_auto_complete_text_new"] = function (str_id, func_ws, func_add_button, int_width, func_select, func_where, str_value_code, str_text_code) {
            var lebar = (int_width) ? int_width : 400;
            var o = {
                input: apl.func.get(str_id),
                panel: undefined,

                input_active: false,

                row_active: undefined,
                last_active: undefined,
                arr_data: [],

                text: "",
                id: "",

                function_ws: func_ws,
                function_select: func_select,
                //str_where: (str_where == undefined) ? "" : str_where,
                f_where: func_where,
                str_value_code: (str_value_code == undefined) ? "value" : str_value_code,
                str_text_code: (str_text_code == undefined) ? "text" : str_text_code,

                set_value: function (value, text) {
                    o.value = text;
                    o.input.value = text;
                    o.text = text;
                    o.id = value;
                },
                timer: undefined,
                loadingsts: false,

            };

            if (o.input == undefined) {
                alert("Undefined object id='" + str_id + "'");
                return null;
            }
            if (!(o.input.tagName == "INPUT" && o.input.type == "text")) {
                alert("Invalid 'INPUT TEXT' tag name from id:" + str_id);
                return null;
            }

            o.input.setAttribute("style", "float:left");
            o.input.style.width = lebar.toString() + "px";

            o.input.addEventListener("focus", function () {
                o.row_active = undefined;
                o.input_active = true;
            });

            o.input.addEventListener("focusout", function () {
                o.input.value = o.text;
                o.input_active = false;
                if (o.panel.mouse_over == false) o.panel.hide(); else return false;
            });

            o.input.addEventListener("input", function () {
                o.text = "";
                o.id = "";
                o.row_active = undefined;
                o.panel.hide();

                //penambahan
                clearTimeout(o.timer);
                o.timer = setTimeout(function () { o.panel.show(); o.panel.load(o.input.value); }, 2000);
                //penambahan
            });
            //KEYDOWN
            o.input.addEventListener("keydown", function (event) {
                
                if (event.keyCode == 13) {
                    if (o.row_active == undefined) {
                        o.panel.show();
                        o.panel.load(this.value);
                    } else {
                        o.set_value(o.arr_data[o.row_active].id, o.arr_data[o.row_active].title);
                        o.arr_data[o.row_active].onclick();
                        o.row_active = undefined;
                        o.panel.hide();
                    }
                    return;
                }
                if (event.keyCode == 27) {
                    o.panel.hide();
                    o.row_active = undefined;
                    return;
                }
                //goes up
                if (event.keyCode == 38) {
                    if (o.arr_data.length > 0) {
                        if (o.row_active == undefined) o.row_active = 0; else if (o.row_active > 0) o.row_active--;

                        if (o.last_active) o.last_active.style.backgroundColor = "inherit";
                        o.last_active = o.arr_data[o.row_active];
                        o.last_active.style.backgroundColor = "lightgray";
                        o.last_active.scrollIntoView(true);
                    }
                } else
                    //goes down
                    if (event.keyCode == 40) {
                        if (o.arr_data.length > 0) {
                            if (o.row_active == undefined) o.row_active = 0; else if (o.row_active < o.arr_data.length - 1) o.row_active++;

                            if (o.last_active) o.last_active.style.backgroundColor = "inherit";
                            o.last_active = o.arr_data[o.row_active];
                            o.last_active.style.backgroundColor = "lightgray";
                            o.last_active.scrollIntoView(false);
                        }
                    } else {

                    }
            });
            //KEYPRESS
            o.panel = {
                open_status: true,
                mouse_over: false,

                div: document.createElement("DIV"),
                table: document.createElement("TABLE"),
                show: function () {
                    o.panel.open_status = true;
                    o.row_active = undefined;
                    o.last_active = undefined;
                    o.arr_data = [];

                    o.panel.div.style.visibility = "visible";
                    apl.func.table.clearRowAll(o.panel.table, 0);
                },
                hide: function () {
                    o.panel.open_status = false;
                    o.panel.div.style.visibility = "hidden";
                },
                //penambahan script
                load: function (nilai) {
                    if (o.loadingsts == false)
                    {
                        o.loadingsts = true;

                        var tbl = o.panel.table;
                        var fws = o.function_ws;
                        var fs = o.function_select;
                        var val = o.str_value_code;
                        var txt = o.str_text_code;
                        //var sw = o.str_where;
                        var sw = (o.f_where == undefined) ? "" : o.f_where();
                        apl.func.table.clearRowAll(tbl, 0);
                        fws(sw, nilai,
                            function (arr_data) {
                                o.arr_data = [];

                                for (var i in arr_data) {
                                    var span = document.createElement("SPAN");
                                    span.innerHTML = arr_data[i][txt].substring(0, 50);
                                    span.title = arr_data[i][txt];
                                    span.id = arr_data[i][val];
                                    span.data = arr_data[i];
                                    span.onclick = function () {
                                        //alert(arr_data[i].other_value);
                                        o.set_value(this.id, this.title);
                                        //if (fs != undefined) fs(arr_data[i]);
                                        if (fs != undefined) fs(this.data);
                                        o.panel.hide();
                                    }
                                    apl.func.table.insertRow(tbl, [apl.func.table.insertCell([span])]);
                                    o.arr_data.push(span);
                                }

                                o.loadingsts = false;
                            },
                            apl.func.showError, ""
                        );
                    }
                    
                }
            }

            o.panel.div.setAttribute("class", "auto_complete_text_live");
            o.panel.div.setAttribute("style", "width:" + (lebar + 6 + 11).toString() + "px;margin-top:27px;");
            o.panel.div.open_status = false;
            o.panel.div.addEventListener("mouseover", function () { o.panel.mouse_over = true; });
            o.panel.div.addEventListener("mouseout", function () { o.panel.mouse_over = false; if (o.input_active == false) o.panel.hide(); });
            o.panel.div.appendChild(o.panel.table);

            var p = o.input.parentNode;

            var l = document.createElement("label");
            l.title = "Tekan enter untuk melihat daftarnya"

            if (p.childNodes[2]) p.insertBefore(l, p.childNodes[2]); else p.appendChild(l);

            p.appendChild(o.panel.div);
            p.setAttribute("class", "auto_complete_text");

            if (func_add_button) {
                o.add_button = {
                    div: document.createElement("DIV")
                }
                o.add_button.div.setAttribute("class", "tambah");
                o.add_button.div.setAttribute("style", "float:left;");
                o.add_button.div.setAttribute("title", "Tambah item");
                o.add_button.div.addEventListener("click", func_add_button);
                p.appendChild(o.add_button.div);
            }
            return o;
        }

        //var tb_customer = apl.func.get("tbcustomer");
        //alert(apl.create_auto_complete_text);
        var tb_customer = apl.create_auto_complete_text_new("tbcustomer", activities.ac_customer, function () { alert("tambah"); }, 600, function (data) { alert(JSON.stringify(data)); });
        document.getElementById("frm_page").addEventListener("submit", function (e) { e.preventDefault(); });

        let timer; // variabel untuk menyimpan timeout

        document.getElementById("myInput").addEventListener("input",
            function () {
                clearTimeout(timer); // reset kalau masih dalam proses
                timer = setTimeout(myFunction, 2000);
            }
        );

        var lb_info = apl.func.get("lbinfo");
        function myFunction() {
            var s = lb_info.innerHTML;
            lb_info.innerHTML = s + "a";
        }
        </script>
</asp:Content>

