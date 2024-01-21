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
    <asp:SqlDataSource runat="server" ID="sdsdata" ConnectionString="<%$ ConnectionStrings:csApp %>"  SelectCommand="aspx_exp_service_list" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="location_id" QueryStringField="location_id" DefaultValue=" "/>
            <asp:QueryStringParameter Name="branch_id" QueryStringField="branch" DefaultValue=" "/>
        </SelectParameters>
    </asp:SqlDataSource>

        <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
            AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
            CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10" HeaderStyle-Wrap="true">
            <Columns>
                <asp:TemplateField HeaderStyle-Width="25">
                    <ItemTemplate>
                        <div class="select" title="select" onclick="edit('<%# Eval("service_id") %>');"></div>
                    </ItemTemplate>                    
                </asp:TemplateField>
                <asp:BoundField DataField="str_pickup_date" HeaderText="Tanggal" SortExpression="pickup_date" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100"/>
                <asp:BoundField DataField="print_code" HeaderText="Kode_Print" ReadOnly="True" SortExpression="print_code" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Right"/>
                <asp:BoundField DataField="expedition_type" HeaderText="Tipe" ReadOnly="True" SortExpression="expedition_type" HeaderStyle-HorizontalAlign="Left" />
                <asp:BoundField DataField="customer_name" HeaderText="Pelanggan" ReadOnly="True" SortExpression="customer_name" HeaderStyle-HorizontalAlign="Left" />
                <asp:BoundField DataField="pickup_address_location" HeaderText="Alamat_#1" SortExpression="pickup_address_location" HeaderStyle-HorizontalAlign="Left"/>                                
                <asp:BoundField DataField="device_status" HeaderText="Status" SortExpression="device_status" HeaderStyle-HorizontalAlign="Left"/>
            </Columns>
        </asp:GridView>
        <script type="text/javascript">
            document.edit = edit = function (id,alamat) {
                window.parent.document["<%= function_edit_name %>"](id);
            }
            document.tambah = tambah = function () {
                window.parent.document["<%= function_add_name %>"]();
            }

            document.refresh = function () { theForm.submit(); }
        </script>
</asp:Content>

