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
        SelectCommand="select borrow_service_id,dbo.f_convertDateToChar(borrow_date)str_borrow_date,borrow_date,customer_name,marketing_id,borrow_sts, case when borrow_sts=0 then '' else 'checked' end html_status from v_tec_borrow_service where 1=case when @id=0 then 1 when @id=borrow_service_id then 1 else 0 end and borrow_sts=@sts and customer_name like @cust">
        <SelectParameters>
            <asp:QueryStringParameter Name="id" QueryStringField="id" DefaultValue="0"/>
            <asp:QueryStringParameter Name="cust" QueryStringField="cust" DefaultValue=" "/>                        
            <asp:QueryStringParameter Name="sts" QueryStringField="sts" DefaultValue=" "/>            
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10">
        <Columns>
            <asp:TemplateField HeaderStyle-Width="25px">
                <ItemTemplate>
                    <div class="edit" title="edit" onclick="edit(<%# Eval("borrow_service_id") %>);"></div>
                </ItemTemplate>
                <HeaderTemplate>
                    <div class="tambah" title="Tambah" onclick="tambah();"></div>
                </HeaderTemplate>
            </asp:TemplateField>            
            <asp:BoundField DataField="borrow_service_id" HeaderText="ID" ReadOnly="True" SortExpression="borrow_service_id" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="100px"/>
            <asp:BoundField DataField="str_borrow_date" HeaderText="Tanggal" ReadOnly="True" SortExpression="borrow_date" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="100px"/>
            <asp:BoundField DataField="customer_name" HeaderText="Pelanggan" ReadOnly="True" SortExpression="customer_name" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="marketing_id" HeaderText="Marketing" ReadOnly="True" SortExpression="marketing_id" HeaderStyle-HorizontalAlign="Left" />            
            <asp:TemplateField HeaderStyle-Width="25px" HeaderText="Sts.Pinjaman" SortExpression="borrow_sts">
                <ItemTemplate>
                    <input type="checkbox" <%# Eval("html_status") %> disabled="disabled"/>                    
                </ItemTemplate>   
                <ItemStyle HorizontalAlign="Center"/>             
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

