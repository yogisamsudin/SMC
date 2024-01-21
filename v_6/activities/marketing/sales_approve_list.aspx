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
        SelectCommand="select sales_status_marketing,sales_id, offer_no, dbo.f_convertDatetochar(offer_date)str_offer_date, offer_date,customer_name, grand_price,net,marketing_id, branch_name, reason_marketing + case when sales_status_id='5' and limit_approve_sts=0 then ' Nunggu Approval' else '' end reason_marketing from v_opr_sales where sales_status_id in ('5') and offer_no like @no and marketing_id like (select case when all_access=1 then '%' else marketing_id end from act_marketing where user_id=@user) and customer_name like @cust and branch_id like @branchid and sales_status_marketing_id='2' and limit_approve_sts=0">
        <SelectParameters>
            <asp:QueryStringParameter Name="user" QueryStringField="user" DefaultValue=" "/>
            <asp:QueryStringParameter Name="no" QueryStringField="no" DefaultValue=" "/>
            <asp:QueryStringParameter Name="cust" QueryStringField="cust" DefaultValue=" "/>
            <asp:QueryStringParameter Name="branchid" QueryStringField="branchid" DefaultValue=" "/>
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10">
        <Columns>
            <asp:TemplateField HeaderStyle-Width="25px">
                <ItemTemplate>
                    <div class="edit" title="edit" onclick="edit(<%# Eval("sales_id") %>);"></div>
                </ItemTemplate>                
            </asp:TemplateField>
            <asp:BoundField DataField="offer_no" HeaderText="No.Penawaran" ReadOnly="True" SortExpression="offer_no" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="str_offer_date" HeaderText="Tanggal" ReadOnly="True" SortExpression="offer_date" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="branch_name" HeaderText="Cabang" ReadOnly="True" SortExpression="branch_name" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="customer_name" HeaderText="Pelanggan" ReadOnly="True" SortExpression="customer_name" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="sales_status_marketing" HeaderText="Status" ReadOnly="True" SortExpression="sales_status_marketing" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"/>
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

