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
    public partial class User : System.Web.UI.Page
    {
        DataTable dtAll;
        protected void Page_Load(object sender, EventArgs e)
        {
            GetData();
        }
        public void GetData()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("spGET_USER", con))
                {
                    dtAll = new DataTable();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@WHERESTAT", "");
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
            Response.Redirect("UserCreate.aspx?Id=" + yourValue);
        }
        protected void Create_Click(object sender, EventArgs e)
        {
            Response.Redirect("UserCreate.aspx");
        }
    }
}