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
        SelectCommand="aspx_postpone_list" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="device" QueryStringField="device" DefaultValue=" "/>            
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10">
        <Columns>
            <asp:TemplateField HeaderStyle-Width="25px">
                <ItemTemplate>
                    <div class="edit" title="edit" onclick="edit('<%# Eval("sales_id") %>','<%# Eval("device_id") %>');"></div>
                </ItemTemplate>
                <HeaderTemplate>
                    <%--<div class="tambah" title="tambah" onclick="tambah()"></div>--%>
                </HeaderTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="str_sales_status_marketing_updatedate" HeaderText="Tanggal" ReadOnly="True" SortExpression="sales_status_marketing_updatedate" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="100"/>
            <asp:BoundField DataField="device" HeaderText="Device" ReadOnly="True" SortExpression="device" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="qty" HeaderText="Qty" ReadOnly="True" SortExpression="qty" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="offer_no" HeaderText="No.Penawaran" ReadOnly="True" SortExpression="offer_no" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="customer_name" HeaderText="Customer" ReadOnly="True" SortExpression="customer_name" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="marketing_id" HeaderText="Marketing" ReadOnly="True" SortExpression="marketing_id" HeaderStyle-HorizontalAlign="Left" />
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

