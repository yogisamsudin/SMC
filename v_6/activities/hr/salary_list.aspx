<%@ Page Title="" Language="C#" MasterPageFile="~/page_list.master" Theme="ListPage"%>

<script runat="server">
    public string function_edit_name = "list_edit", function_add_name = "list_add";

    void Page_Load(object o, EventArgs e)
    {
        if (Request.QueryString["add"] != null) function_add_name = Request.QueryString["add"].ToString();
        if (Request.QueryString["edit"] != null) function_edit_name = Request.QueryString["edit"].ToString();
        gvdata.DataBind();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="Body_Content" Runat="Server">
    <asp:SqlDataSource runat="server" ID="sdsdata" 
        ConnectionString="<%$ ConnectionStrings:csApp %>" 
        SelectCommand="select salary_id,salary_name,month_issue,year_issue,dbo.f_convertDateToChar(salary_date)str_salary_date,month_name,salary_date from v_hr_salary where salary_name like @name">
        <SelectParameters>
            <asp:QueryStringParameter Name="name" QueryStringField="name" DefaultValue=" "/>
            
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10">
        <Columns>
            <asp:TemplateField HeaderStyle-Width="25px">
                <ItemTemplate>
                    <div class="edit" title="edit" onclick="edit(<%# Eval("salary_id") %>);" style="float:left"></div>                    
                </ItemTemplate>
                <HeaderTemplate>
                    <div class="tambah" title="tambah" onclick="tambah(0)"></div>
                </HeaderTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="str_salary_date" HeaderText="Tanggal" ReadOnly="True" SortExpression="salary_date" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="100px"/>
            <asp:BoundField DataField="salary_name" HeaderText="Keterangan" ReadOnly="True" SortExpression="salary_name" HeaderStyle-HorizontalAlign="Left" />
        </Columns>
    </asp:GridView>
    <script type="text/javascript">
        document.edit = edit = function (id) {
            window.parent.document["<%= function_edit_name %>"](id);
        }
        document.tambah = tambah = function (id) {
            window.parent.document["<%= function_add_name %>"](id);
        }

        document.refresh = function () { theForm.submit(); }
    </script>
</asp:Content>

