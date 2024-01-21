<%@ Page Title="" Language="C#" MasterPageFile="~/page_list.master"  Theme="ListPage"%>

<script runat="server">
    void Page_Load(object o, EventArgs e)
    {
        gvdata.DataBind();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="Body_Content" Runat="Server">
    <asp:SqlDataSource runat="server" ID="sdsdata" ConnectionString="<%$ ConnectionStrings:csApp %>" SelectCommand="aspx_sales_list" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="customer" DefaultValue=" " QueryStringField="customer"/>
            <asp:QueryStringParameter Name="user" DefaultValue="%" QueryStringField="user"/>
            <asp:QueryStringParameter Name="branch_id" DefaultValue="%" QueryStringField="branchid"/>
        </SelectParameters>
    </asp:SqlDataSource>

        <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
            AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
            CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10">
            <Columns>
                <asp:TemplateField HeaderStyle-Width="25">
                    <ItemTemplate>
                        <div class="edit" title="edit" onclick="edit('<%# Eval("sales_id") %>');"></div>
                    </ItemTemplate>
                    <HeaderTemplate>
                        <div class="tambah" title="tambah" onclick="tambah()"></div>
                    </HeaderTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="str_sales_call_date" HeaderText="Tanggal" ReadOnly="True" SortExpression="sales_call_date" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="80px"/>
                <asp:BoundField DataField="branch_name" HeaderText="Cabang" ReadOnly="True" SortExpression="branch_name" HeaderStyle-HorizontalAlign="Left" />
                <asp:BoundField DataField="customer_name" HeaderText="Nama Pelanggan" ReadOnly="True" SortExpression="customer_name" HeaderStyle-HorizontalAlign="Left" />
                <asp:BoundField DataField="delivery_address_location" HeaderText="Alamat Kirim #1" SortExpression="delivery_address_location" HeaderStyle-HorizontalAlign="Left"/>
                <asp:BoundField DataField="delivery_address" HeaderText="Alamat Kirim #2" SortExpression="delivery_address" HeaderStyle-HorizontalAlign="Left"/>
                <asp:BoundField DataField="an" HeaderText="an" SortExpression="an" HeaderStyle-HorizontalAlign="Left"/>
                <asp:BoundField DataField="contact_name" HeaderText="Kontak" SortExpression="contact_name" ItemStyle-HorizontalAlign="Center" />                
            
            </Columns>
        </asp:GridView>
        <script type="text/javascript">
            function edit(UserID) {
                window.parent.document.list_edit(UserID);
            }
            function tambah() {
                window.parent.document.list_tambah();
            }
            document.refresh = function () { theForm.submit(); }
        </script>
</asp:Content>

