<%@ Page Title="" Language="C#" MasterPageFile="~/page_list.master" Theme="ListPage" %>

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
        SelectCommand="select loan_id,dbo.f_convertDateToChar(loan_date)str_loan_date,tenor,loan_amount,loan_no,loan_start_month_name,loan_start_year,employee_name from v_hr_employee_loan where approve_sts=0 and employee_name like @name">
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
                    <div class="edit" title="edit" onclick="edit(<%# Eval("loan_id") %>);" style="float:left"></div>                    
                </ItemTemplate>
                <HeaderTemplate>
                    <div class="tambah" title="tambah" onclick="tambah()"></div>
                </HeaderTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="str_loan_date" HeaderText="Tanggal" ReadOnly="True" SortExpression="loan_date" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="100"/>
            <asp:BoundField DataField="loan_no" HeaderText="No" ReadOnly="True" SortExpression="loan_no" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="100"/>
            <asp:BoundField DataField="employee_name" HeaderText="Nama" ReadOnly="True" SortExpression="employee_name" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="loan_amount" HeaderText="Total" ReadOnly="True" SortExpression="loan_amount" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="100"  DataFormatString="{0:n}"/>
            <asp:BoundField DataField="loan_start_month_name" HeaderText="Bulan" ReadOnly="True" SortExpression="loan_start_month" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="100"/>
            <asp:BoundField DataField="loan_start_year" HeaderText="Tahun" ReadOnly="True" SortExpression="loan_start_year" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="100"/>
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

