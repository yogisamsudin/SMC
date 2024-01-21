<%@ Page Title="" Language="C#" MasterPageFile="~/page_list.master" theme="ListPage"%>

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
        SelectCommand="aspx_fin_sales_list"
        SelectCommandType="StoredProcedure"
        >
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="no" Name="invoice_no" DefaultValue=" " />
            <asp:QueryStringParameter QueryStringField="kf" Name="invoice_id" DefaultValue="%" />
            <asp:QueryStringParameter QueryStringField="cust" Name="customer_name" DefaultValue="%" />
            <asp:QueryStringParameter QueryStringField="paid" Name="paid_sts"/>
            <asp:QueryStringParameter QueryStringField="branch" Name="branch_id" />
            <asp:QueryStringParameter QueryStringField="offer" Name="offer_no" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10">
        <Columns>
            <asp:TemplateField HeaderStyle-Width="25px">
                <ItemTemplate>
                    <div class="edit" title="edit" onclick="edit(<%# Eval("invoice_sales_id") %>);"></div>
                </ItemTemplate>
                <HeaderTemplate>
                    <div class="tambah" title="tambah" onclick="tambah()"></div>
                </HeaderTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="invoice_sales_id" HeaderText="Kode Print" ReadOnly="True" SortExpression="invoice_sales_id" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="Invoice_no" HeaderText="No" ReadOnly="True" SortExpression="Invoice_no" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="str_invoice_date" HeaderText="Tanggal" ReadOnly="True" SortExpression="invoice_date" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="branch_name" HeaderText="Cabang" ReadOnly="True" SortExpression="branch_name" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="customer_name" HeaderText="Pelanggan" ReadOnly="True" SortExpression="customer_name" HeaderStyle-HorizontalAlign="Left" />
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

