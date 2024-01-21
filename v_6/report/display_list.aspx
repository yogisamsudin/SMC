<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" theme="Page"%>

<script runat="server">
void Page_Load(object o, EventArgs e)
    {
        //gvData.DataBind();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" src="../js/Komponen.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <asp:ScriptManager runat="server" ID="sm">
        <Services>
            <asp:ServiceReference Path="report.asmx" />
        </Services> 
    </asp:ScriptManager>
    
    <asp:SqlDataSource ID="sdsData" runat="server" ConnectionString="<%$ ConnectionStrings:csApp %>"        
        SelectCommand="select ModuleCode,ListID,DisplayName,replace(DisplayName,' ','') FileName from v_rptlist where modulecode = @module_code"  >
        <SelectParameters>
            <asp:QueryStringParameter Name="module_code" QueryStringField="module_code" />            
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
        CellSpacing="1" CssClass="gridView" DataKeyNames="ListID" DataSourceID="sdsData"
        GridLines="None" ShowHeaderWhenEmpty="True" Width="100%">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <div class="edit" onclick="edit(<%# Eval("ModuleCode") %>,<%# Eval("ListID") %>,'<%# Eval("FileName") %>')" title="Edit data"></div>
                </ItemTemplate>
                <ControlStyle BackColor="White" />
                <HeaderStyle BackColor="White" Width="10px" />                
            </asp:TemplateField>
            <asp:BoundField DataField="DisplayName" HeaderText="Laporan">
                <HeaderStyle HorizontalAlign="Left"/>
            </asp:BoundField>            
        </Columns>
    </asp:GridView>
    
    <div class="modal" id="mdl">
        <fieldset>
            <legend></legend>
            <iframe class="frameList" id="mdl_if"></iframe>            
        </fieldset>
        
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        function edit(module_code, list_id, file_name)
        {
            report.rpt_list_data(module_code, list_id,
                function (data)
                {
                    //alert(data.display_name+":"+data.file_name);
                    mdl.open(data.display_name, data.list_id, data.file_name);
                }, apl.func.showError, ""
            );
        }
        var mdl = apl.createModal("mdl",
            {
                if_list: apl.func.get("mdl_if"),
                open:function(name,list_id, file_name)
                {
                    mdl.showAdd(name);
                    mdl.if_list.src = "passing_generator.ashx?ListID=" + list_id + "&FileName=" + file_name;
                },
                close:function()
                {
                    mdl.hide();
                }
            },
            undefined, undefined, undefined, "frm_page", "cover_content"
        );

        document.closeModulPassing = mdl.close;
    </script>
</asp:Content>

