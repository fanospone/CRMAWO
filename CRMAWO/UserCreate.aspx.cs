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
    public partial class UserCreate : System.Web.UI.Page
    {
        DataTable dtAll;
        protected void Page_Load(object sender, EventArgs e)
        {
            string Id = Request.QueryString["Id"];
            if (!IsPostBack)
            {
                if (Id != null)
                {
                    GetUser(Id);
                }
            }
        }
        public void GetUser(string id)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("spGET_USER", con))
                {
                    dtAll = new DataTable();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@WHERESTAT", "AND USER_ID = '" + id + "'");
                    con.Open();
                    dtAll.Clear();
                    dtAll.Load(cmd.ExecuteReader());
                    txtUsername.Text = dtAll.Rows[0]["USER_ID"].ToString();
                    txtUsername.ReadOnly = true;
                    ddlAccess.SelectedValue = dtAll.Rows[0]["ROLE"].ToString();
                    ddlStatus.SelectedValue = dtAll.Rows[0]["IS_ACTIVE"].ToString();
                }
                con.Close();
            }
        }
        public void InsertUser(int flag)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("spINSERT_USER", con))
                {
                    GenericPrincipal principal = (GenericPrincipal)HttpContext.Current.User;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@USER_ID", txtUsername.Text);
                    cmd.Parameters.AddWithValue("@ROLE", ddlAccess.SelectedItem.Value);
                    cmd.Parameters.AddWithValue("@USR", principal.Identity.Name);
                    cmd.Parameters.AddWithValue("@STATUS", ddlStatus.SelectedItem.Value);
                    cmd.Parameters.AddWithValue("@FLAG", flag);
                    con.Open();
                    cmd.ExecuteReader();
                }
                con.Close();
            }
        }
        protected void Cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("User.aspx");
        }
        protected void Save_Click(object sender, EventArgs e)
        {
            string Id = Request.QueryString["Id"];
            if (Id == null)
            {
                InsertUser(0);
            }
            else
            {
                InsertUser(1);
            }
            Response.Redirect("User.aspx");
        }
    }
}