<%@ Page Title="" Language="C#" MasterPageFile="~/page_list.master" theme="ListPage" %>

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
        SelectCommand="select a.inventory_id, dbo.f_convertdatetochar(a.inventory_in)str_inventory_in,a.inventory_in, a.inventory_sts, a.vendor_name,a.inventory_type from v_tec_inventory a left join v_tec_inventory_device b on a.inventory_id=b.inventory_id and b.sn like '%' where a.inventory_type_id like @type and a.vendor_name like @name and a.inventory_sts=@done">
        <SelectParameters>
            <asp:QueryStringParameter Name="type" QueryStringField="type" DefaultValue="%"/>
            <asp:QueryStringParameter Name="name" QueryStringField="name" DefaultValue=" "/>
            <asp:QueryStringParameter Name="done" QueryStringField="done" DefaultValue="0"/>
            <asp:QueryStringParameter Name="sn" QueryStringField="sn" DefaultValue="0"/>
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10">
        <Columns>
            <asp:TemplateField HeaderStyle-Width="25px">
                <ItemTemplate>
                    <div class="edit" title="edit" onclick="edit('<%# Eval("inventory_id") %>');"></div>
                </ItemTemplate>
                <HeaderTemplate>
                    <div class="tambah" title="tambah" onclick="tambah()"></div>
                </HeaderTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="str_inventory_in" HeaderText="Tgl.Masuk" ReadOnly="True" SortExpression="inventory_in" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="100px"/>
            <asp:BoundField DataField="vendor_name" HeaderText="Vendor" ReadOnly="True" SortExpression="vendor_name" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="inventory_type" HeaderText="Tipe" ReadOnly="True" SortExpression="inventory_type" HeaderStyle-HorizontalAlign="Left" />            
            <asp:TemplateField HeaderStyle-Width="70px" HeaderText="Selesai" SortExpression="done_sts" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <input type="checkbox" <%# Eval("inventory_sts") %> disabled="disabled"/>
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

