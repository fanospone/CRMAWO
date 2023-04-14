<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="CustomerExport.aspx.cs" Inherits="CRMAWO.CustomerExport" %>

<asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <section class="content-header">
        <h1>CRM AWO
        <small>Export Customer</small>
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
                                    <label for="ddlCampaign" class="col-sm-2 control-label" style="text-align: left;">Campaign</label>
                                    <div class="col-sm-5">
                                        <asp:ListBox ID="ddlCampaign" runat="server" CssClass="form-control select2" Style="width: 100%;"></asp:ListBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label for="ddlCampaign" class="col-sm-2 control-label" style="text-align: left;">Date Type</label>
                                    <div class="col-sm-5">
                                        <asp:ListBox ID="ddlType" runat="server" CssClass="form-control select2" Style="width: 100%;">
                                            <asp:ListItem Text="Golive Date" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Call Date" Value="2"></asp:ListItem>
                                        </asp:ListBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label for="ddlCampaign" class="col-sm-2 control-label" style="text-align: left;">Go Live Date</label>
                                    <div class="col-sm-2">
                                        <asp:TextBox ID="txtStart" runat="server" class="form-control"></asp:TextBox>
                                    </div>

                                    <label class="col-sm-1 control-label" style="text-align:center;">-</label>

                                    <div class="col-sm-2">
                                        <asp:TextBox ID="txtEnd" runat="server" class="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="box-body" style="padding-top: 0px">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <div class="col-sm-2">
                                        <asp:LinkButton ID="btnExport" runat="server" ToolTip="Export" Style="float: left" class="btn btn-primary" OnClick="Export_Click"><i class="fa fa-download"></i> Export</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
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
            $('#ctl00_ContentPlaceHolder1_txtStart').datepicker({
                autoclose: true,
                format: "dd M yyyy",
                todayHighlight: true
            });
            $('#ctl00_ContentPlaceHolder1_txtEnd').datepicker({
                autoclose: true,
                format: "dd M yyyy",
                todayHighlight: true
            });
            $(".select2").select2();
        });
    </script>
</asp:Content>
