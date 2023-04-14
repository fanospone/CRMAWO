<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Customer.aspx.cs" Inherits="CRMAWO.Customer" %>


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
                                        <asp:ListBox ID="ddlCampaign" runat="server" CssClass="form-control select2" Style="width: 100%;" OnSelectedIndexChanged="myListDropDown_Change" AutoPostBack="true"></asp:ListBox>
                                    </div>
                                    <label for="ddlCampaign" class="col-sm-2 control-label" style="text-align: left;">Is Close ?</label>
                                    <div class="col-sm-4">
                                        <asp:DropDownList ID="ddlIsClose" runat="server" class="form-control select2" Style="width: 100%;" OnSelectedIndexChanged="myListDropDown_Change" AutoPostBack="true">
                                            <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label for="ddlCampaignResult" class="col-sm-2 control-label" style="text-align: left;">Campaign Result</label>
                                    <div class="col-sm-4">
                                        <asp:DropDownList ID="ddlCampaignResult" runat="server" class="form-control select2" Style="width: 100%;" OnSelectedIndexChanged="myListDropDown_Change" AutoPostBack="true">
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
                            <div class="col-sm-4">
                                <h4 class="modal-title" id="insertmodaltitle"></h4>
                            </div>
                            <div class="col-sm-2">
                                <button id="phoneid" type="button" class="btn btn-success btn-sm" data-id="0" onclick="showphonelist();">Phone List</button>
                            </div>
                        </div>
                        <div class="modal-body">
                            <div class="box-body" style="padding: 0 0 0 0">
                                <div class="col-md-4">
                                    <div class="form-group" style="margin-bottom: 8px">
                                        <label for="" class="col-sm-6 control-label" style="text-align: left;">Call</label>
                                        <div class="col-sm-6">
                                            <input type="hidden" id="agrmnt" />
                                            <input type="hidden" id="campaignid" />
                                            <input id="toggle-call" type="checkbox" data-size="small" data-toggle="toggle" data-on="Yes" data-off="No">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <div class="form-group" style="margin-bottom: 8px">
                                        <label for="" class="col-sm-2 control-label" style="text-align: left;">Start Call</label>
                                        <div class="col-sm-3">
                                            <asp:TextBox ID="txtStartCall" runat="server" class="form-control" ReadOnly></asp:TextBox>
                                        </div>
                                        <label for="" class="col-sm-2 control-label" style="text-align: left;">End Call</label>
                                        <div class="col-sm-3">
                                            <asp:TextBox ID="txtEndCall" runat="server" class="form-control" ReadOnly></asp:TextBox>
                                        </div>
                                        <div class="col-sm-1">
                                            <button id="tlpEnd" type="button" class="btn btn-block btn-danger btn-sm" disabled><i class="fa fa-phone"></i></button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group" style="margin-bottom: 8px">
                                        <label for="" class="col-sm-6 control-label" style="text-align: left;">Connected</label>
                                        <div class="col-sm-6">
                                            <input id="toggle-connect" type="checkbox" data-size="small" data-toggle="toggle" data-on="Yes" data-off="No">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <div class="form-group" style="margin-bottom: 8px">
                                        <label for="" class="col-sm-2 control-label" style="text-align: left;">Unconnected</label>
                                        <div class="col-sm-3">
                                            <asp:DropDownList ID="ddlUnconnect" runat="server" class="form-control select2 selectmodal" Style="width: 100%;">
                                                <asp:ListItem Text="[Select One]" Value=""></asp:ListItem>
                                                <asp:ListItem Text="Telepon Sibuk, Mailbox" Value="Telepon Sibuk, Mailbox"></asp:ListItem>
                                                <asp:ListItem Text="Telepon diputus Customer" Value="Telepon diputus Customer"></asp:ListItem>
                                                <asp:ListItem Text="Telepon dalam perbaikan" Value="Telepon dalam perbaikan"></asp:ListItem>
                                                <asp:ListItem Text="Telepon tidak diangkat" Value="Telepon tidak diangkat"></asp:ListItem>
                                                <asp:ListItem Text="Telepon tidak terdaftar" Value="Telepon tidak terdaftar"></asp:ListItem>
                                                <asp:ListItem Text="Tulalit" Value="Tulalit"></asp:ListItem>
                                                <asp:ListItem Text="Telepon tidak dapat dihubungi" Value="Telepon tidak dapat dihubungi"></asp:ListItem>
                                                <asp:ListItem Text="Tidak Tersambung" Value="Tidak Tersambung"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <label for="" class="col-sm-2 control-label" style="text-align: left;">Follow Up</label>
                                        <div class="col-sm-3">
                                            <asp:TextBox ID="txtFlwUp" runat="server" class="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group" style="margin-bottom: 8px">
                                        <label for="" class="col-sm-6 control-label" style="text-align: left;">Contacted</label>
                                        <div class="col-sm-6">
                                            <input id="toggle-contact" type="checkbox" data-size="small" data-toggle="toggle" data-on="Yes" data-off="No">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <div class="form-group" style="margin-bottom: 8px">
                                        <label for="" class="col-sm-2 control-label" style="text-align: left;">Uncontacted</label>
                                        <div class="col-sm-3">
                                            <asp:DropDownList ID="ddlUncontact" runat="server" class="form-control select2 selectmodal" Style="width: 100%;">
                                                <asp:ListItem Text="[Select One]" Value=""></asp:ListItem>
                                                <asp:ListItem Text="Customer Sibuk" Value="Customer Sibuk"></asp:ListItem>
                                                <asp:ListItem Text="Customer Tidak Ditempat" Value="Customer Tidak Ditempat"></asp:ListItem>
                                                <asp:ListItem Text="Customer Sedang Meeting" Value="Customer Sedang Meeting"></asp:ListItem>
                                                <asp:ListItem Text="Customer Pindah" Value="Customer Pindah"></asp:ListItem>
                                                <asp:ListItem Text="Salah Sambung" Value="Salah Sambung"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <label for="" class="col-sm-2 control-label" style="text-align: left;">Telephone Type</label>
                                        <div class="col-sm-3">
                                            <asp:DropDownList ID="ddlTelephone" runat="server" class="form-control select2 selectmodal" Style="width: 100%;">
                                                <asp:ListItem Text="[Select One]" Value=""></asp:ListItem>
                                                <asp:ListItem Text="Mobile Phone" Value="Mobile Phone"></asp:ListItem>
                                                <asp:ListItem Text="Home Phone" Value="Home Phone"></asp:ListItem>
                                                <asp:ListItem Text="Office Phone" Value="Office Phone"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group" style="margin-bottom: 8px">
                                        <label for="" class="col-sm-6 control-label" style="text-align: left;">Close</label>
                                        <div class="col-sm-6">
                                            <input id="toggle-close" type="checkbox" data-size="small" data-toggle="toggle" data-on="Yes" data-off="No">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <div class="form-group" style="margin-bottom: 8px">
                                        <label for="" class="col-sm-2 control-label" style="text-align: left;">Campaign Result</label>
                                        <div class="col-sm-3">
                                            <asp:DropDownList ID="ddlCampaignRes" runat="server" class="form-control select2 selectmodal" Style="width: 100%;">
                                                <asp:ListItem Text="[Select One]" Value=""></asp:ListItem>
                                                <asp:ListItem Text="Appointment" Value="Appointment"></asp:ListItem>
                                                <asp:ListItem Text="Bersedia diverifikasi" Value="Bersedia diverifikasi"></asp:ListItem>
                                                <asp:ListItem Text="Bersedia diverifikasi - Tidak complete" Value="Bersedia diverifikasi - Tidak complete"></asp:ListItem>
                                                <asp:ListItem Text="Telepon di reject" Value="Telepon di reject"></asp:ListItem>
                                                <asp:ListItem Text="Tidak bersedia diverifikasi" Value="Tidak bersedia diverifikasi"></asp:ListItem>
                                                <asp:ListItem Text="Tidak bersedia - Tidak ada waktu" Value="Tidak bersedia - Tidak ada waktu"></asp:ListItem>
                                                <asp:ListItem Text="Tidak dilakukan verifikasi" Value="Tidak dilakukan verifikasi"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                </div>
                                <div class="col-md-8">
                                    <div class="form-group" style="margin-bottom: 8px">
                                        <label for="" class="col-sm-2 control-label" style="text-align: left;">Note</label>
                                        <div class="col-sm-8">
                                            <asp:TextBox ID="txtNote" runat="server" class="form-control" Rows="2" TextMode="MultiLine"></asp:TextBox>
                                        </div>

                                    </div>
                                </div>
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
                            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-close"></i> Cancel</button>
                            <button type="button" class="btn btn-success" onclick="save()"><i class="fa fa-save"></i> Save</button>
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
                                        <th>Campaign Result</th>
                                        <th>Note</th>
                                        <th>Follow Up</th>
                                        <th>Create Date</th>
                                    </thead>
                                </table>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-close"></i> Close</button>
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <div class="modal fade" id="phone" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Phone List</h4>
                        </div>
                        <div class="modal-body">
                            <div class="box-body" style="padding: 0 0 0 0">
                                <table id="tbphone" class="table table-bordered table-hover text-nowrap" style="width: 100% !important;">
                                    <thead>
                                        <th>Contact Type</th>
                                        <th>Number</th>
                                    </thead>
                                </table>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-close"></i> Close</button>
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
        var tbphone;
        $(function () {
            $('.modal').on('hidden.bs.modal', function (e) {
                if ($('.modal').hasClass('in')) {
                    $('body').addClass('modal-open');
                }
            });
            $(".select2").select2();
            $('#ctl00_ContentPlaceHolder1_txtFlwUp').datepicker({
                autoclose: true,
                format: "dd M yyyy",
                todayHighlight: true
            });
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
            $('#toggle-call').change(function () {
                if ($(this).prop('checked') == true) {
                    $('#ctl00_ContentPlaceHolder1_txtStartCall').val(moment().format('MM/DD/YYYY HH:mm:ss'));
                    $("#tlpEnd").prop('disabled', false);
                }
                else {
                    $('#ctl00_ContentPlaceHolder1_txtStartCall').val("");
                    $('#ctl00_ContentPlaceHolder1_txtEndCall').val("");
                    $("#tlpEnd").prop('disabled', true);
                }
            });
            $('#toggle-connect').change(function () {
                if ($(this).prop('checked') == true) {
                    $("#ctl00_ContentPlaceHolder1_ddlUnconnect").val("").trigger("change");
                    $("#ctl00_ContentPlaceHolder1_ddlUnconnect").prop('disabled', true);
                }
                else {
                    $("#ctl00_ContentPlaceHolder1_ddlUnconnect").prop('disabled', false);
                }
            });
            $('#toggle-contact').change(function () {
                if ($(this).prop('checked') == true) {
                    $("#ctl00_ContentPlaceHolder1_ddlUncontact").val("").trigger("change");
                    $("#ctl00_ContentPlaceHolder1_ddlUncontact").prop('disabled', true);
                }
                else {
                    $("#ctl00_ContentPlaceHolder1_ddlUncontact").prop('disabled', false);
                }
            });
            $('#tlpEnd').on('click', function () {
                $('#ctl00_ContentPlaceHolder1_txtEndCall').val(moment().format('MM/DD/YYYY HH:mm:ss'));
            });
            $('#insertmodal').on('hidden.bs.modal', function () {
                $('#toggle-call').bootstrapToggle('off');
                $('#toggle-connect').bootstrapToggle('off');
                $('#toggle-contact').bootstrapToggle('off');
                $('#toggle-close').bootstrapToggle('off');
                //table.destroy();
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
        function save() {
            swal({
                title: "Are you sure?",
                text: "You will save this data!",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "Yes, save it!",
                closeOnConfirm: false
            },
            function () {
                var data = saveanswer();
                savecallinfo(data);
            });
        }
        function saveanswer() {
            var answer = [];
            var data = tbquestion.rows().data();
            $.each(data, function (index, value) {
                answer.push({
                    questionid: value[0],
                    agrmnt: $('#agrmnt').val(),
                    campaignid: $('#ctl00_ContentPlaceHolder1_ddlCampaign').val(),
                    answer: $('#answer' + index).val()
                });
            });
            return JSON.stringify(answer);
        }
        function savecallinfo(datas) {
            var callv = 0;
            if ($('#toggle-call').prop('checked') == true) {
                callv = 1;
            }
            var connectv = 0;
            if ($('#toggle-connect').prop('checked') == true) {
                connectv = 1;
            }
            var contactv = 0;
            if ($('#toggle-contact').prop('checked') == true) {
                contactv = 1;
            }
            var closev = 0;
            if ($('#toggle-close').prop('checked') == true) {
                closev = 1;
            }
            var callinfo = {
                agrmnt: $('#agrmnt').val(),
                campaignid: $('#campaignid').val(),
                call: callv,
                start: $("#ctl00_ContentPlaceHolder1_txtStartCall").val(),
                end: $("#ctl00_ContentPlaceHolder1_txtEndCall").val(),
                connect: connectv,
                reasonconn: $("#ctl00_ContentPlaceHolder1_ddlUnconnect").val(),
                contact: contactv,
                reasoncont: $("#ctl00_ContentPlaceHolder1_ddlUncontact").val(),
                telptype: $("#ctl00_ContentPlaceHolder1_ddlTelephone").val(),
                close: closev,
                campaignres: $("#ctl00_ContentPlaceHolder1_ddlCampaignRes").val(),
                note: $("#ctl00_ContentPlaceHolder1_txtNote").val(),
                followup: $("#ctl00_ContentPlaceHolder1_txtFlwUp").val()
            };

            var callinfo = JSON.stringify(callinfo);
            $.ajax({
                url: "WebService1.asmx/InsertCallInfo",
                type: "POST",
                dataType: 'json',
                data: {
                    "callinfo": callinfo,
                    "data": datas
                },
                success: function (result) {
                    var tes = result;
                    if (result.Result == "Success") {
                        swal({
                            title: "Successful!",
                            text: result.Message,
                            type: "success",
                            showCancelButton: false,
                            closeOnConfirm: true,
                        },
                        function () {
                            location.reload();
                        });
                    }
                    else {
                        swal({
                            title: "Failed!",
                            text: result.Message,
                            type: "error",
                            showCancelButton: false,
                            closeOnConfirm: true,
                        },
                        function () {
                        });
                    }
                }
            });
        }
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
        function generatetablephone(i) {
            $.ajax({
                url: "WebService1.asmx/GetCustPhone",
                type: "POST",
                dataType: 'json',
                data: {
                    "agrmntno": i
                },
                success: function (result) {
                    settablephone(result.data);
                }
            });
        }
        function settablephone(data) {
            tbphone = $('#tbphone').DataTable({
                "destroy": true,
                "paging": false,
                "lengthChange": false,
                "searching": false,
                "info": false,
                "autoWidth": false,
                "ordering": false,
                "data": data,
                "columnDefs": [
                    {
                        "targets": 0,
                        "width": "50%",
                        "orderable": false
                    },
                    {
                        "targets": 1,
                        "width": "50%",
                        "orderable": false
                    }]
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
                    { "targets": 2, "width": "58%", "orderable": false },
                    {
                        "render": function (data, type, row, meta) {
                            var dis = "";
                            if (data == null || data == "") {
                                data = "";
                            }
                            else {
                                // dis = "disabled";
                            }
                            if (row[4] == "TEXT") {
                                return [
                                '<textarea rows="3" class="form-control" id="answer' + meta.row + '" style="width:100% !important" ' + dis + '>' + data + '</textarea>'
                                ].join('');
                            }
                            else {
                                var opsi = '<option disabled selected value>= Select One =</option><option value="Yes">Yes</option><option value="No">No</option></select>';
                                if (data == "No") {
                                    opsi = '<option disabled>= Select One =</option><option value="Yes">Yes</option><option value="No" selected>No</option></select>';
                                }
                                else if (data == "Yes") {
                                    opsi = '<option disabled>= Select One =</option><option value="Yes" selected>Yes</option><option value="No">No</option></select>';
                                }
                                return [
                                '<select class="form-control select2 selectyesno" id="answer' + meta.row + '" style="width:100% !important" >' +
                                    opsi
                                ].join('');
                            }
                        },
                        "targets": 3,
                        "width": "40%",
                        "orderable": false
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
                    if (result.campaignres != "") {
                        $("#ctl00_ContentPlaceHolder1_ddlCampaignRes").val(result.campaignres).trigger("change");

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
            $("#phoneid").data("id", data[2]);
            generatetable(campaign, data[2]);
            generatecallinfo(data[2], campaign);
            $('#agrmnt').val(data[2]);
            $('#campaignid').val(campaign);
            $('#insertmodaltitle').html("<b>Call Information</b> <small>" + data[2] + " - " + data[4] + "</small>");
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
        function showphonelist() {
            generatetablephone($("#phoneid").data("id"));
            $("#phone").attr("data-backdrop", "static");
            $('#phone').modal('show');
        }
    </script>
</asp:Content>
