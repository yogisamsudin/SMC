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
        SelectCommand="select employee_id,nik,employee_name,dbo.f_convertDateToChar(date_in)str_date_in,dbo.f_convertDateToChar(date_out)str_date_out,position_id,status,position_name,case when status=1 then 'Aktif' else 'Non Aktif' end str_status from v_hr_employee where employee_name like @nama">
        <SelectParameters>
            <asp:QueryStringParameter Name="nama" QueryStringField="nama" DefaultValue=" "/>            
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata" 
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        CellSpacing="1" CssClass="gridViewFrame" GridLines="None" PagerSettings-PageButtonCount="10">
        <Columns>
            <asp:TemplateField HeaderStyle-Width="25px">
                <ItemTemplate>
                    <div class="edit" title="edit" onclick="edit(<%# Eval("employee_id") %>);" style="float:left"></div>                    
                </ItemTemplate>
                <HeaderTemplate>
                    <div class="tambah" title="tambah" onclick="tambah(0)"></div>
                </HeaderTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="nik" HeaderText="NIK" ReadOnly="True" SortExpression="nik" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="100px"/>
            <asp:BoundField DataField="employee_name" HeaderText="Nama" ReadOnly="True" SortExpression="employee_name" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="position_name" HeaderText="Jabatan" ReadOnly="True" SortExpression="position_name" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="str_date_in" HeaderText="Tgl.Masuk" ReadOnly="True" SortExpression="str_date_in"  HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" />
            <asp:BoundField DataField="str_status" HeaderText="Status" ReadOnly="True" SortExpression="str_status" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px"/>
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

