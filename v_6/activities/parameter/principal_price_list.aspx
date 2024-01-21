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
        SelectCommand="select case when active_sts=1 then 'checked' else '' end checked_html, param_pp_id, description,active_sts,dbo.f_convertDateToChar(active_date)str_active_date, active_date from v_par_principal_price where description like @name">
        <SelectParameters>
            <asp:QueryStringParameter Name="name" QueryStringField="name" DefaultValue="%"/>
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10">
        <Columns>
            <asp:TemplateField HeaderStyle-Width="25px">
                <ItemTemplate>
                    <div class="edit" title="edit" onclick="edit('<%# Eval("param_pp_id") %>');"></div>
                </ItemTemplate>        
                <HeaderTemplate>
                    <div class="tambah" onclick="tambah();"></div>
                </HeaderTemplate>        
            </asp:TemplateField>
            <asp:BoundField DataField="description" HeaderText="Keterangan" SortExpression="description" HeaderStyle-HorizontalAlign="Left" />            
            <asp:TemplateField HeaderText="Status" SortExpression="active_sts" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                <ItemTemplate>
                    <input type="checkbox" disabled="disabled" <%# Eval("checked_html") %>/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="str_active_date" HeaderText="Tgl.Aktif" SortExpression="active_date" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px"/>
        </Columns>
    </asp:GridView>
    <script type="text/javascript">
        document.edit = edit = function (id) {
            window.parent.document["<%= function_edit_name %>"](id);
        }
        document.tambah = tambah = function () {
            window.parent.document["<%= function_add_name %>"]();
        }

        document.refresh = function () { theForm.submit(); }
    </script>
</asp:Content>

