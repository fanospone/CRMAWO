<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="QuestionEdit.aspx.cs" Inherits="CRMAWO.QuestionEdit" %>

<asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <section class="content-header">
        <h1>CRM AWO
        <small>Edit Question</small>
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
                                    <label for="txtNo" class="col-sm-2 control-label" style="text-align: left;">No</label>
                                    <div class="col-sm-5">
                                        <asp:TextBox ID="txtNo" runat="server" class="form-control textNo" ReadOnly></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12" id="divQuestion" runat="server">
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label for="txtQuestion" class="col-sm-2 control-label" style="text-align: left;">Question</label>
                                    <div class="col-sm-5">
                                        <asp:TextBox ID="txtQuestion" runat="server" class="form-control" TextMode="MultiLine" Rows="5"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12" id="divOption" runat="server">
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label for="ddQuestion" class="col-sm-2 control-label" style="text-align: left;">Question Option</label>
                                    <div class="col-sm-5">
                                        <%--<asp:ListBox ID="ddQuestion" runat="server" CssClass="form-control select2" Style="width: 100%;" AutoPostBack="true"></asp:ListBox>--%>
                                        <asp:DropDownList runat="server" ID="ddQuestion" CssClass="form-control select2" ></asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group" style="margin-bottom: 5px">
                                    <%--<input type="text" id="tbTableName" placeholder="Enter Table Name" />--%>
                                    <div class="col-sm-5">
                                        <input type="button" id="btAdd" value="Add Answer" class="bt" />
                                    </div>
                                </div>
                            </div>

                            <%--THE CONTAINER TO HOLD THE DYNAMICALLY CREATED ELEMENTS.--%>
                            <div id="main"></div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <div class="col-sm-1">
                                        <asp:LinkButton ID="btnCancel" runat="server" ToolTip="Cancel" Style="float: left" class="btn btn-default" OnClick="Cancel_Click"><i class="fa fa-close"></i> Cancel</asp:LinkButton>
                                    </div>
                                    <div class="col-sm-1">
                                        <asp:LinkButton ID="btnSave" runat="server" ToolTip="Save" Style="float: left" class="btn btn-success" OnClick="Save_Click"><i class="fa fa-save"></i> Save</asp:LinkButton>
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
    <script>
        $(document).ready(function () {
            BindControls();
        });

        function BindControls() {

            var itxtCnt = 0;    // COUNTER TO SET ELEMENT IDs.

            // CREATE A DIV DYNAMICALLY TO SERVE A CONTAINER TO THE ELEMENTS.
            var container = $(document.createElement('div')).css({
                width: '100%',
                clear: 'both',
                'margin-top': '10px',
                'margin-bottom': '10px'
            });

            // CREATE THE ELEMENTS.
            $('#btAdd').click(function () {
                itxtCnt = itxtCnt + 1;

                $(container).append('<input type="text" placeholder="What Answer?" class="input" id=tb' + itxtCnt + ' value="" />');

                if (itxtCnt == 1) {
                    var divSubmit = $(document.createElement('div'));
                    $(divSubmit).append('<input type="button" id="btSubmit" value="Submit" class="bt" onclick="getTextValue()" />');
                }

                // ADD EVERY ELEMENT TO THE MAIN CONTAINER.
                $('#main').after(container, divSubmit);
            });
        }
        var values = new Array();
        function getTextValue() {
            //var paramid = url.searchParams.get("id");
            $('.input').each(function () {
                if (this.value != '')
                    values.push(this.value);
            });

            if (values != '') {
                const queryString = window.location.search;

                const urlParams = new URLSearchParams(queryString);

                const Id = urlParams.get('Id')
                // NOW CALL THE WEB METHOD WITH THE PARAMETERS USING AJAX.
                $.ajax({
                    type: 'POST',
                    url: 'QuestionEdit.aspx/SubmitOptionQuestion',
                    data: "{'fields':'" + values + "', 'table': '" + $('#tbTableName').val() + "', 'questno': '" + $('.textNo').val() + "', 'questionid': '" + Id +"'}",
                    dataType: 'json',
                    headers: { "Content-Type": "application/json" },
                    success: function (response) {
                        location.reload();
                        //values = [];    // EMPTY THE ARRAY.
                        //alert(response.d);
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert(errorThrown);
                    }
                });
            }
            else { alert("Fields cannot be empty.") }
        }
    </script>
</asp:Content>
