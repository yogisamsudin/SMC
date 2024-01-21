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
        SelectCommand="select coa_id, coa_code, coa_name, parent_coa_id,coa_type_id,coa_type_name from v_acc_coa where coa_code like @kode and coa_name like @coa and parent_coa_id like @root">
        <SelectParameters>
            <asp:QueryStringParameter Name="kode" QueryStringField="kode" DefaultValue=" "/>
            <asp:QueryStringParameter Name="coa" QueryStringField="coa" DefaultValue="%"/>
            <asp:QueryStringParameter Name="root" QueryStringField="root" DefaultValue="%"/>
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10">
        <Columns>
            <asp:TemplateField HeaderStyle-Width="50px">
                <ItemTemplate>
                    <div class="edit" title="edit" onclick="edit(<%# Eval("coa_id") %>);" style="float:left"></div>
                    <div class="tambah" title="tambah child" onclick="tambah(<%# Eval("coa_id") %>);" style="float:right"></div>
                </ItemTemplate>
                <HeaderTemplate>
                    <div class="tambah" title="tambah" onclick="tambah(0)"></div>
                </HeaderTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="coa_code" HeaderText="Kode" ReadOnly="True" SortExpression="coa_code" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="coa_name" HeaderText="COA" ReadOnly="True" SortExpression="coa_name" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="coa_type_name" HeaderText="Tipe" ReadOnly="True" SortExpression="coa_type_name" HeaderStyle-HorizontalAlign="Left" />
        </Columns>
    </asp:GridView>
    <script type="text/javascript">
        document.edit = edit = function (id) {
            window.parent.document["<%= function_edit_name %>"](id);
        }
        document.tambah = tambah = function (id) {
            window.parent.document["<%= function_add_name %>"](id);
        }

        document.refresh = function () { theForm.submit(); }
    </script>
</asp:Content>

