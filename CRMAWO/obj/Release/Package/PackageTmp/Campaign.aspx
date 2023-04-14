<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Campaign.aspx.cs" Inherits="CRMAWO.Campaign" %>


<asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <section class="content-header">
        <h1>CRM AWO
        <small>Campaign</small>
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
                                    <div class="col-sm-1" style="padding: 0 5px 0 0">
                                        <asp:LinkButton ID="lnkBtnCrt" runat="server" ToolTip="Create" style="float:left"  class="btn btn-block btn-primary" OnClick="Create_Click"><i class="fa fa-plus"></i> Create</asp:LinkButton>
                                    </div>
                                    <div class="col-sm-1" style="padding: 0 0 0 5px">
                                        <asp:LinkButton ID="lnkBtnUpd" runat="server" ToolTip="Update" style="float:left"  class="btn btn-block btn-danger" OnClick="Update_Click"><i class="fa fa-edit"></i> Update</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="box-body" style="padding-top: 0px">
                            <asp:GridView runat="server" ID="gvGrid" class="table table-bordered table-hover text-nowrap" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false">
                                <Columns>
                                    <asp:TemplateField HeaderText="">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkBtn" runat="server" ToolTip="Edit" CommandName="NumClick" CommandArgument='<%# Eval("CAMPAIGN_ID") %>' class="btn btn-block btn-warning btn-xs col-sm-2" OnClick="Edit_Click"><i class="fa fa-pencil"></i></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="CAMPAIGN_NAME"
                                        HeaderText="Campaign" />
                                    <asp:BoundField DataField="VERSION"
                                        HeaderText="Version" />
                                    <asp:BoundField DataField="BRAND"
                                        HeaderText="Brand" />
                                    <asp:BoundField DataField="START"
                                        HeaderText="Start" />
                                    <asp:BoundField DataField="TYPE"
                                        HeaderText="Type" />
                                    <asp:BoundField DataField="TYPE_VALUE"
                                        HeaderText="Value" />
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
                "order": [[7, "desc"]],
                "columnDefs": [
                    { "targets": 0, "width": "2%", orderable:false },
                    { "targets": 1, "width": "28%" },
                    { "targets": 2, "width": "7%" },
                    { "targets": 3, "width": "7%" },
                    { "targets": 4, "width": "7%", className: "align-right" },
                    { "targets": 5, "width": "13%" },
                    { "targets": 6, "width": "10%", className: "align-right" },
                    { "type": "date-uk", "targets": 7, className: "align-right", "width": "13%" },
                    { "type": "date-uk", "targets": 8, className: "align-right", "width": "13%" }]
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
