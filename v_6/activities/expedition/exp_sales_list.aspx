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
    <asp:SqlDataSource runat="server" ID="sdsdata" ConnectionString="<%$ ConnectionStrings:csApp %>"  SelectCommand="aspx_exp_sales_list" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="location_id" QueryStringField="location_id" DefaultValue=" "/>
            <asp:QueryStringParameter Name="branch_id" QueryStringField="branch" DefaultValue=" "/>
        </SelectParameters>
    </asp:SqlDataSource>

        <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
            AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
            CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10">
            <Columns>
                <asp:TemplateField HeaderStyle-Width="25">
                    <ItemTemplate>
                        <div class="select" title="edit" onclick="select('<%# Eval("sales_id") %>');"></div>
                    </ItemTemplate>                    
                </asp:TemplateField>
                <asp:BoundField DataField="str_delivery_date" HeaderText="Tanggal" SortExpression="delivery_date" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100"/>
                <asp:BoundField DataField="customer_name" HeaderText="Pelanggan" ReadOnly="True" SortExpression="customer_name" HeaderStyle-HorizontalAlign="Left" />
                <asp:BoundField DataField="delivery_address_location" HeaderText="Alamat #1" SortExpression="delivery_address_location" HeaderStyle-HorizontalAlign="Left"/>
                <asp:BoundField DataField="delivery_address" HeaderText="Alamat #2" SortExpression="delivery_address" HeaderStyle-HorizontalAlign="Left"/>
                <asp:BoundField DataField="contact_name" HeaderText="Kontak" SortExpression="contact_name" ItemStyle-HorizontalAlign="Center" />                                
            </Columns>
        </asp:GridView>
        <script type="text/javascript">
            document.select = select = function (id) {
                window.parent.document["<%= function_select_name %>"](id);
            }
            document.refresh = function () { theForm.submit(); }
        </script>
</asp:Content>

