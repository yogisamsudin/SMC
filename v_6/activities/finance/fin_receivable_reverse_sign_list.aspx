<%@ Page Title="" Language="C#" MasterPageFile="~/page_list.master" theme="ListPage"%>

<script runat="server">
    public string function_edit_name = "list_edit", function_add_name = "list_add", add_hide="style='display:none'";

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
        SelectCommand="select fin_receivable_id,type_transaction, transaction_date,invoice_no,dbo.f_convertDateToChar(transaction_date) str_transaction_date,pph_amount,receivable_amount,customer_name,type_transaction from v_fin_receivable where reverse_sign_sts=1 and reverse_date is null">
    </asp:SqlDataSource>

    <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10">
        <Columns>
            <asp:TemplateField HeaderStyle-Width="25px">
                <ItemTemplate>
                    <div class="edit" title="edit" onclick="edit(<%# Eval("fin_receivable_id") %>);"></div>
                </ItemTemplate>                
            </asp:TemplateField>
            <asp:BoundField DataField="invoice_no" HeaderText="No.Invoice" ReadOnly="True" SortExpression="invoice_no" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="str_transaction_date" HeaderText="Tanggal" ReadOnly="True" SortExpression="transaction_date" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="100px"/>
            <asp:BoundField DataField="customer_name" HeaderText="Nama" ReadOnly="True" SortExpression="customer_name" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="type_transaction" HeaderText="Tipe" ReadOnly="True" SortExpression="type_transaction" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="pph_amount" HeaderText="Pajak" ReadOnly="True" SortExpression="pph_amount" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}"/>
            <asp:BoundField DataField="receivable_amount" HeaderText="Total" ReadOnly="True" SortExpression="receivable_amount" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}"/>                        
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

