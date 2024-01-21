<%@ Page Title="" Language="C#" MasterPageFile="~/page_list.master" Theme="ListPage" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="Body_Content" runat="Server">
    <script type="text/javascript" src="../js/chart_min.js"></script>
    <script type="text/javascript" src="../js/komponen.js"></script>
    <style>
        .konten {
            margin-left: 50px;
        }
    </style>



    <asp:SqlDataSource runat="server" ID="sdsdata" ConnectionString="<%$ ConnectionStrings:csApp %>" SelectCommandType="StoredProcedure" SelectCommand="dashboard_target"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsdata_finance" ConnectionString="<%$ ConnectionStrings:csApp %>" SelectCommandType="StoredProcedure" SelectCommand="dashboard_income_duedate"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsdata_technician" ConnectionString="<%$ ConnectionStrings:csApp %>" SelectCommandType="StoredProcedure" SelectCommand="dashboard_service_device"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsdata_offering" ConnectionString="<%$ ConnectionStrings:csApp %>" SelectCommandType="StoredProcedure" SelectCommand="dashboard_progress_offering"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsdata_marketingresult" ConnectionString="<%$ ConnectionStrings:csApp %>" SelectCommandType="StoredProcedure" SelectCommand="dasbord_marketing_result"></asp:SqlDataSource>

    <div class="konten">
        <label style="font-weight: bold; width: 100%; text-decoration: underline;" id="grafik">Grafik Marketing</label>
        <canvas id="myChart" height="100"></canvas>

        <table border="0" style="width: 100%">
            <tr>
                <th>
                    <br />
                </th>
            </tr>
            <tr style="text-align: left; text-decoration: underline;">
                <th>Marketing Result</th>
            </tr>
            <tr>
                <td>
                    <table>
                        <tr>
                            <th>Target Tahunan</th>
                            <td>
                                <label id="lb_target_tahun"></label>
                            </td>
                        </tr>
                        <tr>
                            <th>Sisa Pencapaian</th>
                            <td>
                                <label id="lb_sisapencapaian"></label>
                            </td>
                        </tr>
                    </table>
                </td>

            </tr>
            <tr>
                <td>
                    <asp:GridView runat="server" ID="gv_mktresult" DataSourceID="sdsdata_marketingresult" AllowSorting="True" AutoGenerateColumns="False"
                        CellSpacing="1" CssClass="gridViewFrame" GridLines="Horizontal" PageSize="100">
                        <Columns>
                            <asp:BoundField DataField="marketing_id" HeaderText="Marketing" HeaderStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="net_jan" HeaderText="Jan" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" />
                            <asp:BoundField DataField="net_feb" HeaderText="Feb" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" />
                            <asp:BoundField DataField="net_mar" HeaderText="Mar" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" />
                            <asp:BoundField DataField="net_apr" HeaderText="Apr" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" />
                            <asp:BoundField DataField="net_mei" HeaderText="Mei" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" />
                            <asp:BoundField DataField="net_jun" HeaderText="Jun" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" />
                            <asp:BoundField DataField="net_jul" HeaderText="Jul" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" />
                            <asp:BoundField DataField="net_aug" HeaderText="Aug" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" />
                            <asp:BoundField DataField="net_sep" HeaderText="Sep" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" />
                            <asp:BoundField DataField="net_okt" HeaderText="Okt" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" />
                            <asp:BoundField DataField="net_nov" HeaderText="Nov" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" />
                            <asp:BoundField DataField="net_des" HeaderText="Des" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" />
                            <asp:BoundField DataField="net_total" HeaderText="Total" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" />
                            <asp:BoundField DataField="pcg" HeaderText="%" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N1}" />
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <th>
                    <br />
                </th>
            </tr>
            <tr style="text-align: left; text-decoration: underline;">
                <th>Target Marketing</th>
            </tr>

            <tr>
                <td>
                    <asp:GridView runat="server" ID="gvdata" DataSourceID="sdsdata"
                        AllowPaging="false" AllowSorting="True" AutoGenerateColumns="False"
                        CellSpacing="1" CssClass="gridViewFrame" GridLines="Horizontal" PageSize="100">
                        <Columns>
                            <asp:BoundField DataField="marketing_id" HeaderText="Marketing" ReadOnly="True" HeaderStyle-HorizontalAlign="Left">
                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="marketing_name" HeaderText="Nama" ReadOnly="True" HeaderStyle-HorizontalAlign="Left">
                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="total_service" HeaderText="Service" ReadOnly="True" HeaderStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Right">
                                <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="total_sales" HeaderText="Sales" ReadOnly="True" HeaderStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Right">
                                <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="total" HeaderText="Total" ReadOnly="True" HeaderStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Right">
                                <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="marketing_target" HeaderText="Target" ReadOnly="True" HeaderStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Right">
                                <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="deficit" HeaderText="Kekurangan" ReadOnly="True" HeaderStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Right">
                                <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </asp:BoundField>
                        </Columns>
                        <PagerSettings Visible="False" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <th>
                    <br />
                </th>
            </tr>

            <tr style="text-align: left; text-decoration: underline;">
                <th>Progres Penawaran</th>
            </tr>
            <tr>
                <td>
                    <asp:GridView runat="server" ID="gv_offering" DataSourceID="sdsdata_offering" AllowSorting="True" AutoGenerateColumns="False"
                        CellSpacing="1" CssClass="gridViewFrame" GridLines="Horizontal" PageSize="100">
                        <Columns>
                            <asp:BoundField DataField="marketing_id" HeaderText="Marketing" HeaderStyle-HorizontalAlign="Left" />
                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <%# Eval("total_konfirmasi_service") %>
                                </ItemTemplate>
                                <HeaderTemplate>
                                    Total<br />
                                    Service<br />
                                    Dikonfirmasi
                                </HeaderTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <%# Eval("total_disetujui_service") %>
                                </ItemTemplate>
                                <HeaderTemplate>
                                    Total<br />
                                    Service<br />
                                    Disetujui
                                </HeaderTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <%# Eval("total_konfirmasi_sales") %>
                                </ItemTemplate>
                                <HeaderTemplate>
                                    Total<br />
                                    Sales<br />
                                    Dikonfirmasi
                                </HeaderTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <%# Eval("total_disetujui_sales") %>
                                </ItemTemplate>
                                <HeaderTemplate>
                                    Total<br />
                                    Sales<br />
                                    Disetujui
                                </HeaderTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <th>
                    <br />
                </th>
            </tr>
            <tr style="text-align: left; text-decoration: underline;">
                <th>Invoice Jatuh Tempo</th>
            </tr>
            <tr>
                <td>
                    <asp:GridView runat="server" ID="gv_finance" DataSourceID="sdsdata_finance" AllowSorting="True" AutoGenerateColumns="False"
                        CellSpacing="1" CssClass="gridViewFrame" GridLines="Horizontal" PageSize="100">
                        <Columns>
                            <asp:BoundField DataField="description" HeaderText="Keterangan" HeaderStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="invoice_value" HeaderText="Nilai" HeaderStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField DataField="profit_value" HeaderText="Profit" HeaderStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField DataField="quantity" HeaderText="Total" HeaderStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Right" />
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <th>
                    <br />
                </th>
            </tr>
            <tr style="text-align: left; text-decoration: underline;">
                <th>Barang Service</th>
            </tr>

            <tr>
                <td>
                    <asp:GridView runat="server" ID="gv_technician" DataSourceID="sdsdata_technician" AllowSorting="True" AutoGenerateColumns="False"
                        CellSpacing="1" CssClass="gridViewFrame" GridLines="Horizontal" PageSize="100">
                        <Columns>
                            <asp:BoundField DataField="operation_status" HeaderText="Status Penawaran" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="300" />
                            <asp:BoundField DataField="quantity" HeaderText="Total" HeaderStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="100" />
                            <asp:TemplateField></asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </div>

    <asp:ScriptManager runat="server" ID="sm">
        <Services>
            <asp:ServiceReference Path="~/activities/activities.asmx" />
        </Services>
    </asp:ScriptManager>


    <script type="text/javascript">

        var ctx = document.getElementById('myChart').getContext('2d');
        var chart = new Chart(ctx, {
            // The type of chart we want to create
            type: 'bar',
            // Configuration options go here
            options: {
                legend: {
                    position: 'right',
                    display: true,
                    labels: {
                        fontColor: 'rgb(255, 99, 132)'
                    }
                },
                title: {
                    display: true,
                    text: 'Perolehan Marketing Perbulan'
                },
                scales: {
                    xAxes: [{
                        display: true,
                        scaleLabel: {
                            display: true,
                            labelString: 'Bulan'
                        }
                    }],
                    yAxes: [{
                        position: 'left',
                        display: true,
                        scaleLabel: {
                            display: true,
                            labelString: 'Nilai dalam Ribuan'
                        }
                    }]
                }
            }
        });

        window.addEventListener("load", function () {

            activities.dashboard_marketing_achievment(
                function (data) {
                    chart.data.labels = data.labels;
                    chart.data.datasets = data.datasets;

                    var ctr = parseInt(250 / chart.data.datasets.length);
                    var clr;

                    for (var i in chart.data.datasets) {
                        clr = (ctr * i).toString();
                        chart.data.datasets[i].backgroundColor = 'rgb(' + clr + ',' + clr + ', ' + clr + ')';
                        chart.data.datasets[i].borderColor = 'rgb(' + clr + ',' + clr + ', ' + clr.toString() + ')';
                    }

                    chart.update();
                }, apl.func.showError, ""
            );

            activities.xml_dashboard_init(
                function (data) {
                    document.getElementById("lb_target_tahun").innerHTML = apl.func.formatNumeric(data.targettahunan);
                    document.getElementById("lb_sisapencapaian").innerHTML = apl.func.formatNumeric(data.sisapencapaian);
                }, apl.func.showError, ""
            );

        });


    </script>
</asp:Content>

