<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="CampaignCreate.aspx.cs" Inherits="CRMAWO.CampaignCreate" %>

<asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <section class="content-header">
        <h1>CRM AWO
        <small>Create Campaign</small>
        </h1>
    </section>
    <section class="content">
        <form runat="server" class="form-horizontal">
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-danger">
                        <div class="box-header">
                        </div>
                        <div class="box-body" style="padding-top: 0px">
                            <div class="col-md-12">
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label for="txtVersion" class="col-sm-2 control-label" style="text-align: left;">Version</label>
                                    <div class="col-sm-5">
                                        <asp:TextBox ID="txtVersion" runat="server" class="form-control" ReadOnly></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label for="txtCampaign" class="col-sm-2 control-label" style="text-align: left;">Campaign</label>
                                    <div class="col-sm-5">
                                        <asp:TextBox ID="txtCampaign" runat="server" class="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label for="ddlBrand" class="col-sm-2 control-label" style="text-align: left;">Brand</label>
                                    <div class="col-sm-5">
                                        <asp:ListBox ID="ddlBrand" runat="server" CssClass="form-control select2" Style="width: 100%;"></asp:ListBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label for="ddlType" class="col-sm-2 control-label" style="text-align: left;">Type</label>
                                    <div class="col-sm-5">
                                        <asp:DropDownList ID="ddlType" runat="server" class="form-control select2" Style="width: 100%;">
                                            <asp:ListItem Text="Installment" Value="INSTALLMENT"></asp:ListItem>
                                            <asp:ListItem Text="Go Live" Value="GOLIVE"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label for="txtValue" class="col-sm-2 control-label" style="text-align: left;">Value</label>
                                    <div class="col-sm-5">
                                        <asp:TextBox ID="txtValue" runat="server" type="number" class="form-control" min="0"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label for="txtStart" class="col-sm-2 control-label" style="text-align: left;">Start Generate</label>
                                    <asp:HiddenField id="isnegative" runat="server"/>
                                    <div class="col-sm-1">
                                        <input id="toggle-event" type="checkbox" checked data-toggle="toggle" data-on="<i class='fa fa-plus'></i>" data-off="<i class='fa fa-minus'></i>">
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:TextBox ID="txtStart" runat="server" class="form-control" type="number" min="0"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label for="ddlPaket" class="col-sm-2 control-label" style="text-align: left;">Package</label>
                                    <div class="col-sm-5">
                                        <asp:HiddenField ID="hdnPaket" runat="server" value="" />
                                        <asp:ListBox ID="ddlPaket" runat="server" SelectionMode="Multiple" CssClass="form-control select2" Style="width: 100%;"></asp:ListBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label for="ddlCampaignX" class="col-sm-2 control-label" style="text-align: left;">Not In</label>
                                    <div class="col-sm-5">
                                        <asp:HiddenField ID="hdnCampaignX" runat="server" value="" />
                                        <asp:ListBox ID="ddlCampaignX" runat="server" SelectionMode="Multiple" CssClass="form-control select2" Style="width: 100%;"></asp:ListBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <div class="col-sm-1">
                                        <asp:LinkButton ID="btnCancel" runat="server" ToolTip="Cancel" style="float:left"  class="btn btn-default" OnClick="Cancel_Click"><i class="fa fa-close"></i> Cancel</asp:LinkButton>
                                    </div>
                                    <div class="col-sm-1">
                                        <asp:LinkButton ID="btnSave" runat="server" ToolTip="Save" style="float:left"  class="btn btn-success" OnClick="Save_Click"><i class="fa fa-save"></i> Save</asp:LinkButton>
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
            $(".select2").select2();
            $('#ctl00_ContentPlaceHolder1_isnegative').val(0);
            $('#toggle-event').change(function () {
                if ($(this).prop('checked') == true) {
                    $('#ctl00_ContentPlaceHolder1_isnegative').val(0);
                }
                else
                    $('#ctl00_ContentPlaceHolder1_isnegative').val(1);
            });
            $('#ctl00_ContentPlaceHolder1_ddlPaket').on("change", function () {
                var paket = "";
                jQuery.each($("#ctl00_ContentPlaceHolder1_ddlPaket").select2("val"), function (index, item) {
                    paket = paket + item + ",";
                });
                $("#ctl00_ContentPlaceHolder1_hdnPaket").val(paket);
            });
            $('#ctl00_ContentPlaceHolder1_ddlCampaignX').on("change", function () {
                var paket = "";
                jQuery.each($("#ctl00_ContentPlaceHolder1_ddlCampaignX").select2("val"), function (index, item) {
                    paket = paket + item + ",";
                });
                $("#ctl00_ContentPlaceHolder1_hdnCampaignX").val(paket);
            });
            $('#ctl00_ContentPlaceHolder1_ddlType').on("change", function () {
                var type = $('#ctl00_ContentPlaceHolder1_ddlType').val();
                if(type == "GOLIVE")
                {
                    $("#ctl00_ContentPlaceHolder1_txtValue").val("");
                    $("#ctl00_ContentPlaceHolder1_txtValue").prop('disabled', true);
                }
                else
                {
                    $("#ctl00_ContentPlaceHolder1_txtValue").prop('disabled', false);
                }
            });
        });
    </script>
</asp:Content>