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
    public partial class Customer : System.Web.UI.Page
    {
        DataTable dtAll;
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!IsPostBack)
            {
                GetCampaign();
                GetData(-1, Int32.Parse(ddlIsClose.SelectedItem.Value));
            }
        }
        protected void myListDropDown_Change(object sender, EventArgs e)
        {
            GetData(Int32.Parse(ddlCampaign.SelectedItem.Value), Int32.Parse(ddlIsClose.SelectedItem.Value));
        }
        public void GetData(int id, int close)
        {
            GenericPrincipal principal = (GenericPrincipal)HttpContext.Current.User;
            string user = "%%";
            if (principal.IsInRole("AWO") || principal.IsInRole("VERIFICATOR"))
            {
                user = principal.Identity.Name;
            }
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("spGET_CUSTOMER", con))
                {
                    dtAll = new DataTable();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandTimeout = 5000;
                    cmd.Parameters.AddWithValue("@CAMPAIGN_ID", id);
                    cmd.Parameters.AddWithValue("@CLOSE", close);
                    cmd.Parameters.AddWithValue("@CAMPAIGN_RES", ddlCampaignResult.SelectedItem.Value);
                    cmd.Parameters.AddWithValue("@USR", user);
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