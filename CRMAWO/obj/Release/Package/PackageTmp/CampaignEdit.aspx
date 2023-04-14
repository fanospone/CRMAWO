<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="CampaignEdit.aspx.cs" Inherits="CRMAWO.CampaignEdit" %>

<asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <section class="content-header">
        <h1>CRM AWO
        <small>Edit Campaign</small>
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
                                        <asp:TextBox ID="txtCampaign" runat="server" class="form-control" ReadOnly></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label for="txtBrand" class="col-sm-2 control-label" style="text-align: left;">Brand</label>
                                    <div class="col-sm-5">
                                        <asp:TextBox ID="txtBrand" runat="server" class="form-control" ReadOnly></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label for="txtStart" class="col-sm-2 control-label" style="text-align: left;">Start</label>
                                    <div class="col-sm-5">
                                        <asp:TextBox ID="txtStart" runat="server" class="form-control" ReadOnly></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label for="ddlType" class="col-sm-2 control-label" style="text-align: left;">Type</label>
                                    <div class="col-sm-5">
                                        <asp:TextBox ID="txtType" runat="server" class="form-control" ReadOnly></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label for="txtValue" class="col-sm-2 control-label" style="text-align: left;">Value</label>
                                    <div class="col-sm-5">
                                        <asp:TextBox ID="txtValue" runat="server" class="form-control" ReadOnly></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label for="ddlPaket" class="col-sm-2 control-label" style="text-align: left;">Package</label>
                                    <div class="col-sm-5">
                                        <asp:ListBox ID="ddlPaket" runat="server" SelectionMode="Multiple" CssClass="form-control select2" Style="width: 100%;"></asp:ListBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label for="ddlCampaignX" class="col-sm-2 control-label" style="text-align: left;">Not In</label>
                                    <div class="col-sm-5">
                                        <asp:ListBox ID="ddlCampaignX" runat="server" SelectionMode="Multiple" CssClass="form-control select2" Style="width: 100%;"></asp:ListBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label for="ddlStatus" class="col-sm-2 control-label" style="text-align: left;">Status</label>
                                    <div class="col-sm-5">
                                        <asp:DropDownList ID="ddlStatus" runat="server" class="form-control select2" Style="width: 100%;">
                                            <asp:ListItem Text="Active" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Inactive" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
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
        });
    </script>
</asp:Content>