using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CRMAWO
{
    public partial class CampaignEdit : System.Web.UI.Page
    {
        DataTable dtAll;
        protected void Page_Load(object sender, EventArgs e)
        {
            string Id = Request.QueryString["Id"];
            if (!IsPostBack)
            {
                if (Id != null)
                {
                    GetPaket();
                    GetCampignX();
                    GetCampaign(Id);
                }
            }
        }
        public void GetCampaign(string id)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("spGET_CAMPAIGN_DETAIL", con))
                {
                    dtAll = new DataTable();
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@CAMPAIGN_ID", Int32.Parse(id));
                    con.Open();
                    dtAll.Clear();
                    dtAll.Load(cmd.ExecuteReader());

                    txtCampaign.Text = dtAll.Rows[0]["CAMPAIGN_NAME"].ToString();
                    txtBrand.Text = dtAll.Rows[0]["BRAND"].ToString();
                    txtStart.Text = dtAll.Rows[0]["START"].ToString();
                    txtType.Text = dtAll.Rows[0]["TYPE"].ToString();
                    txtValue.Text = dtAll.Rows[0]["TYPE_VALUE"].ToString();
                    txtVersion.Text = dtAll.Rows[0]["VERSION"].ToString();
                    string[] tech = dtAll.Rows[0]["PAKET"].ToString().Split(',');

                    foreach (ListItem item in ddlPaket.Items)
                        item.Selected = tech.Contains(item.Value);
                    ddlPaket.Enabled = false;

                    tech = dtAll.Rows[0]["CAMPAIGNX"].ToString().Split(',');
                    foreach (ListItem item in ddlCampaignX.Items)
                        item.Selected = tech.Contains(item.Value);
                    ddlCampaignX.Enabled = false;

                    con.Close();
                }
            }
        }
        public void GetPaket()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("spGET_PAKET", con))
                {
                    dtAll = new DataTable();
                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    dtAll.Clear();
                    dtAll.Load(cmd.ExecuteReader());

                    Dictionary<string, string> member = new Dictionary<string, string>();
                    int i = 0;
                    for (i = 0; i < dtAll.Rows.Count; i++)
                    {
                        member.Add(dtAll.Rows[i]["PROD_OFFERING_CODE"].ToString(), dtAll.Rows[i]["PROD_OFFERING_NAME"].ToString());
                    }

                    ddlPaket.DataTextField = "Value";
                    ddlPaket.DataValueField = "Key";
                    ddlPaket.DataSource = member;
                    ddlPaket.DataBind();
                }
                con.Close();
            }
        }
        public void GetCampignX()
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
                        member.Add(dtAll.Rows[i]["CAMPAIGN_ID"].ToString(), dtAll.Rows[i]["CAMPAIGN_NAME"].ToString());
                    }

                    ddlCampaignX.DataTextField = "Value";
                    ddlCampaignX.DataValueField = "Key";
                    ddlCampaignX.DataSource = member;
                    ddlCampaignX.DataBind();
                }
                con.Close();
            }
        }
        public void Edit(string id)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("spEDIT_CAMPAIGN", con))
                {
                    GenericPrincipal principal = (GenericPrincipal)HttpContext.Current.User;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@CAMPAIGN_ID", Int32.Parse(id)); 
                    cmd.Parameters.AddWithValue("@STATUS", ddlStatus.SelectedItem.Value); 
                    cmd.Parameters.AddWithValue("@USR", principal.Identity.Name);
                    con.Open();
                    cmd.ExecuteReader();
                    con.Close();
                }
                con.Close();
            }
        }
        protected void Cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Campaign.aspx");
        }
        protected void Save_Click(object sender, EventArgs e)
        {
            string Id = Request.QueryString["Id"];
            Edit(Id);
            Response.Redirect("Campaign.aspx");
        }
    }
}