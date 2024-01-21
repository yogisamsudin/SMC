<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" theme="Page"%>

<script runat="server">
void Page_Load(object o, EventArgs e)
    {
        gvdata.DataBind();
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

    <asp:SqlDataSource runat="server" ID="sdsdata" 
        ConnectionString="<%$ ConnectionStrings:csApp %>"  SelectCommandType="Text"
        SelectCommand="select kode,nilai,keterangan from appparameter order by cast(keterangan as varchar(1000))">
        
    </asp:SqlDataSource>
    <div style="margin-left:50px;">
        <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
            AllowPaging="False" AllowSorting="True" AutoGenerateColumns="False" 
            CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PageSize="100">
            <Columns>
                <asp:TemplateField ItemStyle-Width="25px">
                    <ItemTemplate>
                        <div class="edit" onclick="mdl.edit('<%# Eval("kode") %>')"></div>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="keterangan" HeaderText="Keterangan" HeaderStyle-HorizontalAlign="Left" />                
                <asp:BoundField DataField="nilai" HeaderText="Nilai" HeaderStyle-HorizontalAlign="Left" />
            </Columns>
        </asp:GridView>
    </div>

    <div id="mdl" class="modal">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Keterangan</th>
                    <td><label id="mdl_keterangan"></label></td>
                </tr>
                <tr>
                    <th>Nilai</th>
                    <td>
                        <input type="text" id="mdl_nilai_c" size="50"/>
                        <input type="text" id="mdl_nilai_d" size="10" style="text-align:right"/>
                        <input type="text" id="mdl_nilai_n" size="15"/>
                    </td>
                </tr>
            </table>
            <div class="button_panel">
                <input type="button" value="Save"/>
                <input type="button" value="Cancel"/>
            </div>
        </fieldset>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var mdl = apl.createModal("mdl",
            {
                kode: "",
                field_type_id: "",
                lb_keterangan: apl.func.get("mdl_keterangan"),
                tb_nilai_c: apl.func.get("mdl_nilai_c"),
                tb_nilai_d: apl.createCalender("mdl_nilai_d"),
                tb_nilai_n: apl.createNumeric("mdl_nilai_n",false),
                edit:function(kode)
                {
                    mdl.kode = kode;
                    tool.app_parameter_data(kode,
                        function (data)
                        {
                            mdl.tb_nilai_c.value = "";
                            mdl.tb_nilai_d.value = "";
                            mdl.tb_nilai_n.value = "";

                            mdl.lb_keterangan.innerHTML = data.keterangan;
                            mdl.field_type_id = data.field_type_id;
                            switch(data.field_type_id)
                            {
                                case "N":
                                    mdl.tb_nilai_c.Hide();
                                    mdl.tb_nilai_n.Show();
                                    mdl.tb_nilai_d.Hide();
                                    mdl.tb_nilai_n.setValue(data.nilai);
                                    break;
                                case "D":
                                    mdl.tb_nilai_c.Hide();
                                    mdl.tb_nilai_n.Hide();
                                    mdl.tb_nilai_d.Show();
                                    mdl.tb_nilai_d.value = data.nilai;
                                    break;
                                default:
                                    mdl.tb_nilai_c.Show();
                                    mdl.tb_nilai_n.Hide();
                                    mdl.tb_nilai_d.Hide();
                                    mdl.tb_nilai_c.value = data.nilai;
                                    break;
                            }
                            mdl.showEdit("Parameter - Edit");
                        }, apl.func.showError, ""
                    );                    
                }
            },
            undefined,
            function ()
            {
                var nilai = "";
                switch (mdl.field_type_id) {
                    case "N":
                        nilai = mdl.tb_nilai_n.getIntValue().toString();
                        break;
                    case "D":
                        nilai = mdl.tb_nilai_d.value;
                        break;
                    default:
                        nilai = mdl.tb_nilai_c.value;
                        
                        break;
                }
                
                tool.appParameter_edit(mdl.kode, nilai,
                    function () {
                        theForm.submit();
                    }, apl.func.showError, ""
                );

            },
            undefined, "frm_page", "cover_content"
        );
    </script>
</asp:Content>

