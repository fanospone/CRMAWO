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
    public partial class Question : System.Web.UI.Page
    {
        DataTable dtAll;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetCampaign();
                GetData(-1);
            }
        }
        protected void myListDropDown_Change(object sender, EventArgs e)
        {
            GetData(Int32.Parse(ddlCampaign.SelectedItem.Value));
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
        public void GetData(int id)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("spGET_QUESTION", con))
                {
                    dtAll = new DataTable();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@WHERESTAT", " and a.[CAMPAIGN_ID] = " + id);
                    con.Open();
                    dtAll.Clear();
                    dtAll.Load(cmd.ExecuteReader());
                    gvGrid.DataSource = dtAll;
                    gvGrid.DataBind();
                    gvGrid.HeaderRow.TableSection = TableRowSection.TableHeader;
                }
                con.Close();
            }
        }
        protected void Edit_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)(sender);
            string yourValue = btn.CommandArgument;
            Response.Redirect("QuestionEdit.aspx?Id=" + yourValue);
        }
        protected void Create_Click(object sender, EventArgs e)
        {
            Response.Redirect("QuestionUpload.aspx");
        }
    }
}