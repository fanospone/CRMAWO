<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="User.aspx.cs" Inherits="CRMAWO.User" %>

<asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <section class="content-header">
        <h1>CRM AWO
        <small>User</small>
        </h1>
    </section>
    <section class="content">
        <form runat="server" class="form-horizontal">
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-danger">
                        <div class="box-header">
                            <div class="col-md-12">
                                <div class="form-group" style="margin-bottom: 8px">
                                    <div class="col-sm-1" style="padding: 0 0 0 0">
                                        <asp:LinkButton ID="lnkBtn" runat="server" ToolTip="Create" style="float:left"  class="btn btn-block btn-primary" OnClick="Create_Click"><i class="fa fa-plus"></i> Create</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="box-body" style="padding-top: 0px">
                            <asp:GridView runat="server" ID="gvGrid" class="table table-bordered table-hover text-nowrap" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false">
                                <Columns>
                                    <asp:TemplateField HeaderText="">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkBtn" runat="server" ToolTip="Update" CommandName="NumClick" CommandArgument='<%# (string)Eval("USER_ID") %>' class="btn btn-block btn-warning btn-xs col-sm-2" OnClick="Edit_Click"><i class="fa fa-edit"></i></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="USER_ID"
                                        HeaderText="Username" />
                                    <asp:BoundField DataField="ROLE"
                                        HeaderText="Access" />
                                    <asp:BoundField DataField="IS_ACTIVE"
                                        HeaderText="Status" />
                                    <asp:BoundField DataField="DTM_CRT"
                                        HeaderText="Create Date" />
                                    <asp:BoundField DataField="DTM_UPD"
                                        HeaderText="Update Date" />
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
        $(function () {
            var table = $('.table');
            table.dataTable({
                "paging": true,
                "lengthChange": true,
                "searching": true,
                "info": true,
                "autoWidth": false,
                "order": [[4, "desc"]],
                "columnDefs": [{ "targets": 0, "orderable": false, "width": "2%" },
                    { "targets": 1, "width": "34%" },
                    { "targets": 2, "width": "34%" },
                    { "type": "date-uk", "targets": 3, className: "align-right", "width": "15%" },
                    { "type": "date-uk", "targets": 4, className: "align-right", "width": "15%" }]
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

