﻿<%@ Page Title="" Language="C#" MasterPageFile="~/page_list.master" Theme="ListPage" %>

<script runat="server">
    void Page_Load(object o, EventArgs e)
    {
        gvdata.DataBind();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="Body_Content" Runat="Server">
    <asp:SqlDataSource runat="server" ID="sdsdata" 
        ConnectionString="<%$ ConnectionStrings:csApp %>" 
        SelectCommand="select marketing_id, marketing_name, marketing_phone from v_act_marketing"></asp:SqlDataSource>

    <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10">
        <Columns>
            <asp:TemplateField HeaderStyle-Width="25px">
                <ItemTemplate>
                    <div class="edit" title="edit" onclick="edit('<%# Eval("marketing_id") %>');"></div>
                </ItemTemplate>
                <HeaderTemplate>
                    <div class="tambah" title="tambah" onclick="tambah()"></div>
                </HeaderTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="marketing_id" HeaderText="ID" ReadOnly="True" SortExpression="marketing_id" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="marketing_name" HeaderText="Nama" SortExpression="marketing_name" HeaderStyle-HorizontalAlign="Left"/>
            <asp:BoundField DataField="marketing_phone" HeaderText="Phone" SortExpression="marketing_phone" HeaderStyle-HorizontalAlign="Left"/>            
        </Columns>
    </asp:GridView>
    <script type="text/javascript">
        document.edit = edit = function (id)
        {
            window.parent.document.list_edit(id);
        }
        document.tambah = tambah = function ()
        {
            window.parent.document.list_tambah();
        }
        document.refresh = theForm.submit;        
    </script>
</asp:Content>

