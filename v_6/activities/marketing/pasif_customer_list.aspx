<%@ Page Title="" Language="C#" MasterPageFile="~/page_list.master"  theme="ListPage"%>

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
        ConnectionString="<%$ ConnectionStrings:csApp %>" 
        SelectCommand="select customer_id, customer_name, marketing_id, last_trandate, dbo.f_convertDateToChar(last_trandate)str_last_trandate from v_act_pasif_customer order by last_trandate desc, customer_name">
        <SelectParameters>
            <asp:QueryStringParameter Name="name" QueryStringField="name" DefaultValue=" "/>            
        </SelectParameters>
    </asp:SqlDataSource> 

    <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10">
        <Columns>
            <asp:TemplateField HeaderStyle-Width="25px">
                <ItemTemplate>
                    <div class="edit" title="edit" onclick="edit('<%# Eval("customer_id") %>');"></div>
                </ItemTemplate>              
            </asp:TemplateField>
            <asp:BoundField DataField="customer_name" HeaderText="Customer" ReadOnly="True" SortExpression="customer_name" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="marketing_id" HeaderText="Marketing" ReadOnly="True" SortExpression="marketing_id" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="str_last_trandate" HeaderText="LS.TX.DATE" ReadOnly="True" SortExpression="last_trandate" HeaderStyle-HorizontalAlign="Left" />
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

