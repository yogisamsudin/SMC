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
        SelectCommand="select device_register_id, sn,device,device_type,part_sts, case when part_sts=1 then 'checked' else '' end status from v_tec_device_register where sn like @sn">
        <SelectParameters>
            <asp:QueryStringParameter Name="sn" QueryStringField="sn" DefaultValue=" "/>            
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10">
        <Columns>
            <asp:TemplateField HeaderStyle-Width="25px">
                <ItemTemplate>
                    <div class="select" title="edit" onclick="select('<%# Eval("device_register_id") %>');"></div>
                </ItemTemplate>                
            </asp:TemplateField>
            <asp:BoundField DataField="sn" HeaderText="sn" ReadOnly="True" SortExpression="sn" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="device" HeaderText="Device" ReadOnly="True" SortExpression="device" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="device_type" HeaderText="Type" ReadOnly="True" SortExpression="device_type" HeaderStyle-HorizontalAlign="Left" />
            <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Part Sts." SortExpression="part_sts" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <input type="checkbox" <%# Eval("status") %> disabled="disabled"/>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <script type="text/javascript">
        document.select = select = function (id) {
            window.parent.document["<%= function_select_name %>"](id);
        }
        
        document.refresh = theForm.submit;
    </script>
</asp:Content>

