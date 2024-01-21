<%@ Page Title="" Language="C#" MasterPageFile="~/page_list.master"  Theme="ListPage"%>

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
        ConnectionString="<%$ ConnectionStrings:csApp %>" SelectCommandType="StoredProcedure" SelectCommand="aspx_schedule_list">
        <SelectParameters>
            <asp:QueryStringParameter Name="date" QueryStringField="date" DefaultValue=" "/>
            <asp:QueryStringParameter Name="done" QueryStringField="done" DefaultValue="false" DbType="Boolean"/>
            <asp:QueryStringParameter Name="schedule_id" QueryStringField="schedule_id" DefaultValue="false" DbType="Int32"/>
            <asp:QueryStringParameter Name="type" QueryStringField="type" DefaultValue="1"/>
            <asp:QueryStringParameter Name="branch_id" QueryStringField="branch" DefaultValue="%"/>
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10" ShowFooter="False">
        <Columns>
            <asp:TemplateField HeaderStyle-Width="25px">
                <ItemTemplate>
                    <div class="edit" title="edit" onclick="edit('<%# Eval("schedule_id") %>');"></div>
                </ItemTemplate>
                <HeaderTemplate>
                    <div class="tambah" title="tambah" onclick="tambah()"></div>
                </HeaderTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="schedule_id" HeaderText="No" ReadOnly="True" SortExpression="schedule_id" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"/>
            <asp:BoundField DataField="str_schedule_date" HeaderText="Tanggal" ReadOnly="True" SortExpression="schedule_date" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="100px"/>
            <asp:BoundField DataField="branch_name" HeaderText="Cabang" ReadOnly="True" SortExpression="branch_name" HeaderStyle-HorizontalAlign="Left" />            
            <asp:BoundField DataField="customer_name" HeaderText="Pelanggan" ReadOnly="True" SortExpression="customer_name" HeaderStyle-HorizontalAlign="Left" />            
            <asp:BoundField DataField="location_address" HeaderText="Alamat" ReadOnly="True" SortExpression="location_address" HeaderStyle-HorizontalAlign="Left" />            
            <%--<asp:BoundField DataField="distance" HeaderText="Jarak" ReadOnly="True" SortExpression="distance" HeaderStyle-HorizontalAlign="Right" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right"/>--%>            
            <asp:TemplateField HeaderText="Serv" ItemStyle-HorizontalAlign="Center" >
                <ItemTemplate>
                    <div class="select" style="visibility:<%# Eval("service_sts")%>"></div>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Jual" ItemStyle-HorizontalAlign="Center" >
                <ItemTemplate>
                    <div class="select" style="visibility:<%# Eval("sales_sts")%>"></div>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <script type="text/javascript">
        document.edit = edit = function (id) { window.parent.document["<%= function_edit_name %>"](id); }
        document.tambah = tambah = function () { window.parent.document["<%= function_add_name %>"](); }
        document.refresh = function () { theForm.submit(); }
    </script>
</asp:Content>

