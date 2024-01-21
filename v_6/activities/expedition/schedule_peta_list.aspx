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
        ConnectionString="<%$ ConnectionStrings:csApp %>" SelectCommandType="StoredProcedure" SelectCommand="aspx_schedule_peta_list">
        <SelectParameters>
            <asp:QueryStringParameter Name="date" QueryStringField="date" DefaultValue=" "/>            
            <asp:QueryStringParameter Name="schedule_id" QueryStringField="schedule_id" DefaultValue="false" DbType="Int32"/>
            <asp:QueryStringParameter Name="type" QueryStringField="type" DefaultValue="1"/>
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10" ShowFooter="False">
        <Columns>
            <asp:TemplateField HeaderStyle-Width="25px">
                <ItemTemplate>
                    <div class="edit" title="edit" onclick="edit('<%# Eval("category_id") %>','<%# Eval("service_id") %>');"></div>
                </ItemTemplate>                
            </asp:TemplateField>
            <asp:BoundField DataField="schedule_id" HeaderText="No" ReadOnly="True" SortExpression="schedule_id" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"/>                        
            <asp:TemplateField HeaderText="Geotag" SortExpression="geotag_sts">
                <ItemTemplate>
                    <input type="checkbox" disabled="disabled" <%# Eval("geotag_sts") %>/>
                </ItemTemplate>                
                <ItemStyle HorizontalAlign="Center"/>
            </asp:TemplateField>
            <asp:BoundField DataField="messanger_name" HeaderText="Kurir" ReadOnly="True" SortExpression="messanger_name" HeaderStyle-HorizontalAlign="Left" />            
            <asp:BoundField DataField="customer_name" HeaderText="Pelanggan" ReadOnly="True" SortExpression="customer_name" HeaderStyle-HorizontalAlign="Left" />            
            <asp:BoundField DataField="pickup_address_location" HeaderText="Alamat" ReadOnly="True" SortExpression="pickup_address_location" HeaderStyle-HorizontalAlign="Left" />
        </Columns>
    </asp:GridView>
    <script type="text/javascript">
        var edit= document.edit = function (a,b) { window.parent.document["<%= function_edit_name %>"](a,b); }
        var tambah = document.tambah = function () { window.parent.document["<%= function_add_name %>"](); }
        document.refresh = function () { theForm.submit(); }
    </script>
</asp:Content>

