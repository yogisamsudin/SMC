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
        SelectCommand="select invoice_service_id,invoice_date,dbo.f_convertDateToChar(invoice_date)str_invoice_date,Invoice_no,customer_name,grand_price,total_ppn from v_fin_service where paid_sts=0 and invoice_no like @no and invoice_service_id not in (select invoice_service_id from fin_receivable_service)">
        <SelectParameters>
            <asp:QueryStringParameter Name="no" QueryStringField="no" DefaultValue=" "/>            
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10">
        <Columns>
            <asp:TemplateField HeaderStyle-Width="25px">                
                <ItemTemplate>
                    <div class="edit" title="edit" onclick="edit(<%# Eval("invoice_service_id") %>);"></div>
                </ItemTemplate>                
            </asp:TemplateField>
            <asp:BoundField DataField="invoice_no" HeaderText="No.Invoice" ReadOnly="True" SortExpression="invoice_no" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="str_invoice_date" HeaderText="Tanggal" ReadOnly="True" SortExpression="invoice_date" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="100px"/>
            <asp:BoundField DataField="customer_name" HeaderText="Nama" ReadOnly="True" SortExpression="customer_name" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="total_ppn" HeaderText="Pajak" ReadOnly="True" SortExpression="total_ppn" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}"/>
            <asp:BoundField DataField="grand_price" HeaderText="Total" ReadOnly="True" SortExpression="grand_price" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}"/>            
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

