<%@ Page Title="" Language="C#" MasterPageFile="~/page_list.master" Theme="ListPage" %>

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
        SelectCommand="aspx_borrow_service_order" SelectCommandType="StoredProcedure">        
    </asp:SqlDataSource>

    <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10">
        <Columns>
            <asp:TemplateField HeaderStyle-Width="25px">
                <ItemTemplate>
                    <div class="edit" title="edit" onclick="edit(<%# Eval("service_id") %>,'<%# Eval("str_schedule_date") %>');"></div>
                </ItemTemplate>                
            </asp:TemplateField>            
            <asp:TemplateField HeaderStyle-Width="25px">
                <ItemTemplate>
                    <span title="<%# Eval("note") %>" style="font-weight:bold;cursor:pointer;">Note</span>                    
                </ItemTemplate>                
            </asp:TemplateField>            
            <asp:BoundField DataField="marketing_id" HeaderText="Marketing" ReadOnly="True" SortExpression="marketing_id" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="str_schedule_date" HeaderText="Tgl.Jadwal" ReadOnly="True" SortExpression="schedule_date" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="100px"/>
            <asp:BoundField DataField="customer_name" HeaderText="Pelanggan" ReadOnly="True" SortExpression="customer_name" HeaderStyle-HorizontalAlign="Left" />
        </Columns>
    </asp:GridView>
    <script type="text/javascript">
        document.edit = edit = function (id,date) {
            window.parent.document["<%= function_edit_name %>"](id,date);
        }
        document.tambah = tambah = function () {
            window.parent.document["<%= function_add_name %>"]();
        }

        document.refresh = function () { theForm.submit(); }
    </script>
</asp:Content>

