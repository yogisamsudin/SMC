<%@ Page Title="" Language="C#" MasterPageFile="~/page_list.master" theme="ListPage"%>

<script runat="server">
    public string function_select_name = "list_select";    

    void Page_Load(object o, EventArgs e)
    {
        if (Request.QueryString["select"] != null) function_select_name = Request.QueryString["select"].ToString();
        gvdata.DataBind();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="Body_Content" Runat="Server">
    <asp:SqlDataSource runat="server" ID="sdsdata" 
        ConnectionString="<%$ ConnectionStrings:csApp %>" 
        SelectCommand="select sales_id, customer_name,delivery_address_location from v_act_sales where sales_id not in (select sales_id from opr_sales) and customer_name like @cust and branch_id like @branch">
        <SelectParameters>
            <asp:QueryStringParameter Name="cust" QueryStringField="cust" DefaultValue="%"/>
            <asp:QueryStringParameter Name="branch" QueryStringField="branch" DefaultValue="%"/>
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10">
        <Columns>
            <asp:TemplateField HeaderStyle-Width="25px">
                <ItemTemplate>
                    <div class="select" title="edit" onclick="select('<%# Eval("sales_id") %>');"></div>
                </ItemTemplate>                
            </asp:TemplateField>
            <asp:BoundField DataField="customer_name" HeaderText="Pelanggan" ReadOnly="True" SortExpression="customer_name" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="delivery_address_location" HeaderText="Alamat Kurir" ReadOnly="True" SortExpression="delivery_address_location" HeaderStyle-HorizontalAlign="Left" />
        </Columns>
    </asp:GridView>
    <script type="text/javascript">
        document.select = select = function (id) {
            window.parent.document["<%= function_select_name %>"](id);
        }

        document.refresh = theForm.submit;
    </script>
</asp:Content>

