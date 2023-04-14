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
    public partial class CampaignUpdate : System.Web.UI.Page
    {
        DataTable dtAll;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetBrand();
                GetCampaign();
                GetPaket();
                GetCampaignX();
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
                        member.Add(dtAll.Rows[i]["CAMPAIGN_ID"].ToString() +"#"+ dtAll.Rows[i]["VERSION"].ToString(), dtAll.Rows[i]["CAMPAIGN_NAME"].ToString() + " - v" + dtAll.Rows[i]["VERSION"].ToString());
                    }

                    ddlCampaign.DataTextField = "Value";
                    ddlCampaign.DataValueField = "Key";
                    ddlCampaign.DataSource = member;
                    ddlCampaign.DataBind();
                }
                con.Close();
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
                    ddlPaket.SelectedIndex = 0;

                }
                con.Close();
            }
        }
        public void GetCampaignX()
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
        public void GetBrand()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("spGET_BRAND", con))
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
                        member.Add(dtAll.Rows[i]["BRAND_ID"].ToString(), dtAll.Rows[i]["BRAND"].ToString());
                    }

                    ddlBrand.DataTextField = "Value";
                    ddlBrand.DataValueField = "Key";
                    ddlBrand.DataSource = member;
                    ddlBrand.DataBind();
                    ddlBrand.SelectedIndex = 0;

                }
                con.Close();
            }
        }
        public void InsertCampaign()
        {
            GenericPrincipal principal = (GenericPrincipal)HttpContext.Current.User;
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("spINSERT_CAMPAIGN", con))
                {

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@CAMPAIGN", txtCampaign.Text);
                    cmd.Parameters.AddWithValue("@VERSION", txtVersion.Text);
                    cmd.Parameters.AddWithValue("@OLD_CAMPAIGN", Int32.Parse(ddlCampaign.SelectedItem.Value.Split('#')[0]));
                    cmd.Parameters.AddWithValue("@IS_NEGATIVE", isnegative.Value);
                    cmd.Parameters.AddWithValue("@START", txtStart.Text);
                    cmd.Parameters.AddWithValue("@BRAND", ddlBrand.SelectedItem.Value);
                    cmd.Parameters.AddWithValue("@TYPE", ddlType.SelectedItem.Value);
                    cmd.Parameters.AddWithValue("@VALUE", txtValue.Text);
                    cmd.Parameters.AddWithValue("@STATUS", 1);
                    cmd.Parameters.AddWithValue("@USR", principal.Identity.Name);
                    con.Open();
                    cmd.ExecuteReader();
                    con.Close();
                }
                string[] paket = hdnPaket.Value.Split(',');
                for (int i = 0; i < paket.Length - 1; i++)
                {
                    using (SqlCommand cmd = new SqlCommand("spINSERT_PAKET", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@PAKET", paket[i]);
                        cmd.Parameters.AddWithValue("@USR", principal.Identity.Name);
                        con.Open();
                        cmd.ExecuteReader();
                        con.Close();
                    }
                }
                paket = hdnCampaignX.Value.Split(',');
                for (int i = 0; i < paket.Length - 1; i++)
                {
                    using (SqlCommand cmd = new SqlCommand("spINSERT_CAMPAIGN_CONST", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@CAMPAIGN_IDX", Int32.Parse(paket[i]));
                        con.Open();
                        cmd.ExecuteReader();
                        con.Close();
                    }
                }
            }
        }
        protected void myListDropDown_Change(object sender, EventArgs e)
        {
            string versi = ddlCampaign.SelectedItem.Value.Split('#')[1];
            int a = Int32.Parse(versi.Split('.')[0]);
            int b = Int32.Parse(versi.Split('.')[1]);

            if (b == 9)
            {
                a++;
                b = 0;
            }
            else
            {
                b++;
            }
            txtVersion.Text = a.ToString() + "." + b.ToString();
            txtCampaign.Text = ddlCampaign.SelectedItem.Text.Split('-')[0];
        }
        protected void Cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Campaign.aspx");
        }
        protected void Save_Click(object sender, EventArgs e)
        {
            InsertCampaign();
            Response.Redirect("Campaign.aspx");
        }
    }
}