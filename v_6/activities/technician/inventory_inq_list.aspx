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
        SelectCommand="select dbo.f_convertDateToChar(inventory_in)str_inventory_in, inventory_in,sn, device,inventory_type,vendor_name, case when inventory_sts=1 then 'checked' else '' end html_inventory, case when (select 1 from v_tec_borrow_service_device a where a.inventory_device_id=v_tec_inventory_device.inventory_device_id and a.borrow_sts=1)=1 then 'checked' else '' end html_borrow from v_tec_inventory_device where inventory_type_id like @type and device like @device and vendor_name like @vendor and sn like @sn and inventory_sts=@sts">
        <SelectParameters>
            <asp:QueryStringParameter Name="type" QueryStringField="type" DefaultValue="%"/>
            <asp:QueryStringParameter Name="device" QueryStringField="device" DefaultValue=" "/>
            <asp:QueryStringParameter Name="vendor" QueryStringField="vendor" DefaultValue=" "/>
            <asp:QueryStringParameter Name="sts" QueryStringField="sts" DefaultValue="0"/>
            <asp:QueryStringParameter Name="sn" QueryStringField="sn" DefaultValue="0"/>
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10">
        <Columns>
            <asp:BoundField DataField="str_inventory_in" HeaderText="Tgl.Masuk" ReadOnly="True" SortExpression="inventory_in" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="sn" HeaderText="SN" ReadOnly="True" SortExpression="sn" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="device" HeaderText="Device" ReadOnly="True" SortExpression="device" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="vendor_name" HeaderText="Vendor" ReadOnly="True" SortExpression="vendor_name" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="inventory_type" HeaderText="Tipe" ReadOnly="True" SortExpression="inventory_type" HeaderStyle-HorizontalAlign="Left" />            
            <asp:TemplateField HeaderStyle-Width="70px" HeaderText="Sts.Inventory" SortExpression="html_inventory" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <input type="checkbox" <%# Eval("html_inventory") %> disabled="disabled"/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderStyle-Width="70px" HeaderText="Sts.Pinjaman" SortExpression="html_borrow"  ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <input type="checkbox" <%# Eval("html_borrow") %> disabled="disabled"/>
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

