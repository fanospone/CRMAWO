<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Customer2.aspx.cs" Inherits="CRMAWO.Customer2" %>


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
                                    <div class="col-sm-4">
                                        <button id="btnSearch" type="button" class="btn btn-default"><i class="fa fa-search"></i>Search</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="box-body" style="padding-top: 0px">
                            <table id="ctl00_ContentPlaceHolder1_gvGrid" class="table table-bordered table-hover text-nowrap" style="font-size: 12.5px;">
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th></th>
                                        <th>Agreement No</th>
                                        <th>Product</th>
                                        <th>Customer Name</th>
                                        <th>Branch</th>
                                        <th>User</th>
                                        <th>Go Live</th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="insertmodal" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-lg" style="width: 90%;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true" onclick="closeRefresh();">&times;</span></button>
                            <div class="col-sm-4">
                                <h4 class="modal-title" id="insertmodaltitle"></h4>
                                <label id="lblagrmnt" hidden></label>
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
                                        <th>Saved Answer</th>
                                    </thead>
                                </table>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal" onclick="closeRefresh();"><i class="fa fa-close"></i>Cancel</button>
                            <button type="button" class="btn btn-success" onclick="save()"><i class="fa fa-save"></i>Save</button>
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
                            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-close"></i>Close</button>
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
        var tbphone;
        var resultHtml;

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
            datatablecustomer();
            //table = $('#ctl00_ContentPlaceHolder1_gvGrid').DataTable({
            //    "paging": true,
            //    "lengthChange": true,
            //    "searching": true,
            //    "info": true,
            //    "autoWidth": false,
            //    "order": [[2, "desc"]],
            //    "columnDefs": [
            //        { "targets": 0, "width": "2%", orderable: false },
            //        //{ "targets": 1, "width": "2%", orderable: false },
            //        {
            //            "render": function (data, type, row, meta) {
            //                if ($("#ctl00_ContentPlaceHolder1_ddlIsClose").val() == 1) {
            //                    return [''].join('');
            //                }
            //                else {
            //                    return [
            //                   '<button type="button" title="Call" class="btn btn-block btn-success btn-xs col-sm-2 btncall" onclick="showinsertmodal();"><i class="fa fa-phone"></i></button>'
            //                    ].join('');
            //                }

            //            },
            //            "targets": 1,
            //            "width": "2%",
            //            "orderable": false
            //        },
            //        { "targets": 2, "width": "12%" },
            //        { "targets": 3, "width": "7%" },
            //        { "targets": 4, "width": "20%" },
            //        { "targets": 5, "width": "7%" },
            //        { "targets": 6, "width": "7%" },
            //        { "type": "date-uk", "targets": 7, className: "align-right", "width": "10%" }]
            //});
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

                    //add OS1886 (23/03/2023)
                    $('#toggle-connect').prop('disabled', false);
                    //$('#toggle-contact').prop('disabled', false);
                    //$('#toggle-close').prop('disabled', false);
                    $("#ctl00_ContentPlaceHolder1_ddlUnconnect").prop('disabled', false);
                    $("#ctl00_ContentPlaceHolder1_txtFlwUp").prop('disabled', false);
                    $("#ctl00_ContentPlaceHolder1_ddlUncontact").prop('disabled', false);
                    $("#ctl00_ContentPlaceHolder1_ddlTelephone").prop('disabled', false);
                    $("ctl00_ContentPlaceHolder1_ddlCampaignRes").prop('disabled', false);
                    $('#ctl00_ContentPlaceHolder1_txtNote').prop('disabled', false);

                    $('#toggle-contact').prop('disabled', true);
                    $('#toggle-close').prop('disabled', true);
                }
                else {
                    $('#ctl00_ContentPlaceHolder1_txtStartCall').val("");
                    $('#ctl00_ContentPlaceHolder1_txtEndCall').val("");
                    $("#tlpEnd").prop('disabled', true);


                    //add OS1886 (23/03/2023)
                    $('#toggle-connect').bootstrapToggle('off');
                    $('#toggle-connect').prop('disabled', true);
                    $('#toggle-contact').bootstrapToggle('off');
                    $('#toggle-contact').prop('disabled', true);
                    $('#toggle-close').bootstrapToggle('off');
                    $('#toggle-close').prop('disabled', true);

                    $('#toggle-connect').prop('disabled', true);
                    $('#toggle-contact').prop('disabled', true);
                    $('#toggle-close').prop('disabled', true);
                    $("#ctl00_ContentPlaceHolder1_ddlUnconnect").prop('disabled', true);
                    $("#ctl00_ContentPlaceHolder1_txtFlwUp").prop('disabled', true);
                    $("#ctl00_ContentPlaceHolder1_ddlUncontact").prop('disabled', true);
                    $("#ctl00_ContentPlaceHolder1_ddlTelephone").prop('disabled', true);
                    $("ctl00_ContentPlaceHolder1_ddlCampaignRes").prop('disabled', true);
                    $('#ctl00_ContentPlaceHolder1_txtNote').prop('disabled', true); 


                }
            });
            $('#toggle-connect').change(function () {
                if ($(this).prop('checked') == true) {
                    $("#ctl00_ContentPlaceHolder1_ddlUnconnect").val("").trigger("change");
                    $("#ctl00_ContentPlaceHolder1_ddlUnconnect").prop('disabled', true);

                    //add OS1886 (23/03/2023)
                    $('#toggle-contact').prop('disabled', false);
                    $('#toggle-close').prop('disabled', true);
                }
                else {
                    $("#ctl00_ContentPlaceHolder1_ddlUnconnect").prop('disabled', false);

                    //add OS1886 (23/03/2023)
                    $('#toggle-contact').bootstrapToggle('off');
                    $('#toggle-contact').prop('disabled', true);
                    $('#toggle-close').bootstrapToggle('off');
                    $('#toggle-close').prop('disabled', true);

                }
            });
            $('#toggle-contact').change(function () {
                if ($(this).prop('checked') == true) {
                    $("#ctl00_ContentPlaceHolder1_ddlUncontact").val("").trigger("change");
                    $("#ctl00_ContentPlaceHolder1_ddlUncontact").prop('disabled', true);

                    //add OS1886 (23/03/2023)
                    $('#toggle-close').prop('disabled', false);
                    $("#tbquestion").find("input,button,textarea,select").attr("disabled", false);
                }
                else {
                    $("#ctl00_ContentPlaceHolder1_ddlUncontact").prop('disabled', false);

                    //add OS1886 (23/03/2023)
                    $('#toggle-close').bootstrapToggle('off');
                    $('#toggle-close').prop('disabled', true);
                    $("#tbquestion").find("input,button,textarea,select").attr("disabled", true);

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
            $("#btnSearch").click(function () {
                datatablecustomer();
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
        function datatablecustomer() {
            table = $('#ctl00_ContentPlaceHolder1_gvGrid').DataTable({
                "destroy": true,
                "paging": true,
                "lengthChange": true,
                "searching": true,
                "ordering": true,
                "info": true,
                "autoWidth": false,
                "scrollX": true,
                "processing": true,
                "serverSide": true,
                "order": [[2, "DESC"]],
                "ajax": {
                    url: "WebService1.asmx/GetDataCustomer",
                    type: "POST",
                    "data": {
                        "id": $('#ctl00_ContentPlaceHolder1_ddlCampaign').val(),
                        "close": $('#ctl00_ContentPlaceHolder1_ddlIsClose').val(),
                        "campaignres": $('#ctl00_ContentPlaceHolder1_ddlCampaignResult').val()
                    }
                },
                "columns": [
                    null,
                    null,
                    { data: "AGRMNT_NO", "name": "AGRMNT_NO" },
                    { data: "PRODUCT", "name": "PRODUCT" },
                    { data: "CUST_NAME", "name": "CUST_NAME" },
                    { data: "BRANCH", "name": "BRANCH" },
                    { data: "USR", "name": "USR" },
                    { data: "GOLIVE_DT", "name": "GOLIVE_DT" }
                ],
                "columnDefs": [
                    {
                        "render": function (data, type, row, meta) {
                            return [
                                '<button type="button" title="Info" class="btn btn-block btn-default btn-xs col-sm-2" onclick="showhistory();"><i class="fa fa-th-list"></i></button>'
                            ].join('');

                        },
                        "targets": 0, "width": "2%", orderable: false
                    },
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
                        "targets": 1, "width": "2%", "orderable": false
                    },
                    { "targets": 2, "width": "12%" },
                    { "targets": 3, "width": "7%" },
                    { "targets": 4, "width": "20%" },
                    { "targets": 5, "width": "7%" },
                    { "targets": 6, "width": "7%" },
                    { "type": "date-uk", "targets": 7, className: "align-right", "width": "10%" }]
            });
        }
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
            var dato = $("#tbquestion");
            dato.find('tr').each(function (i) {
                var $tds = $(this).find('td');
                if ($('#toggle-contact').prop('checked') == false) {
                    var answer1 = "";
                }
                else {
                    var answer1 = $(this).find('#answer').val();
                }


                if (i > 0) {
                    answer.push({
                        questionid: $tds.eq(0).text(),
                        agrmnt: $('#agrmnt').val(),
                        campaignid: $('#ctl00_ContentPlaceHolder1_ddlCampaign').val(),
                        answer: answer1
                    });
                }
            });
            console.log(answer);
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
                contentType: "application/json; charset=utf-8",
                url: "Customer2.aspx/GetQuestion",
                type: "POST",
                dataType: 'json',
                data: JSON.stringify({
                    "campaign": i,
                    "agrmnt": j
                }),
                success: function (result) {

                    settable(result.d);
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
            //console.log(data);
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
                    { "data": "QUESTION_ID", "targets": 0, className: "hidden" },
                    { "data": "QUESTION_NO", "targets": 1, "width": "2%", className: "align-right" },
                    { "data": "QUESTION", "targets": 2, "width": "50%", "orderable": false },
                    {
                        "data": "QLIST",
                        "render": function (data, type, row, meta) {
                            var strJson = JSON.stringify(data);
                            var objJson = JSON.parse(strJson);

                            var optiontype = row.TYPE;
                            var htmlResult = "";
                            var optNum = 1;
                            //console.log(row);
                            //console.log(type);
                            //console.log(meta);

                            if (optiontype == "TEXT") {
                                htmlResult = "<textarea rows='3' class='form - control' id='answer' style='width: 100 % !important'>" + row.ANSWER + "</textarea>";
                            }
                            else if (optiontype == "NUMBER") {
                                var apostrophe = "";
                                var str1 = "'$1'";
                                htmlResult = "<input type='text' class='numbers' onkeypress='return isNumber(event)' value='" + row.ANSWER +"'>";
                            }
                            else {
                                //console.log(row.QLIST);

                                //for (var item in row.QLIST) {
                                for (var i = 0, l = row.QLIST.length; i < l; i++) {
                                    var obj = row.QLIST[i];
                                    var resultCount = objectLength(obj);
                                    //console.log(obj.LsQuestionList);

                                    if (optNum == 1) {
                                        htmlResult = "";

                                        htmlResult += "<select class='form-control select2 selectyesno' id='answer' style='width:100% !important' ><option value = '0'>= Select One =</option>";

                                    }
                                    if (row.ANSWER == obj.LsQuestionList) {
                                        htmlResult += "<option selected value='" + obj.LsQuestionList + "'>" + obj.LsQuestionList + "</option>";
                                    } else {
                                        htmlResult += "<option value='" + obj.LsQuestionList + "'>" + obj.LsQuestionList + "</option>";
                                    }


                                    //console.log(optNum + "=" + l);
                                    //console.log(l);

                                    if (parseInt(optNum) == parseInt(l)) {
                                        htmlResult += "</select>";
                                    }
                                    optNum++;

                                    //console.log(row.QLIST[item].LsQuestionList);
                                }
                                //htmlResult = "<select class='form-control select2 selectyesno' id='answer' style='width:100% !important' ><option value = '0'>= Select One =</option><option value='209'>OFF</option><option value='209'>ON</option><option value='209'>DEAD</option></select>";
                            }

                            //for (var item in objJson) {
                            //    console.log(item);
                            //}
                            console.log(htmlResult);
                            return htmlResult;
                        },
                        "targets": 3,
                        "width": "30%",
                        "orderable": false
                    },
                    { "data": "ANSWER", "targets": 4, "width": "18%", "orderable": false}

                ]
            });
            $(".selectyesno").select2({
                minimumResultsForSearch: Infinity
            });
            if ($('#toggle-contact').prop('checked') == false) {
                $("#tbquestion").find("input,button,textarea,select").attr("disabled", true);
            }
        }
        function getlistquestion(data, type, row, meta) {

            //console.log(row[0]);
            var QuestionId = row[0];
            var agrmntNo = $('#lblagrmnt').text();

            $.ajax({
                contentType: "application/json; charset=utf-8",
                url: "Customer2.aspx/GetQuestionOption",
                type: "POST",
                dataType: 'json',
                data: JSON.stringify({
                    "questionid": QuestionId,
                    "agmtnno": agrmntNo
                }),
                success: function (result) {
                    var results = result.d;
                    //console.log("start here");
                    var resultCount = objectLength(results);
                    var optNum = 1;

                    for (var key in results) {
                        var optionType = results[key].TYPE;

                        if (optionType == "TEXT") {
                            resultHtml = "<textarea rows='3' class='form - control' id='answer' style='width: 100 % !important'></textarea>";
                        } else {
                            if (optNum == 1) {
                                resultHtml = "";

                                resultHtml += "<select class='form-control select2 selectyesno' id='answer' style='width:100% !important' ><option value = '0'>= Select One =</option>";

                            }
                            resultHtml += "<option value='" + results[key].QUESTIONID + "'>" + results[key].QUESTIONLIST + "</option>";

                            console.log(optNum + "=" + resultCount);
                            console.log(resultCount);

                            if (parseInt(optNum) == parseInt(resultCount)) {
                                resultHtml += "</select>";
                            }
                            optNum++;
                        }
                    }
                    //console.log(resultHtml);
                    //console.log("End here");
                    return resultHtml;
                },
                error: function (err) {
                    //alert(err.responseText);
                    console.log(err.responseText);
                },
                complete: function (data) {
                    return resultHtml;
                }
            });
            //return "<textarea rows='3' class='form - control' id='answer' style='width: 100 % !important'></textarea>";
            //return "<select class='form-control select2 selectyesno' id='answer' style='width:100% !important' ><option value = '0'>= Select One =</option><option value='209'>OFF</option><option value='209'>ON</option><option value='209'>DEAD</option></select>";
            //console.log("ini HTMLnya " + resultHtml);
            return resultHtml;
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

                        $("#tbquestion").find("input,button,textarea,select").attr("disabled", false);
                        $("ctl00_ContentPlaceHolder1_ddlCampaignRes").prop('disabled', false);
                        $('#ctl00_ContentPlaceHolder1_txtNote').prop('disabled', false);
                    }
                    if (result.call == 0 || result.call == "") {
                        $('#toggle-contact').prop('disabled', true);
                        $('#toggle-close').prop('disabled', true);
                        $("#ctl00_ContentPlaceHolder1_ddlUnconnect").prop('disabled', true);
                        $("#ctl00_ContentPlaceHolder1_txtFlwUp").prop('disabled', true);
                        $("#ctl00_ContentPlaceHolder1_ddlUncontact").prop('disabled', true);
                        $("#ctl00_ContentPlaceHolder1_ddlTelephone").prop('disabled', true);
                        $("ctl00_ContentPlaceHolder1_ddlCampaignRes").prop('disabled', true);
                        $('#ctl00_ContentPlaceHolder1_txtNote').prop('disabled', true);

                        $("#tbquestion").find("input,button,textarea,select").attr("disabled", true);
                    }
                    if (result.connect == 1) {
                        $('#toggle-connect').bootstrapToggle('on');
                        $('#toggle-contact').prop('disabled', false);
                        $('#toggle-close').prop('disabled', false);

                        $("#tbquestion").find("input,button,textarea,select").attr("disabled", false);
                        $("ctl00_ContentPlaceHolder1_ddlCampaignRes").prop('disabled', false);
                        //$('#ctl00_ContentPlaceHolder1_txtNote').prop('disabled', false);
                    }
                    if (result.connect == 0 || result.connect == "") {
                        $('#toggle-contact').bootstrapToggle('off');
                        $('#toggle-contact').prop('disabled', true);
                        $('#toggle-close').bootstrapToggle('off');
                        $('#toggle-close').prop('disabled', true);

                        $("#tbquestion").find("input,button,textarea,select").attr("disabled", true);
                        $("ctl00_ContentPlaceHolder1_ddlCampaignRes").prop('disabled', true);
                        //$('#ctl00_ContentPlaceHolder1_txtNote').prop('disabled', true);
                        //$("#tbquestion").find("input,button,textarea,select").attr("disabled", false);
                    }
                    if (result.contact == 1) {
                        $('#toggle-contact').bootstrapToggle('on');

                        $('#toggle-close').prop('disabled', false);
                        $("#tbquestion").find("input,button,textarea,select").attr("disabled", false);
                    }
                    if (result.contact == 0 || result.contact == "") {
                        $("#ctl00_ContentPlaceHolder1_ddlUncontact").prop('disabled', false);

                        $('#toggle-close').bootstrapToggle('off');
                        $('#toggle-close').prop('disabled', true);
                        $("#tbquestion").find("input,button,textarea,select").attr("disabled", true);
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
            $("#phoneid").data("id", data.AGRMNT_NO);
            generatetable(campaign, data.AGRMNT_NO);
            generatecallinfo(data.AGRMNT_NO, campaign);
            $('#agrmnt').val(data.AGRMNT_NO);
            $('#campaignid').val(campaign);
            $('#insertmodaltitle').html("<b>Call Information</b> <small id='smlagrmn'>" + data.AGRMNT_NO + " - " + data.CUST_NAME + "</small>");
            $('#lblagrmnt').html(data.AGRMNT_NO);
            $("#insertmodal").attr("data-backdrop", "static");
            $('#insertmodal').modal('show');
            $(".selectmodal").select2({
                minimumResultsForSearch: Infinity
            });
        }
        function showhistory() {
            var data = table.row('.selected').data();
            var campaign = $('#ctl00_ContentPlaceHolder1_ddlCampaign').val();
            generatehist(campaign, data.AGRMNT_NO);
            $('#callhistory').html("<b>Call History</b> <small>" + data.AGRMNT_NO + "</small>");
            $("#history").attr("data-backdrop", "static");
            $('#history').modal('show');
        }
        function closeRefresh() {
            window.location.reload();
        }

        function showphonelist() {
            generatetablephone($("#phoneid").data("id"));
            $("#phone").attr("data-backdrop", "static");
            $('#phone').modal('show');
        }

        function objectLength(obj) {
            var result = 0;
            for (var prop in obj) {
                if (obj.hasOwnProperty(prop)) {
                    result++;
                }
            }
            return result;
        }

        function isNumber(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }
    </script>
</asp:Content>
