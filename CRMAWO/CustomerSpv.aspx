<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="CustomerSpv.aspx.cs" Inherits="CRMAWO.CustomerSpv" %>

<asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <section class="content-header">
        <h1>CRM AWO
        <small>Customer</small>
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
                                    <div class="col-sm-4">
                                        <asp:ListBox ID="ddlCampaign" runat="server" CssClass="form-control select2" Style="width: 100%;"></asp:ListBox>
                                    </div>
                                    <label for="ddlCampaign" class="col-sm-2 control-label" style="text-align: left;">Is Close ?</label>
                                    <div class="col-sm-4">
                                        <asp:DropDownList ID="ddlIsClose" runat="server" class="form-control select2" Style="width: 100%;">
                                            <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label for="ddlCampaignResult" class="col-sm-2 control-label" style="text-align: left;">Campaign Result</label>
                                    <div class="col-sm-4">
                                        <asp:DropDownList ID="ddlCampaignResult" runat="server" class="form-control select2" Style="width: 100%;">
                                            <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                            <asp:ListItem Text="Appointment" Value="Appointment"></asp:ListItem>
                                            <asp:ListItem Text="Bersedia diverifikasi" Value="Bersedia diverifikasi"></asp:ListItem>
                                            <asp:ListItem Text="Bersedia diverifikasi - Tidak complete" Value="Bersedia diverifikasi - Tidak complete"></asp:ListItem>
                                            <asp:ListItem Text="Telepon di reject" Value="Telepon di reject"></asp:ListItem>
                                            <asp:ListItem Text="Tidak bersedia diverifikasi" Value="Tidak bersedia diverifikasi"></asp:ListItem>
                                            <asp:ListItem Text="Tidak bersedia - Tidak ada waktu" Value="Tidak bersedia - Tidak ada waktu"></asp:ListItem>
                                            <asp:ListItem Text="Tidak dilakukan verifikasi" Value="Tidak dilakukan verifikasi"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <label for="ddlCampaign" class="col-sm-2 control-label" style="text-align: left;">Go Live Date</label>
                                    <div class="col-sm-2">
                                        <asp:TextBox ID="txtStart" runat="server" class="form-control date" placeholder="Enter start date"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-2">
                                        <asp:TextBox ID="txtEnd" runat="server" class="form-control date" placeholder="Enter end date"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-2">
                                        <asp:LinkButton ID="btnCancel" runat="server" ToolTip="Search" Style="float: left" class="btn btn-info" OnClick="Search_Click"><i class="fa fa-search"></i> Search</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="box-body" style="padding-top: 0px">
                            <asp:GridView runat="server" ID="gvGrid" class="table table-bordered table-hover text-nowrap" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false">
                                <Columns>
                                    <asp:TemplateField HeaderText="">
                                        <ItemTemplate>
                                            <button type="button" title="Info" class="btn btn-block btn-default btn-xs col-sm-2" onclick="showhistory();"><i class="fa fa-th-list"></i></button>
                                            <%--<asp:LinkButton ID="lnkBtn" runat="server" ToolTip="View" CommandName="NumClick" CommandArgument='<%# Eval("AGRMNT_NO") + "#" + Eval("CAMPAIGN_ID") %>' class="btn btn-block btn-warning btn-xs col-sm-2"><i class="fa fa-phone"></i></asp:LinkButton>--%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="">
                                        <ItemTemplate>
                                            <%--<asp:LinkButton ID="lnkBtn" runat="server" ToolTip="View" CommandName="NumClick" CommandArgument='<%# Eval("AGRMNT_NO") + "#" + Eval("CAMPAIGN_ID") %>' class="btn btn-block btn-warning btn-xs col-sm-2"><i class="fa fa-phone"></i></asp:LinkButton>--%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="AGRMNT_NO"
                                        HeaderText="Agreement No" />
                                    <asp:BoundField DataField="PRODUCT"
                                        HeaderText="Product" />
                                    <asp:BoundField DataField="CUST_NAME"
                                        HeaderText="Customer Name" />
                                    <asp:BoundField DataField="BRANCH"
                                        HeaderText="Branch" />
                                    <asp:BoundField DataField="USR"
                                        HeaderText="User" />
                                    <asp:BoundField DataField="GOLIVE_DT"
                                        HeaderText="Go Live" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="insertmodal" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-lg" style="width: 90%;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="insertmodaltitle"></h4>
                        </div>
                        <div class="modal-body">
                            <div class="box-body" style="padding: 0 0 0 0">
                                <table id="tbquestion" class="table table-bordered table-hover" style="width: 100% !important;">
                                    <thead>
                                        <th></th>
                                        <th>No</th>
                                        <th>Question</th>
                                        <th>Answer</th>
                                    </thead>
                                </table>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal" title="Close"><i class="fa fa-close"></i>Close</button>
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <div class="modal fade" id="history" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="callhistory"></h4>
                        </div>
                        <div class="modal-body">
                            <div class="box-body" style="padding: 0 0 0 0">
                                <table id="tbhistory" class="table table-bordered table-hover text-nowrap" style="width: 100% !important;">
                                    <thead>
                                        <th>Call</th>
                                        <th>Start</th>
                                        <th>End</th>
                                        <th>Connected</th>
                                        <th>Unconnected</th>
                                        <th>Contacted</th>
                                        <th>Uncontacted</th>
                                        <th>Telp Type</th>
                                        <th>Close</th>
                                        <th>Note</th>
                                        <th>Follow Up</th>
                                        <th>Create Date</th>
                                    </thead>
                                </table>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-close"></i>Close</button>
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
        </form>
    </section>

</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <script>
        var table;
        var tbinsertquestion;
        var tbquestion;
        var tbhistory;
        $(function () {
            $('.date').datepicker({
                autoclose: true,
                format: "dd M yyyy",
                todayHighlight: true
            });
            var currentDate = new Date();
            $(".date").datepicker("setDate", currentDate);

            $(".select2").select2();
            table = $('#ctl00_ContentPlaceHolder1_gvGrid').DataTable({
                "paging": true,
                "lengthChange": true,
                "searching": true,
                "info": true,
                "autoWidth": false,
                "order": [[2, "desc"]],
                "columnDefs": [
                    { "targets": 0, "width": "2%", orderable: false },
                    //{ "targets": 1, "width": "2%", orderable: false },
                    {
                        "render": function (data, type, row, meta) {
                            if ($("#ctl00_ContentPlaceHolder1_ddlIsClose").val() == 1) {
                                return [''].join('');
                            }
                            else {
                                return [
                               '<button type="button" title="Call" class="btn btn-block btn-success btn-xs col-sm-2 btncall" onclick="showinsertmodal();"><i class="fa fa-phone"></i></button>'
                                ].join('');
                            }

                        },
                        "targets": 1,
                        "width": "2%",
                        "orderable": false
                    },
                    { "targets": 2, "width": "12%" },
                    { "targets": 3, "width": "7%" },
                    { "targets": 4, "width": "20%" },
                    { "targets": 5, "width": "7%" },
                    { "targets": 6, "width": "7%" },
                    { "type": "date-uk", "targets": 7, className: "align-right", "width": "10%" }]
            });
            $('#ctl00_ContentPlaceHolder1_gvGrid tbody').on('mouseenter', 'tr', function () {
                $(this).addClass('selected');
            });
            $('#ctl00_ContentPlaceHolder1_gvGrid tbody').on('mouseleave', 'tr', function () {
                table.$('tr.selected').removeClass('selected');
            });

            $('#history').on('shown.bs.modal', function () {
                tbhistory.draw(false);
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

        function generatetable(i, j) {
            $.ajax({
                url: "WebService1.asmx/GetQuestion",
                type: "POST",
                dataType: 'json',
                data: {
                    "campaign": i,
                    "agrmnt": j
                },
                success: function (result) {
                    settable(result.data);
                }
            });
        }
        function settable(data) {
            tbquestion = $('#tbquestion').DataTable({
                "destroy": true,
                "paging": false,
                "lengthChange": false,
                "searching": false,
                "info": false,
                "autoWidth": false,
                "data": data,
                "order": [[1, "asc"]],
                "columnDefs": [
                    { "targets": 0, "visible": false },
                    { "targets": 1, "width": "2%", className: "align-right" },
                    { "targets": 2, "width": "58%" },
                    {
                        "render": function (data, type, row, meta) {
                            return data;
                        },
                        "targets": 3,
                        "width": "40%"
                    }

                ]
            });
            $(".selectyesno").select2({
                minimumResultsForSearch: Infinity
            });
        }
        function generatecallinfo(agrmnt, campaignid) {
            $.ajax({
                url: "WebService1.asmx/GetCallInfo",
                type: "POST",
                dataType: 'json',
                data: {
                    "agrmnt": agrmnt,
                    "campaignid": campaignid
                },
                success: function (result) {
                    if (result.call == 1) {
                        $('#toggle-call').bootstrapToggle('on');
                    }
                    if (result.connect == 1) {
                        $('#toggle-connect').bootstrapToggle('on');
                    }
                    if (result.contact == 1) {
                        $('#toggle-contact').bootstrapToggle('on');
                    }
                    if (result.close == 1) {
                        $('#toggle-close').bootstrapToggle('on');
                    }
                    $("#ctl00_ContentPlaceHolder1_txtStartCall").val(result.start);
                    $("#ctl00_ContentPlaceHolder1_txtEndCall").val(result.end);
                    if (result.reasonconn != "") {
                        $("#ctl00_ContentPlaceHolder1_ddlUnconnect").val(result.reasonconn).trigger("change");
                    }
                    if (result.reasoncont != "") {
                        $("#ctl00_ContentPlaceHolder1_ddlUncontact").val(result.reasoncont).trigger("change");
                    }
                    if (result.telptype != "") {
                        $("#ctl00_ContentPlaceHolder1_ddlTelephone").val(result.telptype).trigger("change");
                    }
                    $("#ctl00_ContentPlaceHolder1_txtNote").val(result.note);
                    $('#ctl00_ContentPlaceHolder1_txtFlwUp').datepicker('setDate', result.followup);
                }
            });
        }
        function generatehist(i, j) {
            $.ajax({
                url: "WebService1.asmx/GetHistoryCall",
                type: "POST",
                dataType: 'json',
                data: {
                    "campaign": i,
                    "agrmnt": j
                },
                success: function (result) {
                    tbhistory = $('#tbhistory').DataTable({
                        "destroy": true,
                        "paging": true,
                        "lengthChange": true,
                        "searching": true,
                        "info": true,
                        "autoWidth": false,
                        "scrollX": true,
                        "data": result.data,
                        "order": [[11, "desc"]],
                        "columnDefs": [
                            { "targets": 10, className: "align-right" },
                            { "targets": 11, className: "align-right" }
                        ]
                    });
                }
            });
        }
        function showinsertmodal() {
            var data = table.row('.selected').data();
            var campaign = $('#ctl00_ContentPlaceHolder1_ddlCampaign').val();
            generatetable(campaign, data[2]);
            generatecallinfo(data[2], campaign);
            $('#agrmnt').val(data[2]);
            $('#campaignid').val(campaign);
            $('#insertmodaltitle').html("<b>Call Information</b> <small>" + data[2] + "</small>");
            $("#insertmodal").attr("data-backdrop", "static");
            $('#insertmodal').modal('show');
            $(".selectmodal").select2({
                minimumResultsForSearch: Infinity
            });
        }
        function showhistory() {
            var data = table.row('.selected').data();
            var campaign = $('#ctl00_ContentPlaceHolder1_ddlCampaign').val();
            generatehist(campaign, data[2]);
            $('#callhistory').html("<b>Call History</b> <small>" + data[2] + "</small>");
            $("#history").attr("data-backdrop", "static");
            $('#history').modal('show');
        }
    </script>
</asp:Content>
