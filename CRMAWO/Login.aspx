<%@ Import Namespace="CRMAWO" %>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CRMAWO.Login" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>TAF - CRM AWO</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.6 -->
    <link rel="stylesheet" href="Styles/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="Styles/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="Styles/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="Styles/css/AdminLTE.min.css">
    <link rel="icon" type="image/png" href="Styles/img/favicon.ico">


    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
</head>
<body class="hold-transition login-page" style="background-image:url(Styles/img/bg.png);background-repeat:no-repeat;background-position:right center; width:100%;height:100%;">
    <div class="login-box" style="margin: 17% auto 10% 17%;">
        <div class="login-logo">
            <a><b>CRM AWO</b></a>
        </div>
        <!-- /.login-logo -->
        <div class="login-box-body">
            <p class="login-box-msg">Sign in to start your session</p>

            <form method="post" runat="server">
                <asp:Panel ID="pnlLogon" runat="server" DefaultButton="btnLogin" Width="100%">
                <div class="form-group has-feedback">
                    <asp:TextBox ID="txtUsername" runat="server" class="form-control" placeholder="Username"></asp:TextBox>
                    <span class="fa fa-user form-control-feedback"></span>
                </div>
                <div class="form-group has-feedback">
                    <asp:TextBox ID="txtPassword" TextMode="Password" runat="server" class="form-control" placeholder="Password"></asp:TextBox>
                    <span class="fa fa-lock form-control-feedback"></span>
                </div>
                <div class="form-group has-feedback">
                    <asp:Label ID="errorLabel" runat="server" class="form-control" style="padding:0 0 0 0;color:red; border:0; background-color:transparent;font-size:11px"></asp:Label>
                </div>
                <div class="row">
                    <div class="col-xs-8">
                    </div>
                    <!-- /.col -->
                    <div class="col-xs-4">
                        <asp:LinkButton ID="btnLogin" runat="server" class="btn btn-primary btn-block btn-flat" OnClick="btnLogin_Click"><i class="fa fa-sign-in"></i> <b>Sign In</b></asp:LinkButton>
                    </div>
                    <!-- /.col -->
                </div>
                </asp:Panel>
            </form>

        </div>
        <!-- /.login-box-body -->
    </div>
    <!-- /.login-box -->

    <!-- jQuery 2.2.3 -->
    <script src="Styles/js/jquery-2.2.3.min.js"></script>
    <!-- Bootstrap 3.3.6 -->
    <script src="Styles/js/bootstrap.min.js"></script>

</body>
</html>
