<%@ Page Title="" Language="C#" MasterPageFile="~/page_list.master" theme="ListPage"%>

<script runat="server">
    void Page_Load(Object o, EventArgs e)
    {
        
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="Body_Content" Runat="Server">
    <asp:SqlDataSource runat="server" ID="sdsdata" 
            ConnectionString="<%$ ConnectionStrings:csApp %>" 
            SelectCommand="select UserID,UserName,GroupName,Active from v_appUser"></asp:SqlDataSource>

        <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
            AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
            CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10">
            <Columns>
                <asp:TemplateField ItemStyle-Width="25">
                    <ItemTemplate>
                        <div class="edit" title="edit" onclick="edit('<%# Eval("UserID") %>');"></div>
                    </ItemTemplate>
                    <HeaderTemplate>
                        <div class="tambah" title="tambah" onclick="tambah()"></div>
                    </HeaderTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="UserID" HeaderText="ID" ReadOnly="True" 
                    SortExpression="UserID" HeaderStyle-HorizontalAlign="Left" />
                <asp:BoundField DataField="UserName" HeaderText="Name" 
                    SortExpression="UserName" HeaderStyle-HorizontalAlign="Left"/>
                <asp:BoundField DataField="GroupName" HeaderText="Group" 
                    SortExpression="GroupName" HeaderStyle-HorizontalAlign="Left"/>
                <asp:BoundField DataField="Active" HeaderText="Active" 
                    SortExpression="Active" ItemStyle-HorizontalAlign="Center" />
            
            </Columns>
        </asp:GridView>
        <script type="text/javascript">
            function edit(UserID)
            {
                window.parent.document.list_edit(UserID);
            }
            function tambah()
            {
                window.parent.document.list_tambah();
            }            
        </script>
</asp:Content>

