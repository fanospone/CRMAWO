using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CRMAWO
{
    public partial class CustomerExport : System.Web.UI.Page
    {
        DataTable dtAll;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetCampaign();
            }
        }
        protected void Export_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
            {
                DataTable dtAll;
                using (SqlCommand cmd = new SqlCommand("spEXPORT_CUSTOMER", con))
                {
                    dtAll = new DataTable();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandTimeout = 2000;
                    cmd.Parameters.AddWithValue("@CAMPAIGN_ID", Int32.Parse(ddlCampaign.SelectedItem.Value));
                    cmd.Parameters.AddWithValue("@START", txtStart.Text);
                    cmd.Parameters.AddWithValue("@END", txtEnd.Text);
                    cmd.Parameters.AddWithValue("@TYPE",ddlType.SelectedValue);
                    con.Open();
                    dtAll.Clear();
                    dtAll.Load(cmd.ExecuteReader());
                }
                con.Close();
                Response.Clear();
                Response.AddHeader("content-disposition", "attachment;filename="+ddlCampaign.SelectedItem.Text+".xls");
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                var package = new ExcelPackage();
                var sheet = package.Workbook.Worksheets.Add("Sheet 1");
                sheet.Cells["A1"].LoadFromDataTable(dtAll, true);
                Response.BinaryWrite(package.GetAsByteArray());
                Response.End();
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
    }
}