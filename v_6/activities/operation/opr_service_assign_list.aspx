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
        SelectCommand="select service_device_id, sn, device, customer_name,service_device_sts,dbo.f_convertDateToChar(date_in)str_date_in,case when guarantee_sts=1 then 'checked' else '' end guarantee, branch_name from v_tec_service_device where service_device_sts_id<>'1' and sn like @sn and customer_id like @cust_id and service_device_id not in (select service_device_id from opr_service_device) and branch_id like @branch">
        <SelectParameters>
            <asp:QueryStringParameter Name="sn" QueryStringField="sn" DefaultValue=" "/>            
            <asp:QueryStringParameter Name="cust_id" QueryStringField="cust_id" DefaultValue="%"/>
            <asp:QueryStringParameter Name="branch" QueryStringField="branch" DefaultValue="%"/>
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10">
        <Columns>
            <asp:TemplateField HeaderStyle-Width="25px">
                <ItemTemplate>
                    <div class="select" title="edit" onclick="select('<%# Eval("service_device_id") %>');"></div>
                </ItemTemplate>                
            </asp:TemplateField>
            <asp:BoundField DataField="sn" HeaderText="sn" ReadOnly="True" SortExpression="sn" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="device" HeaderText="Device" ReadOnly="True" SortExpression="device" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="service_device_sts" HeaderText="Status" ReadOnly="True" SortExpression="service_device_sts" HeaderStyle-HorizontalAlign="Left" />
            <asp:TemplateField HeaderText="Garansi" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" SortExpression="guarantee">
                <ItemTemplate>
                    <input type="checkbox" disabled="disabled" <%# Eval("guarantee") %>/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="branch_name" HeaderText="Cabang" ReadOnly="True" SortExpression="branch_name" HeaderStyle-HorizontalAlign="Left" />            
            <asp:BoundField DataField="customer_name" HeaderText="Customer" ReadOnly="True" SortExpression="customer_name" HeaderStyle-HorizontalAlign="Left" />            
        </Columns>
    </asp:GridView>
    <script type="text/javascript">
        document.select = select = function (id) {
            window.parent.document["<%= function_select_name %>"](id);
        }

        document.refresh = theForm.submit;
        
    </script>
</asp:Content>

