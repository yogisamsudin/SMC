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
        SelectCommand="select opr_sales.offer_no,price, dbo.f_convertDateToChar(opr_sales.offer_date)str_offer_date,opr_sales.offer_date,opr_sales_device.sales_id ,tec_device.device_id, device, cost, principal_price,customer_name from tec_device inner join opr_sales_device on opr_sales_device.device_id=tec_device.device_id inner join v_opr_sales opr_sales on opr_sales.sales_id=opr_sales_device.sales_id  where device like @device and customer_name like @customer order by offer_date desc">
        <SelectParameters>
            <asp:QueryStringParameter Name="device" QueryStringField="device" DefaultValue=" "/>
            <asp:QueryStringParameter Name="customer" QueryStringField="customer" DefaultValue="%"/>
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10">
        <Columns>
            <asp:BoundField DataField="str_offer_date" HeaderText="Tanggal" ReadOnly="True" SortExpression="offer_date" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="device" HeaderText="Device" ReadOnly="True" SortExpression="device" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="offer_no" HeaderText="No.Penawaran" ReadOnly="True" SortExpression="offer_no" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="customer_name" HeaderText="Customer" ReadOnly="True" SortExpression="customer_name" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="principal_price" HeaderText="HPP" ReadOnly="True" SortExpression="principal_price" HeaderStyle-HorizontalAlign="right" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Right"/>
            <asp:BoundField DataField="price" HeaderText="HP" ReadOnly="True" SortExpression="price" HeaderStyle-HorizontalAlign="right" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Right"/>
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

