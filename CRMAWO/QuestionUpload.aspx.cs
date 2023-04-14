using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Principal;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CRMAWO
{
    public partial class QuestionUpload : System.Web.UI.Page
    {
        DataTable dtAll;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetCampaign();
            }
        }
        public void GetCampaign()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("spGET_CAMPAIGN", con))
                {
                    dtAll = new DataTable();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@WHERESTAT", "");
                    con.Open();
                    dtAll.Clear();
                    dtAll.Load(cmd.ExecuteReader());

                    Dictionary<string, string> member = new Dictionary<string, string>();
                    int i = 0;
                    for (i = 0; i < dtAll.Rows.Count; i++)
                    {
                        member.Add(dtAll.Rows[i]["CAMPAIGN_ID"].ToString(), dtAll.Rows[i]["CAMPAIGN_NAME"].ToString() + " - " + dtAll.Rows[i]["BRAND"].ToString());
                    }

                    ddlCampaign.DataTextField = "Value";
                    ddlCampaign.DataValueField = "Key";
                    ddlCampaign.DataSource = member;
                    ddlCampaign.DataBind();
                }
                con.Close();
            }
        }
        public void InsertExcel(List<string> value)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("spINSERT_QUESTION", con))
                {
                    GenericPrincipal principal = (GenericPrincipal)HttpContext.Current.User;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@CAMPAIGN_ID", ddlCampaign.SelectedItem.Value);
                    cmd.Parameters.AddWithValue("@QUESTION_NO", value[0]);
                    cmd.Parameters.AddWithValue("@QUESTION", value[1]);
                    cmd.Parameters.AddWithValue("@TYPE", value[2]);
                    cmd.Parameters.AddWithValue("@USR", principal.Identity.Name);

                    con.Open();
                    cmd.ExecuteReader();
                    con.Close();
                }
            }
        }
        protected void ExportSample_Click(object sender, EventArgs e)
        {
            DataTable table = new DataTable();

            // Declare DataColumn and DataRow variables.
            DataColumn column;
            DataRow row;

            // Create new DataColumn, set DataType, ColumnName and add to DataTable.    
            column = new DataColumn();
            column.DataType = System.Type.GetType("System.Int32");
            column.ColumnName = "No";
            table.Columns.Add(column);

            // Create second column.
            column = new DataColumn();
            column.DataType = Type.GetType("System.String");
            column.ColumnName = "Pertanyaan";
            table.Columns.Add(column);

            column = new DataColumn();
            column.DataType = Type.GetType("System.String");
            column.ColumnName = "Tipe";
            table.Columns.Add(column);

            row = table.NewRow();
            row["No"] = 1;
            row["Pertanyaan"] = "Siapa nama Anda?";
            row["Tipe"] = "TEXT";
            table.Rows.Add(row);

            row = table.NewRow();
            row["No"] = 2;
            row["Pertanyaan"] = "Berapa umur Anda?";
            row["Tipe"] = "TEXT";
            table.Rows.Add(row);

            row = table.NewRow();
            row["No"] = 3;
            row["Pertanyaan"] = "Apakah Anda puas dengan pelayanan kami?";
            row["Tipe"] = "OPTION";
            table.Rows.Add(row);
            
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=Template.xls");
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            var package = new ExcelPackage();
            var sheet = package.Workbook.Worksheets.Add("Sheet 1");
            
            sheet.Cells["A1"].LoadFromDataTable(table, true);
            Response.BinaryWrite(package.GetAsByteArray());
            Response.End();
        }
        protected void Cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Question.aspx");
        }
        protected void Save_Click(object sender, EventArgs e)
        {
            bool hasHeader = true;
            if (this.FileUpload1.HasFile)
            {
                try
                {
                    string mes="";
                    string ext = System.IO.Path.GetExtension(FileUpload1.PostedFile.FileName);
                    if (ext.Equals(".xlsx") || ext.Equals(".XLSX"))
                    {
                        string path = Server.MapPath("File\\");
                        path = path + "Question_"+ddlCampaign.SelectedItem.Text+"_" + DateTime.Now.ToString("ddMMyy_HHmmss") + Path.GetExtension(FileUpload1.PostedFile.FileName);
                        this.FileUpload1.SaveAs(path);
                        //path += this.FileUpload1.PostedFile.FileName ;
                        using (var pck = new OfficeOpenXml.ExcelPackage())
                        {
                            using (var stream = File.OpenRead(path))
                            {
                                pck.Load(stream);
                            }
                            var ws = pck.Workbook.Worksheets.First();
                            var startRow = hasHeader ? 2 : 1;
                            List<string> value = new List<string>();
                            DateTime monthnow = DateTime.Now;
                            for (int rowNum = startRow; rowNum <= ws.Dimension.End.Row; rowNum++)
                            {
                                var wsRow = ws.Cells[rowNum, 1, rowNum, ws.Dimension.End.Column];
                                //DataRow row = tbl.Rows.Add();
                                for (int i = 1; i <= ws.Dimension.End.Column; i++)
                                {
                                    value.Add(ws.Cells[rowNum, i].Text);
                                }
                                if (CheckQuestion(Int32.Parse(ddlCampaign.SelectedItem.Value), Int32.Parse(value[0])))
                                {
                                    if (mes.Equals("")) mes = "No. ";
                                    mes += value[0] + " ";
                                }
                                else
                                {
                                    InsertExcel(value);
                                }
                                value.Clear();
                            }
                            if (!mes.Equals(""))
                            {
                                mes += "already exists.";
                            }
                            else
                            {
                                Response.Redirect("Question.aspx");
                            }
                        }
                        lblMessage.Text = "Upload successful. " + mes;
                    }
                    else
                    {
                        lblMessage.Text = "File extension not supported";
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = ex.Message.ToString();
                }
            }
            else
            {
                lblMessage.Text = "No file chosen";
            }
        }
        public bool CheckQuestion(int campaign, int no)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("spGET_QUESTION", con))
                {
                    dtAll = new DataTable();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@WHERESTAT", " and a.[CAMPAIGN_ID] = " + campaign + " AND [QUESTION_NO]=" + no);
                    con.Open();
                    dtAll.Clear();
                    dtAll.Load(cmd.ExecuteReader());
                }
                con.Close();
            }
            if (dtAll.Rows.Count > 0)
            {
                return true;
            }
            return false;
        }
    }
}