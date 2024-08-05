<%@ Page Title="" Language="C#" MasterPageFile="~/page_list.master" Theme="ListPage" %>

<script runat="server">
    public string function_edit_name = "list_edit", function_add_name = "list_add", style_display = "";

    void Page_Load(object o, EventArgs e)
    {
        if (Request.QueryString["add"] != null) function_add_name = Request.QueryString["add"].ToString();
        if (Request.QueryString["edit"] != null) function_edit_name = Request.QueryString["edit"].ToString();
        if (Request.QueryString["displayadd"] != null) style_display = "display:none;";
        gvdata.DataBind();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="Body_Content" runat="Server">
    <asp:SqlDataSource runat="server" ID="sdsdata"
        ConnectionString="<%$ ConnectionStrings:csApp %>"
        SelectCommand="aspx_opr_sales_list" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="cust" QueryStringField="cust" DefaultValue=" " />
            <asp:QueryStringParameter Name="no" QueryStringField="no" DefaultValue=" " />
            <asp:QueryStringParameter Name="status" QueryStringField="status" DefaultValue=" " />
            <asp:QueryStringParameter Name="fs" QueryStringField="fs" DefaultValue=" " />
            <asp:QueryStringParameter Name="branch_id" QueryStringField="branch" DefaultValue=" " />
            <asp:QueryStringParameter Name="ssm" QueryStringField="ssm" DefaultValue=" " />
            <asp:QueryStringParameter Name="nopo" QueryStringField="nopo" DefaultValue="" />
            <asp:QueryStringParameter Name="followup" QueryStringField="@followup" DefaultValue="%" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata"
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
        CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10">
        <Columns>
            <asp:TemplateField HeaderStyle-Width="25px">
                <ItemTemplate>
                    <div class="edit" title="edit" onclick="edit('<%# Eval("sales_id") %>');" ></div>
                </ItemTemplate>
                <HeaderTemplate>
                    <div class="tambah" title="tambah" onclick="tambah()" style="<%= style_display%>"></div>
                </HeaderTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="offer_no" HeaderText="No.Penawaran" ReadOnly="True" SortExpression="offer_no" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="po_no" HeaderText="No.PO" ReadOnly="True" SortExpression="po_no" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="str_cek_date" HeaderText="Tanggal" ReadOnly="True" SortExpression="cek_date" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="customer_name" HeaderText="Pelanggan" ReadOnly="True" SortExpression="customer_name" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="sales_status" HeaderText="Status" ReadOnly="True" SortExpression="sales_status" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="sales_status_marketing" HeaderText="Mkt.Status" ReadOnly="True" SortExpression="sales_status_marketing" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="reason_marketing" HeaderText="Alasan" ReadOnly="True" SortExpression="reason_marketing" HeaderStyle-HorizontalAlign="Left" />
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

