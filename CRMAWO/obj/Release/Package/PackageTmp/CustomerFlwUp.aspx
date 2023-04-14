<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="CustomerFlwUp.aspx.cs" Inherits="CRMAWO.CustomerFlwUp" %>

<asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <section class="content-header">
        <h1>CRM AWO
        <small>Customer Follow Up</small>
        </h1>
    </section>
    <section class="content">
        <form runat="server" class="form-horizontal">
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-danger">
                        <div class="box-header">
                            <div class="col-md-12">
                                <div class="form-group" style="margin-bottom: 5px">
                                    <div class="col-sm-2">
                                        <asp:LinkButton ID="btnExport" runat="server" ToolTip="Export" Style="float: left" class="btn btn-primary" OnClick="Export_Click"><i class="fa fa-download"></i> Export</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="box-body" style="padding-top: 0px">
                            <asp:GridView runat="server" ID="gvGrid" class="table table-bordered table-hover text-nowrap" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false">
                                <Columns>
                                    <asp:BoundField DataField="CAMPAIGN_NAME"
                                        HeaderText="Campaign" />
                                    <asp:BoundField DataField="AGRMNT_NO"
                                        HeaderText="Agreement No" />
                                    <asp:BoundField DataField="PRODUCT"
                                        HeaderText="Product" />
                                    <asp:BoundField DataField="CUST_NAME"
                                        HeaderText="Customer Name" />
                                    <asp:BoundField DataField="BRANCH"
                                        HeaderText="Branch" />
                                    <asp:BoundField DataField="GOLIVE_DT"
                                        HeaderText="Go Live" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </section>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <script>
        var table;
        $(function () {
            
            table = $('#ctl00_ContentPlaceHolder1_gvGrid').DataTable({
                "paging": true,
                "lengthChange": true,
                "searching": true,
                "info": true,
                "autoWidth": false,
                "order": [[5, "desc"]],
                "columnDefs": [
                    { "targets": 0, "width": "15%" },
                    { "targets": 1, "width": "15%" },
                    { "targets": 2, "width": "10%" },
                    { "targets": 3, "width": "17%" },
                    { "targets": 4, "width": "14%" },
                    { "type": "date-uk", "targets": 5, className: "align-right", "width": "10%" }]
            });
        });
        jQuery.extend(jQuery.fn.dataTableExt.oSort, {
            "date-uk-pre": function (a) {
                var ukDatea = a.split('/');
                return (ukDatea[2] + ukDatea[1] + ukDatea[0]) * 1;
            },

            "date-uk-asc": function (a, b) {
                return ((a < b) ? -1 : ((a > b) ? 1 : 0));
            },

            "date-uk-desc": function (a, b) {
                return ((a < b) ? 1 : ((a > b) ? -1 : 0));
            }
        });
    </script>
</asp:Content>