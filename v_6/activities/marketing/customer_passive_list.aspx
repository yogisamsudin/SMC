<%@ Page Title="" Language="C#" MasterPageFile="~/page_list.master" theme="ListPage" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="Body_Content" Runat="Server">
    <asp:SqlDataSource runat="server" ID="sdsdata" 
        ConnectionString="<%$ ConnectionStrings:csApp %>" 
        SelectCommand="select last_offer_date,str_last_offer_date,customer_id,marketing_id, customer_name from v_act_customer_passive where customer_name like @name and marketing_id like @marketing">
        <SelectParameters>
            <asp:QueryStringParameter Name="marketing" QueryStringField="marketing"/>
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
            <asp:BoundField DataField="customer_name" HeaderText="Pelanggan" ReadOnly="True" SortExpression="customer_name" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="str_last_offer_date" HeaderText="Tgl.Trx.Akhr" SortExpression="last_offer_date" HeaderStyle-HorizontalAlign="Left"/>
            <asp:BoundField DataField="marketing_id" HeaderText="Marketing" SortExpression="marketing_id" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
            
        </Columns>
    </asp:GridView>
    <script type="text/javascript">
        document.edit = edit = function (id) {
            window.parent.document.list_edit(id);
        }
        document.tambah = tambah = function () {
            window.parent.document.list_tambah();
        }
        document.refresh = function () { theForm.submit(); }
    </script>
</asp:Content>

