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
        SelectCommand="select location_id,location_address,distance from v_exp_location where location_address like @address">
        <SelectParameters>
            <asp:QueryStringParameter Name="address" QueryStringField="address" DefaultValue=" "/>
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10">
        <Columns>
            <asp:TemplateField HeaderStyle-Width="25px">
                <ItemTemplate>
                    <div class="select" title="Select" onclick="select('<%# Eval("location_id") %>');"></div>
                </ItemTemplate>                
            </asp:TemplateField>
            <asp:BoundField DataField="location_address" HeaderText="Alamat" ReadOnly="True" SortExpression="location_address" HeaderStyle-HorizontalAlign="Left" />            
            <asp:BoundField DataField="distance" HeaderText="Jarak" ReadOnly="True" SortExpression="distance" HeaderStyle-HorizontalAlign="Left" />            
        </Columns>
    </asp:GridView>
    <script type="text/javascript">
        document.select = select = function (id) {
            window.parent.document["<%= function_select_name %>"](id);
        }        

        document.refresh = theForm.submit;
    </script>
</asp:Content>

