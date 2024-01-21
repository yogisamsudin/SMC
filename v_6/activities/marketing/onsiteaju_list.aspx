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
        SelectCommand="select onsite_id, onsite_no,dbo.f_convertDateToChar(request_date) str_request_date ,request_date, dbo.f_convertDateToChar(onsite_date)str_onsite_date,onsite_date, offer_no, customer_name, onsitests from v_tec_onsite where customer_name like @custname and offer_no like @offerno and onsitests_id = @status" SelectCommandType="Text">
        <SelectParameters>
            <asp:QueryStringParameter Name="custname" QueryStringField="custname" DefaultValue=" "/>            
            <asp:QueryStringParameter Name="offerno" QueryStringField="offerno" DefaultValue=" "/>   
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
            <asp:BoundField DataField="offer_no" HeaderText="No.Penawaran" ReadOnly="True" SortExpression="offer_no" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="100px"/>
            <asp:BoundField DataField="onsitests" HeaderText="Status" ReadOnly="True" SortExpression="onsitests" HeaderStyle-HorizontalAlign="Left" />
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

