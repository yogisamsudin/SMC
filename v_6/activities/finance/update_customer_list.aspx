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
        ConnectionString="<%$ ConnectionStrings:csApp %>" 
        SelectCommand="select customer_id, customer_name, npwp, jenisidpembeli_id, jenisidpembeli_name,tkuid from v_act_customer where customer_name like @name">
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
                <HeaderTemplate>
                    <div class="tambah" title="tambah" onclick="tambah()"></div>
                </HeaderTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="customer_name" HeaderText="Customer" ReadOnly="True" SortExpression="customer_name" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="npwp" HeaderText="npwp" ReadOnly="True" SortExpression="npwp" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="jenisidpembeli_id" HeaderText="ID.Jenis ID Pembeli" ReadOnly="True" SortExpression="jenisidpembeli_id" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="jenisidpembeli_name" HeaderText="Nama.Jenis ID Pembeli" ReadOnly="True" SortExpression="jenisidpembeli_name" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="tkuid" HeaderText="ID.TKU" ReadOnly="True" SortExpression="tkuid" HeaderStyle-HorizontalAlign="Left" />
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

