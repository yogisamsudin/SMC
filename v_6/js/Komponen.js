var $$get = function (str_id) {
    return document.getElementById(str_id);
}

var apl = {};
apl.func = {}; //apl function library
apl.native = {}; //apl native library
apl.pubvar = {};//variable
/*
apl.pubvar["intScrollY"] = undefined;//simpan nilai scroll y
apl.pubvar["BodyContent"] = undefined;//simpan object body content
apl.pubvar["form"] = undefined; //simpan object form
*/
apl.pubvar["spaceHeader"] = 0; //simpan nilai tinggi menu
apl.pubvar["ready"] = {};//daftar function yang akan di load pada window onload

(function () {
    //$
    apl.func["create_object_url_from_arr"] = function (arr_data, str_type) {
        let arr_uint8array = Uint8Array.from(arr_data);
        let file = new Blob([arr_uint8array.buffer], { type: str_type });
        return URL.createObjectURL(file);
    }

    apl.func["read_file_readAsArrayBuffer"] = function (file, f_getdata) {
        let fr = new FileReader();

        fr.onload = function (e) {
            let myBuffer = e.target.result;
            let typedArray = new Uint8Array(myBuffer);
            arr = Array.from(typedArray);
            if (f_getdata) f_getdata(arr);
        }
        fr.readAsArrayBuffer(file);
    }

    /*
    sample
    var ofil = apl.create_selectfile("o_file1",function(e){
            let file = e.target.files[0];

            let fr = new FileReader();
            fr.onload=function(el){
                document.getElementById("o_img").src=el.target.result;
            }
            fr.readAsDataURL(file);
        });
    */
    apl["create_selectfile"] = function (id, func_input) {
        let o = document.getElementById(id);
        let arr;
        let files;

        if (!(o.tagName == "INPUT" && o.type == "file")) {
            alert("HTML Error, tagName harus INPUT dan Type harus file");
            return null;
        }

        function read_file(file) {
            let fr = new FileReader();

            fr.onload = function (e) {
                let myBuffer = e.target.result;
                let typedArray = new Uint8Array(myBuffer);
                arr = Array.from(typedArray);
            }
            fr.readAsArrayBuffer(file);
        }

        if (o.files.length > 0) {
            files = o.files[0];
            read_file(files);
        }

        o.addEventListener("input", function (e) {
            files = e.target.files[0];
            read_file(files);
        });

        if (func_input != undefined) o.addEventListener("input", func_input);

        return {
            element: o,

            check_file:function()
            {
                return (files) ? true : false;
            },
            get_total: function () {
                return this.element.files.length;
            },
            get_array: function () {
                if (this.get_total() == 0) return null;
                return arr;
            },
            get_file: function () {
                return files;
            },
            get_info: function () {
                return {
                    name: files.name,
                    type: files.type,
                    size: files.size
                }
            }
        }
    }
    /*
    sample
    var dd = apl.func.createDropdownStd("dd",Report.generateDataDDL, "value", "text", undefined, "v_rpt_daftar_tahun","value desc");
    */
    apl.func["createDropdownStd"] = function (id, funcWS, field_value, field_text, condition, source, orderby) {
        var str_OptionValue, str_OptionText, str_Condition, str_OrderBy;

        var o = apl.func.get(id);

        if (o == undefined) {
            alert("object :" + str_id + " tidak ditemukan");
            return undefined;
        }

        if (o.tagName != "SELECT") {
            alert("object : '" + id + "' bukan tag SELECT");
            return undefined;
        }

        if (funcWS == undefined) {
            alert("Invalid function WS");
            return undefined;
        }

        str_OptionValue = (field_value == undefined) ? "value" : field_value;
        str_OptionText = (field_text == undefined) ? "text" : field_text;
        str_Condition = (condition == undefined) ? "" : condition;
        str_OrderBy = (orderby == undefined) ? "" : orderby;

        if (source == undefined) {
            alert("Source undefined");
            return undefined;
        }

        o.clearItem = function () {
            for (var ctr = o.childNodes.length - 1; ctr >= 0; ctr--) {
                o.removeChild(o.childNodes[ctr]);
            }
        }

        //alert("select " + str_OptionValue + "," + str_OptionText + " from " + source + str_Condition);

        funcWS(str_OptionValue, str_OptionText, str_Condition, source, str_OrderBy,
            function (arrData) {
                o.clearItem();
                for (var i in arrData) {
                    o.appendChild(apl.func.createOption(arrData[i][str_OptionValue], arrData[i][str_OptionText]));
                }
            }, apl.func.showError, ""
        );

        return o;
    }
    
    /*
    sample  
        var tanggal = "<%= a.ApplicationDate %>";
        var apl.createCalenderRange("cari_prd", tanggal, tanggal);
    */
    apl["createCalenderRange"] = function (str_id, defTgl1, defTgl2) {

        var o = apl.func.get(str_id);

        if (o == undefined) {
            alert("Invalid DOM object : " + str_id);
            return null;
        }
        if (o.tagName != "DIV") {
            alert(str_id + " Invalid DIV object");
            return null;
        }
        var createTgl = function (id) {
            var _o = document.createElement("input");
            _o.setAttribute("id", id);
            _o.setAttribute("type", "text");
            _o.setAttribute("size", "10");
            return _o;
        }
        var createSpan = function (text) {
            var _o = document.createElement("label");
            _o.innerHTML = text;
            _o.setAttribute("style", "padding-left:5px;padding-right:5px;");
            return _o;
        }
        var createCheckBoxAll = function () {
            var _o = document.createElement("input");
            _o.setAttribute("type", "checkbox");
            _o.onclick = function () {
                if (this.checked) {
                    o.PanelPeriode.style.width = "0px";
                } else {
                    o.PanelPeriode.style.width = "300px";
                }
            }
            return _o;
        }
        var createDivStatus = function () {
            var _o = document.createElement("div");
            _o.setAttribute("class", "DatePeriodeAllStatus");
            var cbAll = o.Status = createCheckBoxAll();
            _o.appendChild(cbAll);
            _o.appendChild(createSpan("   All"));
            return _o;
        }
        var createDivPeriode = function () {
            var _o = o.PanelPeriode = document.createElement("div");
            _o.setAttribute("class", "DatePeriode");
            _o.style.width = "300px";
            var periode1 = o.periode1 = createTgl(str_id + "_tgl1");
            var periode2 = o.periode2 = createTgl(str_id + "_tgl2")

            _o.appendChild(periode1);
            _o.appendChild(createSpan("to"));
            _o.appendChild(periode2);
            return _o;
        }

        o.periode1 = undefined;
        o.periode2 = undefined;
        o.PanelPeriode = undefined;
        o.status = undefined;

        o.appendChild(createDivStatus());
        o.appendChild(createDivPeriode());

        apl.createCalender(str_id + "_tgl1");
        apl.createCalender(str_id + "_tgl2");

        if (defTgl1 != undefined) o.periode1.value = defTgl1;
        if (defTgl2 != undefined) o.periode2.value = defTgl2;

        o.getValue = function (int_number) {
            var no;
            if (int_number == undefined) {
                no = 1;
            } else {
                no = int_number;
            }
            if (no == 1) {
                return ((o.Status.checked) ? "" : o.periode1.value);
            } else {
                return ((o.Status.checked) ? "" : o.periode2.value);
            }
        }

        return o;
    }
    //$
    /*
    sample  var n = apl.createRange("num", 1, 25,1);       
    */
    apl["createTextUpper"] = function (str_id) {
        o = apl.func.get(str_id);

        o.onkeyup = function () {
            var kata = this.value;
            this.value = kata.toUpperCase();
        }

        return o;
    }
    apl["createRange"] = function (str_id, min, max, step) {
        var o = apl.func.get(str_id);
        if (o == undefined) {
            alert('object: "' + str_id + '" tidak ditemukan');
            return undefined;
        }
        var pr = o.parentNode;
        var div = document.createElement("div");
        var r = document.createElement("input");

        if (min == undefined) min = 1;
        if (max == undefined) max = 10;
        if (step == undefined) step = 1;
        o.onkeypress = function (event) {
            var chCode = ('charCode' in event) ? event.charCode : event.keyCode;
            var re = new RegExp("[0-9.]");
            o.caret = o.selectionStart;
            o.pass = re.test(String.fromCharCode(chCode));
            o.chCode = chCode;

            if (chCode > 0) {
                return o.pass;
            }
        }
        o.oninput = function () {
            var nilai = parseInt((this.value == "") ? min : this.value);
            if (nilai < max) {
                r.value = nilai;
            }
        }

        o.setValue = function (nilai) {
            this.value = nilai;
            r.value = nilai;
        }

        div.setAttribute("class", "range");

        r.setAttribute("type", "range");
        r.setAttribute("min", min);
        r.setAttribute("max", max);
        r.setAttribute("step", step);
        r.setAttribute("value", min);
        r.oninput = function () {
            o.value = r.value;
        }

        div.appendChild(o);
        div.appendChild(r);
        pr.appendChild(div);
        return o;
    }
    //$
    /*
    create table web service
    samples:
    var tbl = apl.createTableWS.init("mPavorit_tbl",
            [
                apl.createTableWS.column("", "",[ apl.func.createAttribute("class","edit")], function (data) {
                    alert(data.MenuId);
                }, false),
                apl.createTableWS.column("MenuName")
            ]
        );
    */
    apl["createTableWS"] = {
        init: function (str_id, arr_columns) {
            //var o = document.getElementById(str_id);
            var o = apl.func.get(str_id);
            if (o == null) {
                alert("object : " + str_id + " tidak ditemukan");
                return undefined;
            }
            if (arr_columns == undefined) {
                alert("array column undefined");
                return undefined;
            }
            o.arr_columns = arr_columns;
            o.headerLength = o.rows.length;
            o.clearAllRow = function () {
                var _t = this;
                for (var i = _t.rows.length - 1; i > _t.headerLength - 1; i--) {
                    _t.deleteRow(i);
                }
            }
            o.load = function (arr_data) {
                var t = this;
                o.clearAllRow();
                if (arr_data == undefined || arr_data.length == 0) return;
                if (arr_columns.length == 0) return;
                //cek struktur data
                var fieldName;
                for (var i in t.arr_columns) {
                    fieldName = (typeof (t.arr_columns[i]) == "string") ? t.arr_columns[i] : t.arr_columns[i].fieldID;
                    if (arr_data[0][fieldName] == undefined && fieldName != "") {
                        alert('field : ' + fieldName + ' tidak ditemukan');
                        return undefined;
                    }
                }

                var datum;
                var coldata;

                for (var r in arr_data) {
                    var row = document.createElement("TR");
                    datum = arr_data[r];
                    row.datum = datum;
                    for (var c in arr_columns) {
                        var col = document.createElement("TD");
                        coldata = t.arr_columns[c];
                        if (coldata.jenisElement == undefined) {
                            var odiv = document.createElement("div");

                            if (typeof (coldata) == "string") {
                                odiv.innerHTML = datum[coldata];
                            } else {
                                if (coldata.arrAttribute != undefined) {
                                    for (var a in coldata.arrAttribute) {
                                        odiv.setAttribute(coldata.arrAttribute[a].name, coldata.arrAttribute[a].value);
                                    }
                                }

                                if (datum[coldata.fieldID] != undefined) odiv.innerHTML = datum[coldata.fieldID];
                                if (coldata.stsFormatNumber) odiv.innerHTML = apl.func.formatNumeric(odiv.innerHTML);
                                if (coldata.onclickFunction != undefined) {
                                    odiv.onclickFunction = coldata.onclickFunction;
                                    odiv.datum = datum;
                                    odiv.onclick = function () {
                                        this.onclickFunction(this.datum);
                                    }
                                }
                            }

                            col.appendChild(odiv);
                            row.appendChild(col);
                        } else {
                            var elm = document.createElement(coldata.jenisElement);
                            if (coldata.arrAttribute != undefined) {
                                for (var a in coldata.arrAttribute) {
                                    elm.setAttribute(coldata.arrAttribute[a].name, coldata.arrAttribute[a].value);
                                }
                            }
                            if (coldata.fieldID != undefined || coldata.fieldID != "") {
                                if (elm.innerHTML == undefined) {
                                    if (coldata.stsFormatNumber) {
                                        elm.value = apl.func.formatNumeric(datum[coldata.fieldID]);
                                    } else {
                                        elm.value = datum[coldata.fieldID];
                                    }
                                } else {
                                    if (coldata.stsFormatNumber) {
                                        elm.innerHTML = apl.func.formatNumeric(datum[coldata.fieldID]);
                                    } else {
                                        elm.innerHTML = datum[coldata.fieldID];
                                    }
                                }
                            }
                            if (coldata.special != undefined) {
                                elm.value = "";
                                elm.innerHTML = "";
                                //elm[coldata.special] = datum[coldata.fieldID];
                                if (coldata.special.split(".").length == 1) {
                                    elm[coldata.special.split(".")[0]] = datum[coldata.fieldID];
                                } else {
                                    elm[coldata.special.split(".")[0]][coldata.special.split(".")[1]] = datum[coldata.fieldID];
                                }
                            }
                            if (coldata.onclickFunction != undefined) {
                                elm.onclickFunction = coldata.onclickFunction;
                                elm.datum = datum;
                                elm.onclick = function () {
                                    this.onclickFunction(this.datum);
                                }
                            }
                            if (coldata.funcSpecial != undefined) {
                                coldata.funcSpecial(elm, datum);
                            }
                            col.appendChild(elm);
                            row.appendChild(col);
                        }
                    }
                    o.appendChild(row);
                }
            }
            return o;
        },
        column: function (str_FieldID, str_tdStyle, arr_attribute, func_OnClick, boo_FormatNumber, str_jenis_element, str_special, func_special) {
            var ret = {};
            ret.fieldID = str_FieldID;
            ret.tdStyle = str_tdStyle;
            ret.onclickFunction = func_OnClick;
            ret.stsFormatNumber = boo_FormatNumber;
            ret.arrAttribute = arr_attribute;
            ret.jenisElement = str_jenis_element;
            ret.special = str_special;
            ret.funcSpecial = func_special;
            return ret;
        },
        attribute: function (str_name, str_value) {
            var atr = {};
            atr.name = str_name;
            atr.value = str_value;
            return atr;
        }
    }
    //$
    //fungsi untuk membuat object modal
    /* sample
        var modal_group = apl.createModal("wucGroup_modal",
            {
                tbID:apl.func.get("wucGroup_ID"),
                tbName:apl.func.get("wucGroup_Name"),
            },
            undefined,
            function () {
                alert('Save');
            },
            undefined,
            "modalContent",
            "bodyContent"
        );
    */
    apl["createModal"] = function (str_id, object_Properti, func_Add, func_Save, func_Delete, str_parent_id, str_cover_id) {
        var o = document.getElementById(str_id);
        if (o == undefined) {
            alert('object id: "' + str_id + '" tidak ditemukan');
            return null;
        }
        var p = o.p = (str_parent_id == undefined) ? o.parentNode : document.getElementById(str_parent_id);
        if (p == undefined) alert('parent id: ' + str_parent_id + ' pada modul id: "' + str_id + '" tidak ditemukan');
        var c = o.c = (str_cover_id == undefined) ? o.parentNode : document.getElementById(str_cover_id);
        if (c == undefined) alert('cover id: ' + str_cover_id + ' pada modul id: "' + str_id + '" tidak ditemukan');

        var l = o.getElementsByTagName("LEGEND");
        if (o.className == "" || o.className == undefined) o.className = "modal";
        if (l.length > 0) o.legend = l[0];
        if (object_Properti != undefined) for (var i in object_Properti) o[i] = object_Properti[i];

        var div = document.createElement("div");
        div.style.backgroundColor = "white";
        div.style.opacity = "0.25";
        div.style.top = "0";
        div.style.left = "0";
        div.style.height = "100%";
        div.style.position = "absolute";
        div.style.width = "100%";
        div.style.display = "none";
        c.appendChild(div);
        o.converDiv = div;
        c.oldPosition = c.style.position;

        o.coverActivated = function () {
            c.intScrollY = 0 - window.scrollY;
            c.style.top = "-" + window.scrollY.toString() + "px";
            c.style.left = "50px";
            c.style.position = "fixed";
            c.style.width = "100%";
            o.converDiv.style.display = "block";
            window.scroll(0, 0);
        }
        o.coverDeactivated = function () {
            c.style.width = "";
            c.style.top = "";
            c.style.opacity = "";
            c.style.backgroundColor = "";
            c.style.left = "";
            c.style.position = c.oldPosition;
            window.scroll(0, 0 - c.intScrollY);
            o.converDiv.style.display = "none";
        }
        o.btnAdd = undefined;
        o.btnSave = undefined;
        o.btnDelete = undefined;
        o.btnCancel = undefined;
        o.btnHide = undefined;
        o.btnClose = undefined;
        var i = o.getElementsByTagName("INPUT");
        var f_cancel_onclick = function () {
            o.style.display = "none";
            o.coverDeactivated();
        }

        for (var j = 0; j < i.length; j++) {
            if (i[j].type == "button") {
                switch (i[j].value.toLowerCase()) {
                    case "add":
                        o.btnAdd = i[j];
                        apl.func.initVisual(o.btnAdd);
                        o.btnAdd.onclick = func_Add;
                        break;
                    case "save":
                        o.btnSave = i[j];
                        apl.func.initVisual(o.btnSave);
                        o.btnSave.onclick = func_Save;
                        break;
                    case "delete":
                        o.btnDelete = i[j];
                        apl.func.initVisual(o.btnDelete);
                        o.btnDelete.onclick = func_Delete;
                        break;
                    case "cancel":
                        o.btnCancel = i[j];
                        apl.func.initVisual(o.btnCancel);
                        o.btnCancel.onclick = f_cancel_onclick;
                        break;
                    case "hide":
                        o.btnHide = i[j];
                        o.btnHide.onclick = f_cancel_onclick;
                        break;
                    case "close":
                        o.btnClose = i[j];
                        apl.func.initVisual(o.btnClose);
                        o.btnClose.onclick = f_cancel_onclick;
                        break;
                }

            }
        }
        o.showAdd = function (legend) {
            o.coverActivated();
            o.style.display = "block";
            if (o.btnCancel != undefined) o.btnCancel.show();
            if (o.legend != undefined) o.legend.innerHTML = legend;
            if (o.btnAdd != undefined) o.btnAdd.show();
            if (o.btnDelete != undefined) o.btnDelete.hide();
            if (o.btnSave != undefined) o.btnSave.hide();
        }
        o.showEdit = function (legend) {
            o.coverActivated();
            o.style.display = "block";
            if (o.btnCancel != undefined) o.btnCancel.show();
            if (o.legend != undefined) o.legend.innerHTML = legend;
            if (o.btnAdd != undefined) o.btnAdd.hide();
            if (o.btnDelete != undefined) o.btnDelete.show();
            if (o.btnSave != undefined) o.btnSave.show();
        }
        o.show = function (legend) {
            o.coverActivated();
            o.style.display = "block";
        }
        o.hide = f_cancel_onclick;
        p.appendChild(o);
        return o;
    }
    apl["create_modal"] = function (str_id, object_Properti, func_Add, func_Save, func_Delete, str_parent_id, str_cover_id) {
        var o = document.getElementById(str_id);
        if (o == undefined) {
            alert('object id: "' + str_id + '" tidak ditemukan');
            return null;
        }
        var p = o.p = (str_parent_id == undefined) ? o.parentNode : document.getElementById(str_parent_id);
        if (p == undefined) alert('parent id: ' + str_parent_id + ' pada modul id: "' + str_id + '" tidak ditemukan');
        var c = o.c = (str_cover_id == undefined) ? o.parentNode : document.getElementById(str_cover_id);
        if (c == undefined) alert('cover id: ' + str_cover_id + ' pada modul id: "' + str_id + '" tidak ditemukan');

        var l = o.getElementsByTagName("LEGEND");
        if (o.className == "" || o.className == undefined) o.className = "modal";
        if (l.length > 0) o.legend = l[0];
        o.prop = {};
        if (object_Properti != undefined) for (var i in object_Properti) o.prop[i] = object_Properti[i];

        var div = document.createElement("div");
        div.style.backgroundColor = "white";
        div.style.opacity = "0.25";
        div.style.top = "0";
        div.style.left = "0";
        div.style.height = "100%";
        div.style.position = "absolute";
        div.style.width = "100%";
        div.style.display = "none";
        c.appendChild(div);
        o.converDiv = div;
        c.oldPosition = c.style.position;

        o.coverActivated = function () {
            c.intScrollY = 0 - window.scrollY;
            c.style.top = "-" + window.scrollY.toString() + "px";
            c.style.left = "50px";
            c.style.position = "fixed";
            c.style.width = "100%";
            o.converDiv.style.display = "block";
            window.scroll(0, 0);
        }
        o.coverDeactivated = function () {
            c.style.width = "";
            c.style.top = "";
            c.style.opacity = "";
            c.style.backgroundColor = "";
            c.style.left = "";
            c.style.position = c.oldPosition;
            window.scroll(0, 0 - c.intScrollY);
            o.converDiv.style.display = "none";
        }
        o.btnAdd = undefined;
        o.btnSave = undefined;
        o.btnDelete = undefined;
        o.btnCancel = undefined;
        o.btnHide = undefined;
        o.btnClose = undefined;
        var i = o.getElementsByTagName("INPUT");
        var f_cancel_onclick = function () {
            o.style.display = "none";
            o.coverDeactivated();
        }

        for (var j = 0; j < i.length; j++) {
            if (i[j].type == "button") {
                switch (i[j].value.toLowerCase()) {
                    case "add":
                        o.btnAdd = i[j];
                        apl.func.initVisual(o.btnAdd);
                        o.btnAdd.onclick = func_Add;
                        break;
                    case "save":
                        o.btnSave = i[j];
                        apl.func.initVisual(o.btnSave);
                        o.btnSave.onclick = func_Save;
                        break;
                    case "delete":
                        o.btnDelete = i[j];
                        apl.func.initVisual(o.btnDelete);
                        o.btnDelete.onclick = func_Delete;
                        break;
                    case "cancel":
                        o.btnCancel = i[j];
                        apl.func.initVisual(o.btnCancel);
                        o.btnCancel.onclick = f_cancel_onclick;
                        break;
                    case "hide":
                        o.btnHide = i[j];
                        o.btnHide.onclick = f_cancel_onclick;
                        break;
                    case "close":
                        o.btnClose = i[j];
                        apl.func.initVisual(o.btnClose);
                        o.btnClose.onclick = f_cancel_onclick;
                        break;
                }

            }
        }
        o.showAdd = function (legend) {
            o.coverActivated();
            o.style.display = "block";
            if (o.btnCancel != undefined) o.btnCancel.show();
            if (o.legend != undefined) o.legend.innerHTML = legend;
            if (o.btnAdd != undefined) o.btnAdd.show();
            if (o.btnDelete != undefined) o.btnDelete.hide();
            if (o.btnSave != undefined) o.btnSave.hide();
        }
        o.showEdit = function (legend) {
            o.coverActivated();
            o.style.display = "block";
            if (o.btnCancel != undefined) o.btnCancel.show();
            if (o.legend != undefined) o.legend.innerHTML = legend;
            if (o.btnAdd != undefined) o.btnAdd.hide();
            if (o.btnDelete != undefined) o.btnDelete.show();
            if (o.btnSave != undefined) o.btnSave.show();
        }
        o.show = function (legend) {
            o.coverActivated();
            o.style.display = "block";
        }
        o.hide = f_cancel_onclick;
        p.appendChild(o);
        return o;
    }
    /*
    apl["createFormModal"] = function (str_id, object_Properti, func_Add, func_Save, func_Delete) {
        var o = document.getElementById(str_id);
        var l = o.getElementsByTagName("LEGEND");
        if (o.className == "" || o.className == undefined) o.className = "form_modul";
        if (l.length > 0) o.legend = l[0];
        if (object_Properti != undefined) for (var i in object_Properti) o[i] = object_Properti[i];

        var i = o.getElementsByTagName("INPUT");
        var f_cancel_onclick = function () {
            o.style.display = "none";
            apl.func.clearFormModul();
        }
        for (var j = 0; j < i.length; j++) {
            if (i[j].type == "button") {
                switch (i[j].value.toLowerCase()) {
                    case "add":
                        o.btnAdd = i[j];
                        apl.func.initVisual(o.btnAdd);
                        o.btnAdd.onclick = func_Add;
                        break;
                    case "save":
                        o.btnSave = i[j];
                        apl.func.initVisual(o.btnSave);
                        o.btnSave.onclick = func_Save;
                        break;
                    case "delete":
                        o.btnDelete = i[j];
                        apl.func.initVisual(o.btnDelete);
                        o.btnDelete.onclick = func_Delete;
                        break;
                    case "cancel":
                        o.btnCancel = i[j];
                        o.btnCancel.onclick = f_cancel_onclick;
                        break;
                    case "hide":
                        o.btnHide = i[j];
                        o.btnHide.onclick = f_cancel_onclick;
                        break;
                    case "close":
                        o.btnClose = i[j];
                        o.btnClose.onclick = f_cancel_onclick;
                        break;
                }
            }
        }
        o.showAdd = function (legend) {
            apl.func.setFormModul();
            o.style.display = "block";
            window.scroll(0, 0);
            if (o.legend != undefined) o.legend.innerHTML = legend;
            if (o.btnAdd != undefined) o.btnAdd.show();
            if (o.btnDelete != undefined) o.btnDelete.hide();
            if (o.btnSave != undefined) o.btnSave.hide();
        }
        o.showEdit = function (legend) {
            apl.func.setFormModul();
            o.style.display = "block";
            window.scroll(0, 0);
            if (o.legend != undefined) o.legend.innerHTML = legend;
            if (o.btnAdd != undefined) o.btnAdd.hide();
            if (o.btnDelete != undefined) o.btnDelete.show();
            if (o.btnSave != undefined) o.btnSave.show();
        }
        o.hide = f_cancel_onclick;

        var f = apl.pubvar.form;
        f.appendChild(o);

        return o;
    }
    */
    //$
    apl["createTab"] = function (arr_tab) {
        if (arr_tab == undefined) {
            alert("arr tab tidak ditemukan");
            return null;
        }

        var element_parent;
        var div_tabcontrol = apl.func.createElement("div", [apl.func.createAttribute("class", "tabcontrol")]);
        var div_tabpanel = apl.func.createElement("div");
        var ul = apl.func.createElement("ul");
        var firstLI;


        div_tabcontrol.appendChild(div_tabpanel);
        div_tabcontrol.appendChild(ul);

        for (var i in arr_tab) {
            var div = document.getElementById(arr_tab[i].id);

            var li = apl.func.createElement("li", [apl.func.createAttribute("class", "tabunactive")], undefined, undefined,
            {
                funconclick: arr_tab[i].onclick,
                panel: div,
                onclick: function () {
                    element_parent.lastLI.className = "tabunactive";
                    this.className = "tabactive";

                    element_parent.lastDiv.style.display = "none";
                    this.panel.style.display = "block";

                    element_parent.lastDiv = this.panel;
                    element_parent.lastLI = this;

                    if (this.funconclick !== undefined) {
                        this.funconclick(this.panel);
                    }
                }
            }
        );

            var li_div1 = apl.func.createElement("div", [apl.func.createAttribute("class", "antiblock")]);
            var li_div2 = apl.func.createElement("label", undefined, arr_tab[i].name);
            li.appendChild(li_div1);
            li.appendChild(li_div2);

            if (i == 0) {
                element_parent = document.getElementById(arr_tab[i].id).parentNode;
                firstLI = li;
                div.style.display = "block";
                element_parent.lastDiv = div;
                element_parent.lastLI = li;
            } else {
                div.style.display = "none";
            }

            if (element_parent != undefined) { element_parent[arr_tab[i].id] = div; }

            ul.appendChild(li);
            div_tabpanel.appendChild(div);

        }

        element_parent.appendChild(div_tabcontrol);

        //jalankan tab pertama dan fungsinya
        firstLI.className = "tabactive";
        if (firstLI.funconclick !== undefined) {
            firstLI.funconclick(firstLI.panel);
        }
        return element_parent;
    }
    //$
    apl["createWatermark"] = function (element, watermarkMessage) {
        var o = element;
        if (o.type == undefined) {
            alert("Bukan element input");
            return null;
        }
        if (!(o.type == "text" || o.type == "password")) {
            alert("Element harus berupa type text dan password");
            return null;
        }
        o._inputType = o.type;
        o.setValueEmpty = function () {
            this.value = watermarkMessage;
            this.style.color = "#DADADA";
            this.setAttribute("type", "text");
        }
        o.checkValueEmpty = function () {
            return (this.value == watermarkMessage);
        }
        o.onfocus = function () {
            if (this.checkValueEmpty()) {
                o.value = "";
                o.style.color = null;
                this.setAttribute("type", this._inputType);
            }
        }
        o.onblur = function () {
            if (apl.func.emptyValueCheck(this.value)) {
                o.setValueEmpty();
            }
        }
        o.getValue = function () {
            if (o.checkValueEmpty()) {
                return "";
            } else {
                return o.value;
            }
        }
        o.setValueEmpty();
        return o;
    }
    //apl["createValidator"] = function (str_GroupName, elm_Triger, func_Validation, str_Message) {
    /*
    sample
        var wucuser_id_val_add = apl.createValidator("wucuser_add", "wucuser_ID", function () { return apl.func.emptyValueCheck(modal_User.tbUserID.value); }, "Field harus diisi");
    */
    apl["createValidator"] = function (str_GroupName, str_id, func_Validation, str_Message) {
        //var o = elm_Triger;
        var o = document.getElementById(str_id);
        var p = o.parentNode;
        var d = apl.func.createElement("div");
        d.setAttribute("class", "valMessage");
        d.setAttribute("name", str_GroupName);
        d.innerHTML = "!";
        d.funcValidation = func_Validation;
        d.Show = function () { this.style.display = "block"; }
        d.Hide = function () { this.style.display = "none"; }
        d.onclick = function () { this.Hide(); }
        var dd = apl.func.createElement("div");
        dd.innerHTML = "<span>Pesan:</span><br>" + "<label>" + ((str_Message == undefined) ? "" : str_Message) + "</label>";
        d.appendChild(dd);
        p.insertBefore(d, o);
        return o;
    }
    /*
    apl["__createElement"] = function (str_tag, arr_Atr, str_innerHTML, arr_Element,object_Properti) {
        var o = document.createElement(str_tag);
        if (str_innerHTML != undefined) o.innerHTML = str_innerHTML;
        if (arr_Atr != undefined) {
            for (var i in arrAtr) {
                o.setAttribute(arr_Atr[i].name, arr_Atr[i].value);
            }
        }
        if (arr_Element != undefined) {
            for (var i in arr_Element) {
                o.appendChild(arr_Element[i]);
            }
        }
        if (object_Properti !== undefined) for (var i in object_Properti) o[i] = object_Properti[i];
        return o;
    }
    */
    apl["createCalender"] = function (str_id, object_Properti) {
        var o = apl.func.get(str_id);
        o.readOnly = true;
        apl.native.calender.f_SetObjectToCalender(o);
        if (object_Properti !== undefined) for (var i in object_Properti) o[i] = object_Properti[i];
        return o;
    }
    /*
    apl["createModule"] = function (str_id, str_legendID, str_btnAddID, str_btnEditID, str_btnDeleteID, str_btnCancelID, func_add, func_Edit, func_delete, object_Properti) {
        var o = apl.func.get(str_id);
        if (o == undefined) {
            alert("Modal ID :'" + str_id + "', tidak ditemukan...");
            return undefined;
        }
        o.native = {
            legend: apl.func.get(str_legendID),
            btnAdd: apl.func.get(str_btnAddID),
            btnEdit: apl.func.get(str_btnEditID),
            btnDelete: apl.func.get(str_btnDeleteID),
            btnCancel: apl.func.get(str_btnCancelID),
            p: o.parentNode
        }

        if (o.native.btnAdd != undefined) {
            o.native.btnAdd.onclick = func_add;
        }
        if (o.native.btnEdit != undefined) {
            o.native.btnEdit.onclick = func_Edit;
        }
        if (o.native.btnDelete != undefined) {
            o.native.btnDelete.onclick = func_delete;
        }
        if (o.native.btnCancel != undefined) {
            o.native.btnCancel.onclick = function () {
                o.style.display = "none";
            }
        }

        o.ShowAdd = function (title) {
            if (o.native.btnAdd != undefined) {
                o.native.btnAdd.style.display = "";                
            }
            if (o.native.btnCancel != undefined) {
                o.native.btnCancel.style.display = "";
            }
            if (o.native.btnEdit != undefined) {
                o.native.btnEdit.style.display = "none";
            }
            if (o.native.btnDelete != undefined) {
                o.native.btnDelete.style.display = "none";
            }

            o.style.display = "block";

            if (o.native.legend != undefined) {
                o.native.legend.innerHTML = title;
            }

            o.style.height = document.offsetHeight.toString() + "px";
        }

        o.ShowEdit = function (title) {

            if (o.native.btnAdd != undefined) {
                o.native.btnAdd.style.display = "none";
            }
            if (o.native.btnCancel != undefined) {
                o.native.btnCancel.style.display = "";
            }
            if (o.native.btnEdit != undefined) {
                o.native.btnEdit.style.display = "";
            }
            if (o.native.btnDelete != undefined) {
                o.native.btnDelete.style.display = "";
            }

            o.style.display = "block";

            if (o.native.legend != undefined) {
                o.native.legend.innerHTML = title;
            }

            o.style.height = document.offsetHeight.toString() + "px";
        }
        o.Hide = function () {
            o.style.display = "none";
        }

        if (object_Properti !== undefined) {
            for (var i in object_Properti) {
                o[i] = object_Properti[i];
            }
        }

        return o;
    }
    */
    apl["createDropdownWS"] = function (str_id, func_WebService, str_OptionValue, str_OptionText, bol_OnFocus, func_Where, obj_Properti) {
        var o = apl.func.get(str_id);

        if (o == undefined) {
            alert("object :" + str_id + " tidak ditemukan");
            return undefined;
        }
        if (o.tagName != "SELECT") {
            alert("object :" + strID + " bukan tag SELECT");
            return undefined;
        }
        if (func_WebService == undefined) {
            alert("web function tidak ditemukan: ");
            return undefined;
        }
        if (str_OptionValue == undefined) {
            var str_OptionValue = "value";
        }
        if (str_OptionText == undefined) {
            var str_OptionText = "text";
        }
        if (obj_Properti != undefined) {
            for (var i in obj_Properti) {
                o[i] = obj_Properti[i];
            }
        }

        o.clearItem = function () {
            var o = this;
            for (var ctr = o.childNodes.length - 1; ctr >= 0; ctr--) {
                o.removeChild(o.childNodes[ctr]);
            }
        }
        o.statusOnFocus = bol_OnFocus;
        o.funcWS = func_WebService;
        o.fungWhere = func_Where;

        o.load = function (curVal) {
            var o = this;
            var strWhere;
            if (o.fungWhere == undefined) {
                strWhere = "";
            } else {
                if (o.fungWhere() == undefined || o.fungWhere() == "") strWhere = ""; else strWhere = " where " + o.fungWhere();
            }
            try {
                var selected = false;

                o.funcWS(strWhere,
                    function (arrData) {
                        o.clearItem();
                        for (var i in arrData) {
                            if (i == 0) curValue = arrData[i][str_OptionValue];
                            o.appendChild(apl.func.createOption(arrData[i][str_OptionValue], arrData[i][str_OptionText]));
                        }
                        if (curValue) o.value = curVal;

                    }, apl.func.showError, ""
                );
            }
            catch (e) {
                alert(e + "\n" + "sample function web service: function ( strwhere, function sukses, function error)");
            }
        }

        o.setValue = function (curValue) {
            var o = this;
            var opt = o.options;

            o.load(curValue);

            //if (o.statusOnFocus) o.load(curValue); else o.value = curValue;
        }

        //if (bol_OnFocus == undefined || bol_OnFocus == false) o.load("");

        if (bol_OnFocus == undefined) o.load(""); else o.addEventListener("focus", function () { o.load(o.value); });//o.onfocus = function () { o.load(o.value); };




        o.getText = function () {
            var curValue = o.value;
            var text = "";
            var opt = o.options;
            for (var i = 0; i < opt.length; i++) {
                if (opt[i].value == curValue) text = opt[i].text;
            }
            return text;
        }

        return o;
    }

    apl["createCharFiltering"] = function (str_id, filter) {
        var o = apl.func.get(str_id);

        o.str_filter = "[a-zA-Z0-9]";
        if (filter) o.str_filter = filter;


        o.onkeypress = function (event) {
            var chCode = ('charCode' in event) ? event.charCode : event.keyCode;
            var re = new RegExp(o.str_filter);

            if (chCode > 0) return re.test(String.fromCharCode(chCode));
            return true;
        }

        return o;
    }

    apl["createNumeric"] = function (str_id, bol_formatnumber, int_fixedvalue, obj_Properti) {
        var o = apl.func.get(str_id);
        if (o == undefined) {
            alert("Object: '" + id + "' tidak ditemukan");
        }
        o.fixedValue = (int_fixedvalue == undefined) ? 0 : int_fixedvalue;
        o.formatNumber = (bol_formatnumber == undefined) ? true : bol_formatnumber;
        o.caret = 0;
        o.pass = true;
        o.chCode = 0;

        o.onkeypress = function (event) {
            var chCode = ('charCode' in event) ? event.charCode : event.keyCode;
            var re = new RegExp("[0-9.]");
            o.caret = o.selectionStart;
            o.pass = re.test(String.fromCharCode(chCode));
            o.chCode = chCode;

            if (chCode > 0) {
                return o.pass;
            }
        }
        o.setValue = function (value) {
            o.value = apl.func.formatNumeric(value, o.fixedValue);
            return o.value;
        }
        o.getIntValue = function () {
            var value = parseFloat(o.value.replace(/,/g, ""));
            var ret = (value.toString() == "NaN") ? 0 : value;
            return ret;
        }
        o.setDecValue = function (value) {
            o.value = apl.func.formatNumeric(value, o.fixedValue);
        }
        o.onkeyup = function (event) {
            if (!o.formatNumber) return;
            var pass = (event.keyCode == 46 || event.keyCode == 8) ? true : false;
            if ((o.chCode > 0 && o.pass) || pass) {
                var l1 = o.value.length;
                if (l1 > 0) {
                    o.value = apl.func.formatNumeric(o.value, o.fixedValue);
                    var l2 = o.value.length;
                    var penambahan = (pass) ? l2 - l1 : 1 + l2 - l1;
                    o.selectionStart = o.selectionEnd = o.caret + penambahan;
                }
            }
        }
        if (obj_Properti !== undefined) for (var i in obj_Properti) o[i] = obj_Properti[i];
        return o;
    }

    apl["createAutoComplete"] = function (str_div_id, function_ws, int_width, function_click, strWhere, function_closed) {
        var o = apl.func.get(str_div_id);
        if (o == undefined) alert("Undefined object id='" + str_div_id + "'");
        if (o.tagName != "DIV") {
            alert("Invalid 'DIV' tag name from id:" + str_div_id);
            return null;
        }
        o.setAttribute("class", "autocomplete");
        o.getValue = function () {
            return this.value;
        }
        o.function_click = function_click;
        o.getText = function () {
            return this.innerHTML;
        }
        o.readonly = false;
        o.value = "";
        o.text = "";
        o.setValue = function (value, text) {
            o.value = this.value;
            o.text = this.innerHTML;
            o.innerHTML = this.innerHTML;
            o.oInput.value = this.innerHTML;
        }
        o.showPanel = function () {
            var o = this;
            if (o.readonly == false) {
                var t = apl.func.table;
                var d1 = o.AutoCompleteLive;
                var width = o.AutoCompleteLiveWidth - 50;
                o.AutoCompleteLiveGridPanel.Hide();
                o.oInput.value = o.getText();

                if (document.AutoCompleteElement) {
                    document.AutoCompleteElement = o;
                }

                d1.style.display = "block";
                d1.style.visibility = "visible";
                d1.style.marginLeft = "-10px";
                d1.style.marginTop = "-10px";
                d1.style.width = width.toString() + "px";
                d1.style.borderRadius = "3px 3px 3px 3px";
                d1.style.boxShadow = "0px 2px 1px 0px #7D7D7D";
                d1.style.padding = "3px";
                apl.func.setFocus(o.oInput);
            }
        }
        o.hidePanel = function () {
            var o = this;
            var d1 = o.AutoCompleteLive;
            var tg = o.AutoCompleteLiveGrid;
            o.AutoCompleteLiveGridPanel.Hide();

            d1.style.padding = "0px";
            d1.style.visibility = "hidden";
            d1.style.marginLeft = "0px";
            d1.style.marginTop = "0px";
            d1.style.width = "310px";
            d1.style.borderRadius = "0";
            d1.style.boxShadow = "";
        }
        o.setValue = function (value, text, showPanelSts) {
            this.value = value;
            this.text = text;
            this.innerHTML = text;
            if (showPanelSts) {
                this.showPanel();
            } else {
                this.hidePanel();
            }
        }
        o.AutoCompleteLiveWidth = int_width;
        o.function_ws = function_ws;

        o.onclick = function () {
            var o = this;
            if (o.disabled == false || o.disabled == undefined) o.showPanel();
        }
        o.createAutoCompleteLive = function () {
            var o = this;
            var p = this.parentNode;
            var d1 = o.AutoCompleteLive = document.createElement("DIV");
            d1.o = o;
            d1.setAttribute("class", "autocompletelive");
            p.insertBefore(d1, o);
            return d1;
        }

        o.createAutoCompleteLiveInput = function () {
            var o = this;
            var oInput = o.oInput = document.createElement("INPUT");
            oInput.o = o;
            oInput.setAttribute("type", "text");
            oInput.setFocus = apl.func.setFocus;
            oInput.onkeypress = function (event) {
                var o = this;
                if (event.keyCode == 13) {
                    o.o.oCari.onclick();
                }
            }
            return oInput;
        }

        o.databind = function (tg, data) {
            var t = apl.func.table;
            t.clearRowAll(tg);

            if (data.length > 0) {
                if (data[0].text == undefined) {
                    alert("invalid field 'text'");
                    return;
                }
                if (data[0].value == undefined) {
                    alert("invalid field 'value'");
                    return;
                }
            }

            for (var i in data) {
                var s = document.createElement("option");
                s.innerHTML = data[i].text;
                s.value = data[i].value;

                s.onclick = function () {
                    o.setValue(this.value, this.innerHTML);
                    o.hidePanel();
                    if (o.function_click) {
                        o.function_click(o.value, o.innerHTML);
                    }
                }

                t.insertRow(tg, [t.insertCell([s])]);
            }
            o.AutoCompleteLiveGridPanel.Show();
        }

        o.createAutoCompleteLiveCari = function () {
            var o = this;
            var oCari = o.oCari = document.createElement("DIV");
            oCari.o = o;
            oCari.setAttribute("class", "cari");
            oCari.onclick = function () {
                var o = this.o;
                var tg = o.AutoCompleteLiveGrid;
                var function_ws = o.function_ws;
                var oClose = o.oClose;
                var oInput = o.oInput;
                var _strWhere = (strWhere == undefined) ? "" : strWhere;
                function_ws(_strWhere, oInput.value,
                    function (data) {
                        /*
                        var t = apl.func.table;
                        t.clearRowAll(tg);
                        for (var i in data) {

                            var s = document.createElement("option");
                            if (data[i].text == undefined) {
                                alert("invalid field 'text'");
                            }
                            if (data[i].value == undefined) {
                                alert("invalid field 'value'");
                            }
                            s.innerHTML = data[i].text;
                            s.value = data[i].value;
                            s.onclick = function () {
                                o.setValue(this.value,this.innerHTML);
                                o.hidePanel();                                
                                if (o.function_click) {
                                    o.function_click(o.value, o.innerHTML);
                                }
                            }
                            t.insertRow(tg, [t.insertCell([s])]);
                        }
                        o.AutoCompleteLiveGridPanel.Show();
                        */
                        o.databind(tg, data);
                    },
                    apl.func.showError, ""
                );
            }

            return oCari;
        }
        o.createAutoCompleteLiveClose = function () {
            var o = this;
            var oCLose = o.oClose = document.createElement("DIV");

            oCLose.o = o;
            oCLose.setAttribute("class", "hapus");
            oCLose.setAttribute("style", "float:right");

            oCLose.onclick = function (selected) {
                var o = this.o;
                o.hidePanel();
                o.setValue("", "");
                if (function_closed) function_closed();
                /*
                var d1 = o.AutoCompleteLive;
                var tg = o.AutoCompleteLiveGrid;
                o.AutoCompleteLiveGridPanel.Hide();
                
                d1.style.padding = "0px";
                d1.style.visibility = "hidden";
                d1.style.marginLeft = "0px";
                d1.style.marginTop = "0px";
                d1.style.width = "310px";
                d1.style.borderRadius = "0";
                d1.style.boxShadow = "";
                */
            }
            return oCLose;
        }
        o.createAutoCompleteLiveMainTable = function () {
            var d1 = o.AutoCompleteLive;
            var oInput = o.oInput;
            var oCari = o.oCari;
            var oClose = o.oClose;
            var tu = o.AutoCompleteLiveMainTable = document.createElement("TABLE");
            tu.setAttribute("style", "width:100%;");
            d1.appendChild(tu);

            apl.func.table.insertRow(tu, [apl.func.table.insertCell([oInput], [apl.func.table.insertAttribute("style", "width:100%;")]), apl.func.table.insertCell([oCari]), apl.func.table.insertCell([oClose])]);
            return tu;
        }
        o.createAutoCompleteLiveGrid = function () {
            var o = this;
            var tu = o.AutoCompleteLiveMainTable;
            var tg = o.AutoCompleteLiveGrid = document.createElement("TABLE");
            var d2 = o.AutoCompleteLiveGridPanel = document.createElement("DIV");
            d2.Show = function () {
                this.style.display = "block";
            }
            d2.Hide = function () {
                this.style.display = "none";
            }
            d2.setAttribute("class", "autocompletelivegrid");
            d2.appendChild(tg);

            apl.func.table.insertRow(tu, [apl.func.table.insertCell([d2], [apl.func.table.insertAttribute("colspan", "3")])]);
        }

        o.createAutoCompleteLive(); //1
        o.createAutoCompleteLiveInput(); //2
        o.createAutoCompleteLiveCari(); //3
        o.createAutoCompleteLiveClose(); //4
        o.createAutoCompleteLiveMainTable(); //5
        o.createAutoCompleteLiveGrid();
        return o;
    }

    //$
    apl["create_auto_complete_text"] = function (str_id, func_ws, func_add_button, int_width, func_select, func_where, str_value_code, str_text_code) {
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
            }
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
        });

        o.input.addEventListener("keypress", function (event) {
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
            load: function (nilai) {
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
                    },
                    apl.func.showError, ""
                );
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
    //$
    apl["create_calender"] = function (id) {
        var func =
        {
            date_value: { thn: 0, bln: 0, tgl: 0, first_day: 0, last_date: 0 },
            set_date: function (_tgl, _bln, _thn) {
                var t = (_tgl.toString().length == 1) ? "0" + _tgl : _tgl.toString();
                var b = (_bln.toString().length == 1) ? "0" + _bln : _bln.toString();
                return t + "/" + b + "/" + _thn.toString();
            },
            arr_day: ["Ming", "Sen", "Sel", "Rab", "Kam", "Jum", "Sab"],
            arr_date: new Array(42),
            arr_month: [{ name: "Januari", obj: null }, { name: "Februari", obj: null }, { name: "Maret", obj: null }, { name: "April", obj: null }, { name: "Mei", obj: null }, { name: "Juni", obj: null }, { name: "Juli", obj: null }, { name: "Agustus", obj: null }, { name: "September", obj: null }, { name: "Oktober", obj: null }, { name: "November", obj: null }, { name: "Desember", obj: null }],
            arr_year: new Array(20),
            input: null,
            panel: null,
            header_month_lbl: null,
            header_year_lbl: null,
            date_panel: null,
            month_panel: null,
            year_panel: null,

            init: function () {
                var _o = func.input = apl.func.set_element(id);
                _o.readOnly = true;
                _o.addEventListener("click", func.open);
            },
            create_panel: function () {
                var _o = func.input;
                var _p = _o.parentNode;
                var _e = apl.func.create_element(_p, "DIV", { className: "calender_" });
                func.panel = _e;
            },
            create_header_panel: function () {
                var _p = func.panel;
                var _h = apl.func.create_element(_p, "DIV", { className: "calender_header" });
                func.header_month_lbl = apl.func.create_element(_h, "DIV", {
                    className: "calender_header_month",
                    onclick: function () {
                        func.render_month();
                        func.date_panel.hide();
                        func.month_panel.show();
                        func.year_panel.hide();
                    }
                });
                func.header_year_lbl = apl.func.create_element(_h, "DIV", {
                    className: "calender_header_year",
                    onclick: function () {
                        func.open_year();
                        func.date_panel.hide();
                        func.month_panel.hide();
                        func.year_panel.show();
                    }
                });
            },
            create_date_panel: function () {
                var _p = func.panel;
                _dp = apl.func.create_element(_p, "DIV", { className: "calender_panel_date" });
                var _t = apl.func.create_element(_dp, "TABLE");
                var _r = _t.insertRow();
                for (var i = 0; i < 7; i++) {
                    var _c = document.createElement("TH");
                    _c.innerHTML = func.arr_day[i];
                    _r.appendChild(_c);
                }
                var ctr = 0;
                for (var j = 0; j < 6; j++) {
                    var _r = _t.insertRow();
                    for (var i = 0; i < 7; i++) {
                        var _c = _r.insertCell();
                        _c.onclick = function () {
                            if (this.innerHTML != "") {
                                func.input.value = func.set_date(this.innerHTML, func.date_value.bln + 1, func.date_value.thn);
                                func.panel.hide();
                            }
                        }
                        func.arr_date[ctr] = _c;
                        ctr++;
                    }
                }

                func.date_panel = _dp;
            },
            create_month_panel: function () {
                var _p = func.panel;
                var _mp = apl.func.create_element(_p, "DIV", {
                    className: "calender_panel_month"
                });
                var _t = apl.func.create_element(_mp, "TABLE");
                var ctr = 0;
                for (var j = 0; j < 4; j++) {
                    var _r = _t.insertRow();
                    for (var i = 0; i < 3; i++) {
                        var _c = _r.insertCell();
                        _c.innerHTML = func.arr_month[ctr].name;
                        _c.bln = ctr;
                        _c.onclick = function () {
                            func.date_value.bln = this.bln;
                            func.header_month_lbl.innerHTML = this.innerHTML;
                            func.render_date();
                            func.month_panel.hide();
                            func.date_panel.show();
                        }
                        func.arr_month[ctr].obj = _c;
                        ctr++;
                    }
                }
                func.month_panel = _mp;
            },
            create_year_panel: function () {
                var _p = func.panel;
                var _yp = apl.func.create_element(_p, "DIV", {
                    className: "calender_panel_year"
                });

                var _t = apl.func.create_element(_yp, "TABLE");
                var _r = _t.insertRow();
                for (var j = 0; j < 4; j++) {
                    var _c = document.createElement("TH");
                    if (j == 1) {
                        _c.innerHTML = "◄";
                        _c.onclick = function () {
                            var start_year = parseInt(func.arr_year[0].innerHTML) - 20;
                            func.render_year(start_year);
                        }
                    }
                    if (j == 3) {
                        _c.innerHTML = "►";
                        _c.onclick = function () {
                            var start_year = parseInt(func.arr_year[0].innerHTML) + 20;
                            func.render_year(start_year);
                        }
                    }
                    _r.appendChild(_c);
                }
                var ctr = 0;
                for (var i = 0; i < 4; i++) {
                    var _r = _t.insertRow();
                    for (var j = 0; j < 5; j++) {
                        var _c = _r.insertCell();
                        _c.onclick = function () {
                            func.date_value.thn = parseInt(this.innerHTML);
                            func.header_year_lbl.innerHTML = this.innerHTML;
                            func.render_date();
                            func.date_panel.show();
                            func.month_panel.hide();
                            func.year_panel.hide();
                        }
                        func.arr_year[ctr] = _c;
                        ctr++;
                    }
                }
                func.year_panel = _yp;
            },
            open: function () {
                func.date_panel.show();
                func.month_panel.hide();
                func.year_panel.hide();

                var tanggal = func.input.value;
                var d;
                if (tanggal == "") {
                    d = new Date();
                } else {
                    d = new Date(tanggal.split("/")[2], tanggal.split("/")[1] - 1, tanggal.split("/")[0]);
                }
                func.date_value = { tgl: d.getDate(), bln: d.getMonth(), thn: d.getFullYear() };
                func.header_month_lbl.innerHTML = func.arr_month[func.date_value.bln].name;
                func.header_year_lbl.innerHTML = func.date_value.thn;

                func.render_date();
                func.panel.show();
            },
            render_date: function () {
                func.date_value.first_day = new Date(func.date_value.thn, func.date_value.bln, 1).getDay();
                func.date_value.last_date = new Date(func.date_value.thn, func.date_value.bln + 1, 0).getDate();

                var ctr = 0;
                var ctr_date = 1;
                for (var i = 0; i < 42; i++) {
                    func.arr_date[i].style.color = "";
                    func.arr_date[i].style.color = "";
                    func.arr_date[i].style.backgroundColor = "";
                    if (ctr >= func.date_value.first_day && ctr_date <= func.date_value.last_date) {
                        func.arr_date[i].innerHTML = ctr_date;
                        if (ctr_date == func.date_value.tgl) {
                            func.arr_date[i].style.color = "white";
                            func.arr_date[i].style.backgroundColor = "black";
                        }
                        ctr_date++;
                    } else func.arr_date[i].innerHTML = "";
                    ctr++;
                }
            },
            render_month: function () {
                for (var i = 0; i < 12; i++) {
                    if (func.arr_month[i].obj.innerHTML == func.header_month_lbl.innerHTML) {
                        func.arr_month[i].obj.style.color = "white";
                        func.arr_month[i].obj.style.backgroundColor = "black";
                    } else {
                        func.arr_month[i].obj.style.color = "";
                        func.arr_month[i].obj.style.backgroundColor = "";
                    }
                }
            },
            open_year: function () {
                var cur_year = func.date_value.thn;
                func.render_year(parseInt(cur_year / 20) * 20);
            },
            render_year: function (start_year) {
                for (var i = 0; i < 20; i++) {
                    if (i + start_year == func.header_year_lbl.innerHTML) {
                        func.arr_year[i].style.color = "white";
                        func.arr_year[i].style.backgroundColor = "black";
                    } else {
                        func.arr_year[i].style.color = "";
                        func.arr_year[i].style.backgroundColor = "";
                    }

                    func.arr_year[i].innerHTML = i + start_year;
                }
            },
            hidding: function () {

                window.addEventListener("click", function (e) {
                    if (apl.func.cek_parent(e.target, func.panel) == false && e.target != func.input) func.panel.hide();
                });
            }
        }

        func.init();
        func.create_panel();
        func.create_header_panel();
        func.create_date_panel();
        func.create_month_panel();
        func.create_year_panel();
        func.hidding();
        return func.input;
    }

})();

/*=*/
(function () {
    //$
    apl.func["create_element"] = function (_parent, element_name, arr_properties) {
        var e = document.createElement(element_name);
        apl.func.set_element(e);
        _parent.appendChild(e);
        if (arr_properties) {
            for (var i in arr_properties) {
                e[i] = arr_properties[i];
            }
        }
        return e;
    }
    //$
    apl.func["dateCompare"] = function (strDate1, strDate2, strCompare) {
        var hasil = true;
        var convertTanggal = function (strTanggal) {
            var tgl = strTanggal.split("/")[0];
            var bln = strTanggal.split("/")[1];
            var thn = strTanggal.split("/")[2];
            var tanggal = new Date();
            tanggal.setDate(tgl);
            tanggal.setMonth(bln);
            tanggal.setYear(thn);
            return tanggal;
        }
        var tgl1 = convertTanggal(strDate1);
        var tgl2 = convertTanggal(strDate2);
        switch (strCompare) {
            case "=": return tgl1 == tgl2;
            case ">": return tgl1 > tgl2;
            case "<": return tgl1 < tgl2;
            case ">=": return tgl1 >= tgl2;
            case "<=": return tgl1 <= tgl2;
        }

        return hasil;
    }
    //$
    apl.func["getFirstDateFromDate"] = function (strDate) {
        return strDate.replace(strDate.substring(0, 2), "01");
    }
    apl.func["HttpRequest"] = function (url, successMessage, ErrorMessage, succesFunction, errorFunction) {
        var req = new XMLHttpRequest();

        req.onreadystatechange = function () {
            if (req.readyState == 4) {
                if (req.status == 200) {
                    if (succesFunction != undefined) succesFunction();
                    alert(successMessage);
                } else {
                    alert(ErrorMessage + req.statusText);
                    if (errorFunction != undefined) errorFunction();
                }
            }
        }

        req.open("GET", url, true);
        req.send(null);
    }
    //$ 
    apl.func["setValidFileName"] = function (filename) {
        var fName = filename.replace(new RegExp('[</:*?"<>|]', 'g'), '-');
        return fName.replace(new RegExp(' ', 'g'), '');
    }
    //$
    apl.func["sendEmail"] = function (email, subject, body_message) {
        var mailto_link = 'mailto:' + email + '?subject=' + subject + '&body=' + body_message;
        win = window.open(mailto_link, 'emailWindow');
        if (win && win.open && !win.closed) {
            win.close();
        }
    }

    //fungsi untuk menerima daftar pada window onload
    /*
        sample
        apl.func.initReady("modulGroup", function () {
            ...script...
        });
    */

    apl.func["ready"] = function (script_f) {
        window.addEventListener("load", script_f);
    }

    apl.func["initReady"] = function (name, script_f) {
        apl.pubvar.ready[name] = script_f;
    }
    //$
    //fungsi untuk menggantikan window.onload
    /*
        sample
        window.onload=apl.func.windowOnload;
    */

    apl.func["windowOnload"] = function () {
        for (var i in apl.pubvar.ready) {
            apl.pubvar.ready[i]();
        }
    }
    /*
    //$
    //fungsi untuk menginisial form modul
    apl.func["initFormModul"] = function (str_bodycontentid) {
        apl.pubvar.BodyContent = document.getElementById(str_bodycontentid);
    }
    //$
    //fungsi untuk menset form modul
    apl.func["setFormModul"] = function () {
        var bc = apl.pubvar.BodyContent; //= document.getElementById(str_BodyContentID);
        apl.pubvar.intScrollY = window.scrollY;
        bc.style.position = "fixed";
        bc.style.top = "-" + apl.pubvar.intScrollY + "px";
        bc.style.width = "100%";
        bc.divCover = document.createElement("div");
        bc.divCover.className = "form_modul_bodycontent";
        bc.appendChild(bc.divCover);        
    }
    //$
    //fungsi untuk menghilangkan form modul
    apl.func["clearFormModul"] = function (str_BodyContentID) {
        var bc = apl.pubvar.BodyContent;
        bc.style.position = "static";
        bc.style.width = "";
        window.scroll(0, apl.pubvar.intScrollY);
        bc.style.opacity = "";
        bc.style.backgroundColor = "";
        bc.removeChild(bc.divCover);
    }
    //$
    //fungsi untuk menginisiasi object form
    apl.func["initForm"] = function (str_formid) {
        apl.pubvar.form = document.getElementById(str_formid);
    }
    */
    //$
    //fungsi untuk membuat properti visual pada object atau element
    apl.func["initVisual"] = function (o) {
        o.show = function () {
            o.style.display = "";
        }
        o.hide = function () {
            o.style.display = "none";
        }
    }

    //$
    //fungsi window resize
    apl.func["winresize"] = {
        listFunction: {},
        addFuncion: function (name, script) {
            apl.func.winresize.listFunction[name] = script;
        },
        executeFunction: function () {
            for (var i in apl.func.winresize.listFunction) {
                apl.func.winresize.listFunction[i]();
            }
        }
    };
    //$
    //fungsi buat object tab
    apl.func["createTab"] = function (str_DivID, str_TabTitle, func_OnClick) {
        var d = new function () {
            this.id = str_DivID;
            this.name = str_TabTitle;
            this.onclick = func_OnClick;
        }
        return d;
    }
    //$
    apl.func["get"] = function (id) {
        o = document.getElementById(id);
        if (o == undefined) {
            alert("undefined object id='" + id + "'");
            return undefined;
        } else {
            o.setFocus = function () {
                setTimeout(function () { o.focus(); }, 100);
            }
            o.Show = function () { this.style.display = ""; }
            o.Hide = function () { this.style.display = "none"; }
            return o;
        }
    }
    //$
    apl.func["validatorCheck"] = function (str_GroupName) {
        var arrValidator = document.getElementsByName(str_GroupName);
        var status = true;

        for (var i = 0; i < arrValidator.length; i++) {
            arrValidator[i].Hide();
            if (arrValidator[i].funcValidation != undefined) {
                if (arrValidator[i].funcValidation()) {
                    arrValidator[i].Show();
                    if (status) {
                        status = false;
                    }
                }
            }
        }
        return status;
    }
    //$
    apl.func["formatFileName"] = function (name) {
        return name.replace(/[ -]/g, '_');
    }
    //$
    apl.func["validatorClear"] = function (str_GroupName) {
        var arrValidator = document.getElementsByName(str_GroupName);
        for (var i = 0; i < arrValidator.length; i++) {
            arrValidator[i].Hide();
        }
    }
    //$
    apl.func["emptyValueCheck"] = function (value) {
        return /^$/.test(value);
    }
    //$ old object
    apl.func["createTable"] = function (id, arrObject) {
        var o = apl.func.get(id);
        o.clearRow = function (startRow) {
            try {
                for (var i = o.rows.length; i > startRow; i--) o.deleteRow(i - 1);
            } catch (e) {
                alert(e);
            }
        }
        o.createRow = function (arrCell, arrAtr) {
            var r = document.createElement("tr");
            if (arrAtr != undefined) for (var i in arrAtr) r.setAttribute(arrAtr[i].name, arrAtr[i].value);
            if (arrCell != undefined) for (var i in arrCell) r.appendChild(arrCell[i]);
            o.appendChild(r);
        }
        o.createGrid = function (startRow, arrData, f) {
            o.clearRow(startRow);
            if (f != undefined) for (var i in arrData) o.createRow(f(i));
        }
        if (arrObject !== undefined) for (var i in arrObject) o[i] = arrObject[i];
        return o;
    }
    //$
    apl.func["refreshDoc"] = function (eventTarget, eventArgument) {
        __doPostBack(eventTarget, eventArgument)
    }
    //$
    apl.func["createModule"] = function (moduleid, legendID, btnAddID, btnEditID, btnDeleteID, btnCancelID, arrObject, addFunction, EditFunction, deleteFunction) {
        //var o = document.getElementById(moduleid);
        var o = apl.func.get(moduleid);
        if (o == undefined) {
            alert("Modal ID :'" + moduleid + "', tidak ditemukan...");
            return undefined;
        }
        o.native = {
            legend: document.getElementById(legendID),
            btnAdd: document.getElementById(btnAddID),
            btnEdit: document.getElementById(btnEditID),
            btnDelete: document.getElementById(btnDeleteID),
            btnCancel: document.getElementById(btnCancelID),
            p: o.parentNode
        }

        if (o.native.btnAdd != undefined) {
            o.native.btnAdd.onclick = addFunction;
        }
        if (o.native.btnEdit != undefined) {
            o.native.btnEdit.onclick = EditFunction;
        }
        if (o.native.btnDelete != undefined) {
            o.native.btnDelete.onclick = deleteFunction;
        }
        if (o.native.btnCancel != undefined) {
            o.native.btnCancel.onclick = function () {
                o.style.display = "none";
            }
        }

        o.ShowAdd = function (title) {
            if (o.native.btnAdd != undefined) {
                o.native.btnAdd.style.display = "";
            }
            if (o.native.btnCancel != undefined) {
                o.native.btnCancel.style.display = "";
            }
            if (o.native.btnEdit != undefined) {
                o.native.btnEdit.style.display = "none";
            }
            if (o.native.btnDelete != undefined) {
                o.native.btnDelete.style.display = "none";
            }

            o.style.display = "block";

            if (o.native.legend != undefined) {
                o.native.legend.innerHTML = title;
            }

            o.style.height = document.offsetHeight.toString() + "px";
        }

        o.ShowEdit = function (title) {

            if (o.native.btnAdd != undefined) {
                o.native.btnAdd.style.display = "none";
            }
            if (o.native.btnCancel != undefined) {
                o.native.btnCancel.style.display = "";
            }
            if (o.native.btnEdit != undefined) {
                o.native.btnEdit.style.display = "";
            }
            if (o.native.btnDelete != undefined) {
                o.native.btnDelete.style.display = "";
            }

            o.style.display = "block";

            if (o.native.legend != undefined) {
                o.native.legend.innerHTML = title;
            }

            o.style.height = document.offsetHeight.toString() + "px";
        }
        o.Hide = function () {
            o.style.display = "none";
        }

        if (arrObject !== undefined) {
            for (var i in arrObject) {
                o[i] = arrObject[i];
            }
        }

        return o;
    }
    //$
    apl.func["createCalender"] = function (id, arrObject) {
        var o = apl.func.get(id);
        apl.native.calender.f_SetObjectToCalender(o);
        if (arrObject !== undefined) for (var i in arrObject) o[i] = arrObject[i];
    }

    //$
    apl.func["formatNumeric"] = function (value, fixedValue) {
        /*
        var _value = (value == undefined) ? 0 : value;
        var _fixedValue = (fixedValue == undefined) ? 0 : fixedValue;
        var nilai = parseFloat(_value.replace(/,/g, ""));
        return nilai.toFixed(_fixedValue).replace(/(\d)(?=(\d{3})+\b)/g, '$1,');
        */
        var _value;

        if (typeof (value) == "number") {
            _value = value.toString();
        } else if (typeof (value) == "string") {
            _value = value;
        } else {
            return "";
        }

        var _fixedValue = (fixedValue == undefined) ? 0 : fixedValue;
        var nilai = parseFloat(_value.replace(/,/g, ""));
        return nilai.toFixed(_fixedValue).replace(/(\d)(?=(\d{3})+\b)/g, '$1,');
    }
    //$
    apl.func["createNumeric"] = function (id, fixedvalue, formatnumber, arrObject) {
        //var o = document.getElementById(id);
        var o = apl.func.get(id);
        if (o == undefined) {
            alert("Object: '" + id + "' tidak ditemukan");
        }
        o.fixedValue = (fixedvalue == undefined) ? 0 : fixedvalue;
        o.formatNumber = (formatnumber == undefined) ? true : formatnumber;
        o.caret = 0;
        o.pass = true;
        o.chCode = 0;

        o.onkeypress = function (event) {
            var chCode = ('charCode' in event) ? event.charCode : event.keyCode;
            var re = new RegExp("[0-9.]");
            o.caret = o.selectionStart;
            o.pass = re.test(String.fromCharCode(chCode));
            o.chCode = chCode;

            if (chCode > 0) {
                return o.pass;
            }
        }
        o.setValue = function (value) {
            return apl.func.formatNumeric(value, o.fixedValue);
        }
        o.getIntValue = function () {
            return parseFloat(o.value.replace(/,/g, ""));
        }
        o.onkeyup = function (event) {
            if (!o.formatNumber) return;
            var pass = (event.keyCode == 46 || event.keyCode == 8) ? true : false;
            if ((o.chCode > 0 && o.pass) || pass) {
                var l1 = o.value.length;
                if (l1 > 0) {
                    o.value = apl.func.formatNumeric(o.value, o.fixedValue);
                    var l2 = o.value.length;
                    var penambahan = (pass) ? l2 - l1 : 1 + l2 - l1;
                    o.selectionStart = o.selectionEnd = o.caret + penambahan;
                }
            }
        }
        if (arrObject !== undefined) for (var i in arrObject) o[i] = arrObject[i];
    }
    //$
    apl.func["showError"] = function (error, userContext, methodName) {
        var textError = 'ERROR MESSAGE ' +
            "\r\nMETHOD NAME: " + methodName +
            "\r\nSERVICE ERROR: " + error.get_message() +
            "\r\nSTATUS CODE: " + error.get_statusCode() +
            "\r\nEXCEPTION TYPE: " + error.get_exceptionType() +
            "\r\nTIMEDOUT: " + error.get_timedOut() +
            "\r\nSTACK TRACE: " + error.get_stackTrace();
        alert(textError);
    }
    //$
    apl.func["createOption"] = function (value, text) {
        var e = document.createElement("option");
        e.value = value;
        e.text = text;
        return e;
    }
    //$
    apl.func["createDropdown"] = function (id, f_loadData, PromptText, arrParam, webfunctionname, loadOnFocus, arrObject) {
        //var o = document.getElementById(id);
        var o = apl.func.get(id);
        eval("if (" + webfunctionname + " == undefined) { alert('web service function::" + webfunctionname + ":: tidak ditemukan');}");

        if (o == undefined) {
            alert("Object :'" + id + "' tidak ditemukan");
            return null;
        }
        o.arrParam = arrParam;
        o.promptText = PromptText;
        o.getWhere = function (arrParam) {
            var strWhere = "", nilai;
            if (arrParam != undefined) {
                for (var i in arrParam) {
                    if (document.getElementById(arrParam[i].valFromID) != undefined) {
                        nilai = document.getElementById(arrParam[i].valFromID).value || document.getElementById(arrParam[i].valFromID).innerHTML;
                        strWhere += ((parseInt(i) > 0) ? " and " : "") + arrParam[i].fieldName + ((parseFloat(nilai).toString() == nilai) ? "=" : "='") + nilai + ((parseFloat(nilai).toString() == nilai) ? "" : "'");
                    }
                }
            }
            return strWhere;
        }
        o.set = f_loadData;
        o.clearItem = function () {
            for (var ctr = o.childNodes.length - 1; ctr >= 0; ctr--) {
                o.removeChild(o.childNodes[ctr]);
            }
        }
        if (arrParam != undefined) { loadOnFocus = true; }
        if (loadOnFocus) {
            o.onfocus = function () {
                var l = o.value;
                o.clearItem();
                o.set(l);
            }
        } else {
            o.set('');
        }
        o.setValue = function (nilai) {
            if (o.loadOnFocus) { o.set(nilai); } else { o.value = nilai; }
        }
        o.getValue = function () {
            return o.value;
        }
        if (arrObject !== undefined) for (var i in arrObject) o[i] = arrObject[i];
    }
    //$
    apl.func["setDropdownParam"] = function (fieldName, valFromID) {
        var o = new function () {
            this.fieldName = fieldName;
            this.valFromID = valFromID;
        }
        return o;
    }
    //$
    apl.func["createAttribute"] = function (name, value) {
        var o = new function () {
            this.name = name;
            this.value = value;
        }
        return o;
    }
    //$
    apl.func["createElement"] = function (str_tag, arr_Atr, str_innerHTML, arr_Element, object_Properti) {
        var o = document.createElement(str_tag);

        if (str_innerHTML != undefined) o.innerHTML = str_innerHTML;

        if (arr_Atr != undefined) for (var i in arr_Atr) o.setAttribute(arr_Atr[i].name, arr_Atr[i].value);

        if (arr_Element != undefined) for (var i in arr_Element) o.appendChild(arr_Element[i]);

        if (object_Properti !== undefined) for (var i in object_Properti) o[i] = object_Properti[i];
        return o;
    }
    //$
    apl.func["createDropdownList"] = function (strID, funcWS, strOptionValue, strOptionText, booOnFocus, funcWhere) {
        var o = apl.func.get(strID);

        if (o == undefined) {
            alert("object :" + strID + " tidak ditemukan");
            return null;
        }
        if (funcWS == undefined) {
            alert("web function tidak ditemukan: ");
            return null;
        }
        o.clearItem = function () {
            var o = this;
            for (var ctr = o.childNodes.length - 1; ctr >= 0; ctr--) {
                o.removeChild(o.childNodes[ctr]);
            }
        }
        o.funcWS = funcWS;
        o.fungWhere = funcWhere;

        o.setValue = function (curValue) {
            var o = this;
            o.clearItem();
            var strWhere;
            if (o.fungWhere == undefined) {
                strWhere = "";
            } else {
                strWhere = o.fungWhere();
            }
            o.funcWS(strWhere,
                function (arrData) {
                    for (var i in arrData) {
                        o.appendChild(apl.func.createOption(arrData[i][strOptionValue], arrData[i][strOptionText]));
                    }
                    if (curValue != undefined) o.value = curValue;

                }, apl.func.showError, "");
        }
        if (booOnFocus) {
            o.onfocus = function () {
                o.setValue(o.value);
            }
        } else {
            o.setValue("");
        }
        return o;
    }
    //$
    apl.func["table"] = {
        insertAttribute: function (str_name, str_value) {
            return { name: str_name, value: str_value };
        },
        insertCell: function (arr_element, arr_AttributeCell) {
            return { element: arr_element, attribute: arr_AttributeCell };
        },
        clearRowAll: function (g_tbl, int_start_row) {
            var tbl;
            var start = 0;

            if (typeof g_tbl == "string") {
                tbl = document.getElementById(g_tbl);
                if (tbl == undefined) {
                    alert("Invalid table object id '" + g_tbl + "'");
                    return null;
                }
            } else {
                if (g_tbl.tagName == "TABLE") {
                    tbl = g_tbl;
                } else {
                    alert("Tag element is not 'table'");
                    return null;
                }
            }

            if (int_start_row) {
                start = int_start_row;
            }
            if (tbl.rows) {
                for (var i = tbl.rows.length - 1; i >= start; i--) {
                    tbl.deleteRow(i);
                }
            }
        },
        insertRow: function (g_tbl, arrCell) {
            var tbl;
            if (typeof g_tbl == "string") {
                tbl = document.getElementById(g_tbl);
                if (tbl == undefined) {
                    alert("Invalid table object id '" + g_tbl + "'");
                    return null;
                }
            } else {
                if (g_tbl.tagName == "TABLE") {
                    tbl = g_tbl;
                } else {
                    alert("Tag element is not 'table'");
                    return null;
                }
            }

            var tr = document.createElement("TR");
            tbl.appendChild(tr);
            for (var i in arrCell) {
                var td = document.createElement("TD");
                if (arrCell[i].attribute) {
                    for (var j in arrCell[i].attribute) {
                        //td[arrCell[i].attribute[j].name] = arrCell[i].attribute[j].value;
                        td.setAttribute(arrCell[i].attribute[j].name, arrCell[i].attribute[j].value);
                    }
                }
                if (arrCell[i].element) {
                    for (var j in arrCell[i].element) {
                        td.appendChild(arrCell[i].element[j]);
                    }

                }
                tr.appendChild(td);
            }
        }
    };
    //$
    apl.func["setFocus"] = function (id_or_element) {
        var o;
        if (typeof id_or_element == "string") {
            o = document.getElementById(id_or_element);
        } else {
            o = id_or_element;
        }
        setTimeout(function () { o.focus(); }, 100);
    }
    //$
    apl.func["showSinkMessage"] = function (message) {
        var o = document.getElementById("sink_message");
        if (o) {
            o.style.visibility = "visible";
            o.innerHTML = message;
        }
    }
    //$
    apl.func["hideSinkMessage"] = function () {
        var o = document.getElementById("sink_message");
        if (o) {
            o.style.visibility = "hidden";
        }
    }
    //$
    apl.func["cek_parent"] = function (o, p) {
        var status = false;
        if (o == p) status = true;
        else if (o.parentNode == p) status = true;
        else if (o.parentNode == null) status = false;
        else status = apl.func.cek_parent(o.parentNode, p);
        return status;
    }
    //$
    apl.func["set_element"] = function (element) {
        var _o = (typeof element == "string") ? document.getElementById(element) : element;
        _o.hide = function () {
            this.style.display = "none";
        }
        _o.show = function () {
            this.style.display = "block";
        }
        return _o;
    }
})();
/*=*/


/*CALENDER*/
(function (_o) {


    var o = _o["calender"] = document.createElement("div");
    var b = o.o_CalenderHeaderBulan = ce("div");
    var t = o.o_CalenderHeaderTahun = ce("div");
    var db = o.o_calenderDaftarBulan = ce("div");
    var dt = o.o_calenderDaftarTahun = ce("div");
    var dh = o.o_calenderDaftarHari = ce("div");
    var arrD = o.v_daftarObjectCalender = [db, dt, dh];

    var lb = o.o_ArrBulan = new Array();
    var lt = o.v_ArrTahun = new Array();
    var lh = o.v_ArrHari = new Array();
    var arrBulan = o.v_ArrBulan = ["Jan", "Feb", "Mar", "Apr", "Mei", "Jun", "Jul", "Agu", "Sep", "Okt", "Nov", "Des"];
    var arrHari = o.v_ArrHari = ["M", "S", "S", "R", "K", "J", "S"];

    o.setAttribute("class", "calender");
    o.setAttribute("style", "display:none;");
    o.f_Show = Show;
    o.f_Hide = Hide;
    o.f_DisplaySts = DisplaySts;
    o.value = "";
    o.o_objTanggal = "";
    o.v_Tanggal = "";

    o.f_SetObjectToCalender = function (obj) {
        /*
        window.addEventListener("click", function (e) {
            if (apl.func.cek_parent(e.target, o) == false && e.target != obj) o.f_Hide();
        });
        */

        obj.show_popup = function (st) {
            if (st) o.f_Show(); else o.f_Hide();
        }

        obj.setDisabled = function (st) {
            obj.disabled = st;
            o.f_Hide();
        }
        obj.onclick = function () {
            if (o.f_DisplaySts()) {
                o.f_Hide();
            } else {
                var s_o = this.parentNode;
                s_o.appendChild(o);
                o.o_objTanggal = this;
                var tanggal = "";

                if (this.value == undefined) {
                    var tanggal = this.innerHTML;
                } else {
                    var tanggal = this.value;
                }


                if (tanggal == "") {
                    var d = new Date();
                    var bulan = arrBulan[d.getMonth()];
                    var tahun = d.getFullYear();
                    o.f_SetBulan(bulan);
                    o.f_SetTahun(tahun);
                    o.v_Tanggal = "0";
                    o.f_Show();
                } else {
                    var dateFormat = /^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$/;
                    if (tanggal.match(dateFormat)) {
                        var s_tgl = parseInt(tanggal[0] + tanggal[1]);
                        var s_bln = parseInt(tanggal[3] + tanggal[4]);
                        var s_thn = tanggal[6] + tanggal[7] + tanggal[8] + tanggal[9];
                        o.f_SetBulan(arrBulan[s_bln - 1]);
                        o.f_SetTahun(s_thn);
                        o.v_Tanggal = s_tgl;
                        o.f_Show();
                    } else {

                        if (this.value == undefined) {
                            this.innerHTML = "01/01/1900";
                        } else {
                            this.value = "";
                        }
                    }
                }

                createDaftarTanggal();
            }
        }
    }
    o.f_SetBulan = function (Nilai) {
        this.o_CalenderHeaderBulan.innerHTML = Nilai;
    }
    o.f_GetBulan = function () {
        return this.o_CalenderHeaderBulan.innerHTML;
    }
    o.f_SetTahun = function (nilai) {
        this.o_CalenderHeaderTahun.innerHTML = nilai;
    }
    o.f_GetTahun = function () {
        return this.o_CalenderHeaderTahun.innerHTML;
    }
    o.f_ShowDaftar = function (obj) {
        var s_o = this.v_daftarObjectCalender;
        for (var i = 0; i < o.length; i++) {
            if (s_o[i] == obj) {
                s_o[i].f_Show();
            } else {
                s_o[i].f_Hide();
            }
        }
    }
    o.f_setTanggal = function (tanggal) {
        var bulan = parseBulan(o.f_GetBulan()) + 1;
        if (tanggal.length == 1) {
            tanggal = "0" + tanggal;
        }
        if (bulan.toString().length == 1) {
            bulan = "0" + bulan;
        }
        this.value = tanggal + '/' + bulan + '/' + o.f_GetTahun();

        if (this.o_objTanggal.value == undefined) {
            this.o_objTanggal.innerHTML = this.value;
        } else {
            this.o_objTanggal.value = this.value;
        }
    }

    createHeader();
    createListBulan();
    createListTahun();
    createListHari();

    /*ini yang paling penting*/
    window.document.body.appendChild(o);


    function ce(tagName) {
        return document.createElement(tagName);
    }

    function createHeader() {
        var s_cl = ce("div");
        s_cl.setAttribute("class", "calenderHeader");

        b.setAttribute("class", "calenderHeaderBulan");
        b.onclick = function () {
            if (o.o_calenderDaftarBulan.f_DisplaySts()) {
                showOff(dh);
            } else {
                showOff(db);
                var s_bln = o.f_GetBulan();

                for (var i = 0; i < lb.length; i++) {

                    if (lb[i].innerHTML.toString() == s_bln) {
                        lb[i].style.backgroundColor = "Grey";
                    } else {
                        lb[i].style.backgroundColor = null;
                    }
                }
            }
        }

        t.setAttribute("class", "calenderHeaderTahun");
        t.f_showYearList = function () {
            var thn = parseInt(o.f_GetTahun()) - 7;
            buttonNavShowListTahun(thn);
        }
        t.onclick = function () {
            if (o.o_calenderDaftarTahun.f_DisplaySts()) {
                showOff(dh);
            } else {
                this.f_showYearList();
                showOff(dt);
            }
        }

        s_cl.appendChild(b);
        s_cl.appendChild(t);


        var c = document.createElement("div");
        c.setAttribute("style", "padding-left:100px;cursor:pointer;");
        c.innerHTML = "Clear";
        c.onclick = function () {
            o.o_objTanggal.value = "";
            o.f_Hide();
        }
        s_cl.appendChild(c);
        o.appendChild(s_cl);
    }

    function showOff(obj) {
        for (var i = 0; i < arrD.length; i++) {
            if (arrD[i] == obj) {
                arrD[i].f_Show();
            } else {
                arrD[i].f_Hide();
            }
        }
    }
    function DisplaySts() {
        return ((this.style.display == "" || this.style.display == "none") ? false : true);
    }
    function Show() {
        this.style.display = "block";
    }
    function Hide() {
        this.style.display = "none";
    }

    function createListBulan() {
        db.setAttribute("class", "calenderDaftarBulan");
        db.f_DisplaySts = DisplaySts;
        db.f_Show = Show;
        db.f_Hide = Hide;

        var s_t = ce("table");
        var s_ctr = 0;
        for (var i = 0; i < 4; i++) {
            var s_r = ce("tr");
            for (var j = 0; j < 3; j++) {
                var s_c = ce("td");
                s_c.innerHTML = arrBulan[s_ctr];
                s_c.onclick = function () {
                    b.innerHTML = this.innerHTML;
                    showOff(dh);
                    createDaftarTanggal();
                }
                s_ctr++;
                lb[lb.length] = s_c;
                s_r.appendChild(s_c);
            }
            s_t.appendChild(s_r);
        }

        db.appendChild(s_t);
        o.appendChild(db);
    }
    function createListTahun() {
        dt.setAttribute("class", "calenderDaftarTahun");
        dt.f_DisplaySts = DisplaySts;
        dt.f_Show = Show;
        dt.f_Hide = Hide;
        var s_t = ce("table");

        for (var i = 0; i < 5; i++) {
            var s_r = ce("tr");
            if (i == 0) {
                var s_c = createButtonNavTahun("◄",
                            function () {
                                var s_tahun1 = parseInt(lt[0].innerHTML);
                                buttonNavShowListTahun(s_tahun1 - 15);
                            });
                s_r.appendChild(s_c);
            }
            for (var j = 0; j < 3; j++) {
                var s_c = ce("td");
                s_c.innerHTML = "2013";
                s_c.onclick = function () {
                    t.innerHTML = this.innerHTML;
                    showOff(dh);
                    createDaftarTanggal();
                }
                lt[lt.length] = s_c;
                s_r.appendChild(s_c);
            }
            if (i == 0) {
                var s_c = createButtonNavTahun("►",
                            function () {
                                var s_tahun1 = parseInt(lt[lt.length - 1].innerHTML);
                                buttonNavShowListTahun(s_tahun1 + 1);
                            });
                s_r.appendChild(s_c);
            }
            s_t.appendChild(s_r);
        }

        dt.appendChild(s_t);
        o.appendChild(dt);
    }
    function buttonNavShowListTahun(awal) {
        var thn = awal;
        var s_defthn = o.f_GetTahun();
        for (var i = 0; i < lt.length; i++) {
            if (thn == s_defthn) {
                lt[i].style.backgroundColor = "grey";
            } else {
                lt[i].style.backgroundColor = null;
            }


            lt[i].innerHTML = thn;
            thn++;
        }
    }
    function createButtonNavTahun(text, s_fungsi) {
        var s_c = ce("th");
        s_c.setAttribute("rowspan", "5");
        var s_b = ce("input");
        s_b.setAttribute("type", "button");
        s_b.setAttribute("value", text);
        s_b.onclick = s_fungsi;
        s_c.appendChild(s_b);
        return s_c
    }
    function createListHari() {
        dh.setAttribute("class", "calenderDaftarTanggal");
        dh.f_DisplaySts = DisplaySts;
        dh.f_Show = Show;
        dh.f_Hide = Hide;
        var s_t = ce("table");
        //buat daftar hari
        var s_r = ce("tr");
        for (var i = 0; i < arrHari.length; i++) {
            var s_h = ce("th");
            s_h.innerHTML = arrHari[i];
            s_r.appendChild(s_h);
        }
        s_t.appendChild(s_r);

        for (var i = 0; i < 6; i++) {
            var s_r = ce("tr");
            for (var j = 0; j < arrHari.length; j++) {
                var s_c = ce("td");
                s_c.innerHTML = "00";
                s_c.onclick = function () {
                    if (this.innerHTML != "") {
                        o.f_Hide();
                        o.f_setTanggal(this.innerHTML);
                    }
                }
                lh[lh.length] = s_c;
                s_r.appendChild(s_c);
            }
            s_t.appendChild(s_r);
        }

        dh.appendChild(s_t);
        o.appendChild(dh);
    }
    function createDaftarTanggal() {
        var s_tahun = parseInt(o.f_GetTahun());
        var s_bulan = parseBulan(o.f_GetBulan());
        var s_MulaiHari = getDayFromDate(1, s_bulan, s_tahun);
        var s_TanggalAkhir = getLastDateOfMonth(s_tahun, s_bulan);
        var s_tanggal = 1;

        for (var i = 0; i < lh.length; i++) {
            if (i >= s_MulaiHari && s_tanggal <= s_TanggalAkhir) {
                if (s_tanggal == o.v_Tanggal) {
                    lh[i].style.backgroundColor = "grey";
                } else {
                    lh[i].style.backgroundColor = null;
                }
                lh[i].innerHTML = s_tanggal;
                s_tanggal++;
            } else {
                lh[i].innerHTML = "";
                lh[i].style.backgroundColor = null;
            }
        }
    }
    function parseBulan(bulan) {
        var nBulan;
        for (var i = 0; i < arrBulan.length; i++) {
            if (arrBulan[i].toString() == bulan) {
                nBulan = i;
                break;
            } else {
                nBulan = 0;
            }
        }

        return nBulan;
    }
    function getDayFromDate(tgl, bln, thn) {
        var d = new Date();
        d.setYear(thn);
        d.setMonth(bln);
        d.setDate(tgl);
        return d.getDay();
    }

    function getLastDateOfMonth(Year, Month) {
        return (new Date((new Date(Year, Month + 1, 1)) - 1)).getDate();
    }

})(apl.native);
/*CALENDER*/

//setting parameter for aplikasi
apl.pubvar.spaceHeader = 50;
window.onload = apl.func.windowOnload;
window.onresize = apl.func.winresize.executeFunction;
