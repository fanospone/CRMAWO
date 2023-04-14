<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="UserCreate.aspx.cs" Inherits="CRMAWO.UserCreate" %>

<asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <section class="content-header">
        <h1>CRM AWO
        <small>Create/Update User</small>
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
                                    <label for="txtUsername" class="col-sm-2 control-label" style="text-align: left;">Username</label>
                                    <div class="col-sm-4">
                                        <asp:TextBox ID="txtUsername" runat="server" class="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label for="ddlAccess" class="col-sm-2 control-label" style="text-align: left;">Access</label>
                                    <div class="col-sm-4">
                                        <asp:DropDownList ID="ddlAccess" runat="server" class="form-control select2" Style="width: 100%;">
                                            <asp:ListItem Text="AWO" Value="AWO"></asp:ListItem>
                                            <asp:ListItem Text="Supervisor" Value="SPV"></asp:ListItem>
                                            <asp:ListItem Text="TAFS" Value="TAFS"></asp:ListItem>
                                            <asp:ListItem Text="VERIFICATOR" Value="VERIFICATOR"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label for="ddlStatus" class="col-sm-2 control-label" style="text-align: left;">Status</label>
                                    <div class="col-sm-4">
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
