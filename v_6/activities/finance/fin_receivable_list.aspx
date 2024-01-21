<%@ Page Title="" Language="C#" MasterPageFile="~/page_list.master" theme="ListPage"%>

<script runat="server">
    public string function_edit_name = "list_edit", function_add_name = "list_add", add_hide="style='display:none'";

    void Page_Load(object o, EventArgs e)
    {
        if (Request.QueryString["add"] != null) function_add_name = Request.QueryString["add"].ToString();
        if (Request.QueryString["edit"] != null) function_edit_name = Request.QueryString["edit"].ToString();
        if (Request.QueryString["tambahhide"] == null) add_hide = "";        
        gvdata.DataBind();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="Body_Content" Runat="Server">
    <asp:SqlDataSource runat="server" ID="sdsdata" 
        ConnectionString="<%$ ConnectionStrings:csApp %>" 
        SelectCommand="select top 1000 dbo.f_convertDateToChar(reverse_date)str_reverse_date, reverse_date,dbo.f_convertDateToChar(payment_date)str_payment_date,payment_date,receivable_status,reverse_sign_sts,case when reverse_sign_sts = 1 then 'checked=''checked''' else '' end html_reversesign, fin_receivable_id,type_transaction, transaction_date,invoice_no,dbo.f_convertDateToChar(transaction_date) str_transaction_date,pph_amount,receivable_amount,customer_name,type_transaction from v_fin_receivable where invoice_no like @no and reverse_sign_sts like @reverse and receivable_status_id like @status and customer_name like @nama">
        <SelectParameters>
            <asp:QueryStringParameter Name="no" QueryStringField="no" DefaultValue=" "/>            
            <asp:QueryStringParameter Name="reverse" QueryStringField="reverse" DefaultValue=" "/>
            <asp:QueryStringParameter Name="status" QueryStringField="status" DefaultValue=" "/>
            <asp:QueryStringParameter Name="nama" QueryStringField="nama" DefaultValue=" "/>
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10">
        <Columns>
            <asp:TemplateField HeaderStyle-Width="25px">
                <HeaderTemplate>
                    <div class="tambah" title="Tambah" onclick="tambah();" <%= add_hide %>></div>
                </HeaderTemplate>
                <ItemTemplate>
                    <div class="edit" title="edit" onclick="edit(<%# Eval("fin_receivable_id") %>);"></div>
                </ItemTemplate>                
            </asp:TemplateField>
            <asp:BoundField DataField="invoice_no" HeaderText="No.Invoice" ReadOnly="True" SortExpression="invoice_no" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="receivable_status" HeaderText="Status" ReadOnly="True" SortExpression="receivable_status" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="str_transaction_date" HeaderText="Tanggal" ReadOnly="True" SortExpression="transaction_date" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="100px"/>
            <asp:BoundField DataField="str_reverse_date" HeaderText="Tgl.Reverse" ReadOnly="True" SortExpression="reverse_date" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="100px"/>
            <asp:BoundField DataField="str_payment_date" HeaderText="Tgl.Payment" ReadOnly="True" SortExpression="payment_date" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="100px"/>
            <asp:BoundField DataField="customer_name" HeaderText="Nama" ReadOnly="True" SortExpression="customer_name" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="type_transaction" HeaderText="Tipe" ReadOnly="True" SortExpression="type_transaction" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="pph_amount" HeaderText="Pajak" ReadOnly="True" SortExpression="pph_amount" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}"/>
            <asp:BoundField DataField="receivable_amount" HeaderText="Total" ReadOnly="True" SortExpression="receivable_amount" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}"/>            
            <asp:TemplateField HeaderStyle-Width="100px" SortExpression="reverse_sign_sts" HeaderText="Reverse" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <input type="checkbox" disabled="disabled" <%# Eval("html_reversesign") %>/>
                </ItemTemplate>                
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

