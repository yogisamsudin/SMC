<%@ Page Title="" Language="C#" MasterPageFile="~/page_list.master" theme="ListPage"%>

<script runat="server">
    public string function_edit_name = "list_edit", function_add_name = "list_add", display_add = "";

    void Page_Load(object o, EventArgs e)
    {
        if (Request.QueryString["add"] != null) function_add_name = Request.QueryString["add"].ToString();
        if (Request.QueryString["edit"] != null) function_edit_name = Request.QueryString["edit"].ToString();
        if (Request.QueryString["displayadd"] != null) display_add = "display:none";
        gvdata.DataBind();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="Body_Content" Runat="Server">
    <asp:SqlDataSource runat="server" ID="sdsdata" 
        ConnectionString="<%$ ConnectionStrings:csApp %>" 
        SelectCommand="select onsite_id, onsite_no, customer_name, dbo.f_convertDateToChar(request_date)str_request_date,request_date,dbo.f_convertDateToChar(onsite_date)str_onsite_date,onsite_date,technician_name,marketing_id from v_tec_onsite where marketing_id like @marketing and customer_name like @custname and onsitests_id like @status" SelectCommandType="Text">
        <SelectParameters>
            <asp:QueryStringParameter Name="marketing" QueryStringField="marketing" DefaultValue=" "/>          
            <asp:QueryStringParameter Name="custname" QueryStringField="custname" DefaultValue=" "/>
            <asp:QueryStringParameter Name="status" QueryStringField="status" DefaultValue=" "/>
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10">
        <Columns>
            <asp:TemplateField HeaderStyle-Width="25px">
                <ItemTemplate>
                    <div class="edit" title="edit" onclick="edit('<%# Eval("onsite_id") %>');"></div>
                </ItemTemplate>    
                <HeaderTemplate>
                    <div class="tambah" title="tambah" onclick="tambah()" style=<%= display_add %>></div>
                </HeaderTemplate>            
            </asp:TemplateField>
            <asp:BoundField DataField="customer_name" HeaderText="Pelanggan" ReadOnly="True" SortExpression="customer_name" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="marketing_id" HeaderText="Marketing" ReadOnly="True" SortExpression="marketing_id" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="100px"/>
            <asp:BoundField DataField="onsite_no" HeaderText="No" ReadOnly="True" SortExpression="onsite_no" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="100px"/>
            <asp:BoundField DataField="str_request_date" HeaderText="Tgl.Aju" ReadOnly="True" SortExpression="request_date" HeaderStyle-HorizontalAlign="Left" />
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

