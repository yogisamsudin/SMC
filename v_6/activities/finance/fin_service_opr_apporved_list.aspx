<%@ Page Title="" Language="C#" MasterPageFile="~/page_list.master" Theme="ListPage" %>

<script runat="server">
    public string function_select_name = "list_select", function_add_name = "list_select";

    void Page_Load(object o, EventArgs e)
    {
        if (Request.QueryString["list_select"] != null) function_add_name = Request.QueryString["list_select"].ToString();        
        gvdata.DataBind();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="Body_Content" Runat="Server">
    <asp:SqlDataSource runat="server" ID="sdsdata" 
        ConnectionString="<%$ ConnectionStrings:csApp %>" 
        SelectCommand="select v_opr_service.service_id, offer_date,offer_no,broker_name,tax_sts,v_act_service.customer_name,v_act_service.an,v_act_service.customer_id, v_act_service.an_id, v_opr_service.branch_name, v_act_service.marketing_id from v_opr_service inner join v_act_service on v_act_service.service_id=v_opr_service.service_id where service_status_id='3' and offer_no like @no and v_opr_service.service_id not in (select service_id from fin_service_opr) and v_opr_service.customer_id like case when @custid=0 then '%' else @custid end  and v_opr_service.an_id like case when @anid=0 then '%' else @anid end and v_opr_service.service_id in (select service_id from v_opr_service_device where service_device_sts_id='3') and v_opr_service.branch_id like @branch">
        <SelectParameters>
            <asp:QueryStringParameter Name="no" QueryStringField="no" DefaultValue=" "/>            
            <asp:QueryStringParameter Name="custid" QueryStringField="custid" DefaultValue=" "/>            
            <asp:QueryStringParameter Name="anid" QueryStringField="anid" DefaultValue=" "/>            
            <asp:QueryStringParameter Name="branch" QueryStringField="branch" DefaultValue=" "/>            
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10">
        <Columns>
            <asp:TemplateField HeaderStyle-Width="25px">
                <ItemTemplate>
                    <div class="select" title="Pilih" onclick="select(<%# Eval("service_id") %>);"></div>
                </ItemTemplate>                
            </asp:TemplateField>
            <asp:BoundField DataField="branch_name" HeaderText="Cabang" ReadOnly="True" SortExpression="branch_name" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="offer_no" HeaderText="No.Penawaran" ReadOnly="True" SortExpression="offer_no" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="broker_name" HeaderText="Broker" ReadOnly="True" SortExpression="broker_name" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="customer_name" HeaderText="Pelanggan" ReadOnly="True" SortExpression="customer_name" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="an" HeaderText="an" ReadOnly="True" SortExpression="an" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="marketing_id" HeaderText="Marketing" ReadOnly="True" SortExpression="marketing_id" HeaderStyle-HorizontalAlign="Left" />
        </Columns>
    </asp:GridView>
    <script type="text/javascript">
        document.select = select = function (id) {
            window.parent.document["<%= function_select_name %>"](id);
        }

        document.refresh = theForm.submit;
    </script>
</asp:Content>

