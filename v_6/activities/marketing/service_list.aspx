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
    <asp:SqlDataSource runat="server" ID="sdsdata" ConnectionString="<%$ ConnectionStrings:csApp %>"  SelectCommandType="StoredProcedure" SelectCommand="aspx_service_list">
        <SelectParameters>
            <asp:QueryStringParameter Name="customer" DefaultValue=" " QueryStringField="customer"/>            
            <asp:QueryStringParameter Name="user" DefaultValue="%" QueryStringField="user"/>
            <asp:QueryStringParameter Name="branch_id" DefaultValue="%" QueryStringField="branchid"/>
        </SelectParameters>
    </asp:SqlDataSource>

        <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
            AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
            CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10" >
            <Columns>
                <asp:TemplateField HeaderStyle-Width="25">
                    <ItemTemplate>
                        <div class="edit" title="edit" onclick="edit('<%# Eval("service_id") %>');"></div>
                    </ItemTemplate>
                    <HeaderTemplate>
                        <div class="tambah" title="tambah" onclick="tambah()"></div>
                    </HeaderTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="str_service_call_date" HeaderText="Tanggal" ReadOnly="True" SortExpression="service_call_date" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="80px"/>
                <asp:BoundField DataField="branch_name" HeaderText="Cabang" ReadOnly="True" SortExpression="branch_name" HeaderStyle-HorizontalAlign="Left"/>
                <asp:BoundField DataField="customer_name" HeaderText="Nama Pelanggan" ReadOnly="True" SortExpression="customer_name" HeaderStyle-HorizontalAlign="Left"/>
                <asp:BoundField DataField="an" HeaderText="an" SortExpression="an" HeaderStyle-HorizontalAlign="Left"/>
                <asp:BoundField DataField="contact_name" HeaderText="Kontak" SortExpression="contact_name" ItemStyle-HorizontalAlign="Center" />                
                <asp:BoundField DataField="str_pickup_date" HeaderText="Tgl.Kurir" SortExpression="pickup_date" ItemStyle-HorizontalAlign="Center" />                
                <asp:BoundField DataField="pickup_address_location" HeaderText="Alamat Kurir #1" SortExpression="pickup_address_location" HeaderStyle-HorizontalAlign="Left" />
                <asp:BoundField DataField="pickup_address" HeaderText="Alamat Kurir #2" SortExpression="pickup_address" HeaderStyle-HorizontalAlign="Left" />
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

            /*
            function edit(UserID) {
                window.parent.document.list_edit(UserID);
            }
            function tambah() {
                window.parent.document.list_tambah();
            }
            */
        </script>
</asp:Content>

