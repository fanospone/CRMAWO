<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="401.aspx.cs" Inherits="CRMAWO._401" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content-header">
        <h1>CRM AWO
        <small>Unauthorized Access</small>
        </h1>
    </section>
    <section class="content">
        <div class="error-page">
            <h2 class="headline text-yellow">401</h2>

            <div class="error-content">
                <h3><i class="fa fa-warning text-yellow"></i>Oops! Unauthorized Access.</h3>
                <p>You have attempted to access a page that you are not authorized to view.</p>
                <p>If you have any questions, please contact the site administrator.</p>
            </div>
            <!-- /.error-content -->
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
