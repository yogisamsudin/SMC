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
        ConnectionString="<%$ ConnectionStrings:csApp %>" SelectCommand="aspx_service_device_list" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="sn" QueryStringField="sn" DefaultValue=" "/>                        
            <asp:QueryStringParameter Name="status" QueryStringField="status" DefaultValue="%"/>
            <asp:QueryStringParameter Name="name" QueryStringField="name" DefaultValue=" "/>
            <asp:QueryStringParameter Name="status_opr" QueryStringField="status_opr" DefaultValue="%"/>
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10">
        <Columns>
            <asp:TemplateField HeaderStyle-Width="25px">
                <ItemTemplate>
                    <div class="edit" title="edit" onclick="edit(<%# Eval("service_device_id") %>);"></div>
                </ItemTemplate>                
            </asp:TemplateField>
            <asp:BoundField DataField="str_date_in" HeaderText="Tanggal" ReadOnly="True" SortExpression="date_in" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="100px"/>            
            <asp:BoundField DataField="sn" HeaderText="sn" ReadOnly="True" SortExpression="sn" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="device" HeaderText="Device" ReadOnly="True" SortExpression="device" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="customer_name" HeaderText="Pelanggan" ReadOnly="True" SortExpression="customer_name" HeaderStyle-HorizontalAlign="Left" />
            <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Garansi" SortExpression="guarantee_sts" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <input type="checkbox" <%# Eval("status") %> disabled="disabled"/>
                </ItemTemplate>
            </asp:TemplateField>
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
    </script>
</asp:Content>

