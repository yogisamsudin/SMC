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
        SelectCommand="select top 1000 schedule_id, service_id,schedule_date,dbo.f_ConvertDateTochar(schedule_date)str_schedule_date,customer_name,(select count(*) from tec_service_device where tec_service_device.service_id=v_exp_schedule_service.service_id) total from v_exp_schedule_service where expedition_type_id='2' and schedule_id like @id">
        <SelectParameters>
            <asp:QueryStringParameter Name="id" QueryStringField="id" DefaultValue=" "/>
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10">
        <Columns>
            <asp:TemplateField HeaderStyle-Width="25px">
                <ItemTemplate>
                    <div class="select" title="Select" onclick="select(<%# Eval("schedule_id") %>,<%# Eval("service_id") %>,'<%# Eval("str_schedule_date") %>');"></div>
                </ItemTemplate>                
            </asp:TemplateField>
            <asp:BoundField DataField="schedule_id" HeaderText="ID" ReadOnly="True" SortExpression="schedule_id" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="100px"/>
            <asp:BoundField DataField="str_schedule_date" HeaderText="Tanggal" ReadOnly="True" SortExpression="schedule_date" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="100px"/>
            <asp:BoundField DataField="customer_name" HeaderText="Customer" ReadOnly="True" SortExpression="customer_name" HeaderStyle-HorizontalAlign="Left" />            
            <asp:BoundField DataField="Total" HeaderText="Total" ReadOnly="True" SortExpression="Total" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="100px"/>            
        </Columns>
    </asp:GridView>
    <script type="text/javascript">
        document.select = select = function (schedule_id, service_id,schedule_date) {
            window.parent.document["<%= function_select_name %>"](schedule_id, service_id, schedule_date);
        }

        document.refresh = function () { theForm.submit(); }
    </script>
</asp:Content>

