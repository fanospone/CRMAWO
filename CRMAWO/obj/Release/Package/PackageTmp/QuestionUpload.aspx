<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="QuestionUpload.aspx.cs" Inherits="CRMAWO.QuestionUpload" %>

<asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <section class="content-header">
        <h1>CRM AWO
        <small>Upload Question</small>
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
                                    <label for="ddlCampaign" class="col-sm-2 control-label" style="text-align: left;">Campaign</label>
                                    <div class="col-sm-5">
                                        <asp:ListBox ID="ddlCampaign" runat="server" CssClass="form-control select2" Style="width: 100%;"></asp:ListBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label for="txtVersion" class="col-sm-2 control-label" style="text-align: left;">Browse File (.xlsx)</label>
                                    <div class="col-sm-5">
                                        <asp:FileUpload ID="FileUpload1" runat="server" class="btn btn-block btn-flat btn-default btn-sm col-sm-2" />
                                    </div>
                                    <div class="col-sm-1">
                                        <asp:LinkButton ID="btnTemp" runat="server" ToolTip="Template" class="btn btn-default" OnClick="ExportSample_Click"><i class="fa fa-file-o"></i> Template</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label for="txtVersion" class="col-sm-2 control-label" style="text-align: left;"></label>
                                    <asp:Label ID="lblMessage" runat="server" Text="" class="col-sm-5 control-label" Style="text-align: left; font-family: 'Courier New'"></asp:Label>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <div class="col-sm-1">
                                        <asp:LinkButton ID="btnCancel" runat="server" ToolTip="Cancel" class="btn btn-default" OnClick="Cancel_Click"><i class="fa fa-close"></i> Cancel</asp:LinkButton>
                                    </div>
                                    <div class="col-sm-1">
                                        <asp:LinkButton ID="btnSave" runat="server" ToolTip="Upload" class="btn btn-success" OnClick="Save_Click"><i class="fa fa-save"></i> Upload</asp:LinkButton>
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
