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
    <asp:SqlDataSource runat="server" ID="sdsdata" ConnectionString="<%$ ConnectionStrings:csApp %>"  SelectCommand="exp_schedule_unschedule_list" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

        <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
            AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
            CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10" >
            <Columns>
                <asp:TemplateField HeaderStyle-Width="25">
                    <ItemTemplate>
                        <div class="select" title="select" onclick="edit('<%# Eval("id") %>');"></div>
                    </ItemTemplate>                    
                </asp:TemplateField>
                <asp:BoundField DataField="customer_name" HeaderText="Pelanggan" ReadOnly="True" SortExpression="customer_name" HeaderStyle-HorizontalAlign="Left" ItemStyle-Wrap="False" />
                <asp:BoundField DataField="pickup_address_location" HeaderText="Alamat #1" SortExpression="pickup_address_location" HeaderStyle-HorizontalAlign="Left" ItemStyle-Wrap="False" />
                <asp:BoundField DataField="expedition_type" HeaderText="Tipe" SortExpression="expedition_type" HeaderStyle-HorizontalAlign="Left" ItemStyle-Wrap="False" />
                <asp:BoundField DataField="category" HeaderText="Kategori" SortExpression="category" HeaderStyle-HorizontalAlign="Left" ItemStyle-Wrap="False" />                
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

