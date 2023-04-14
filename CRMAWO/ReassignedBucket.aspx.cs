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
    public partial class ReassignedBucket : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Reassigned_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("spGEN_UpdateBucketkeTGAwal", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandTimeout = 2000;
                    cmd.Parameters.AddWithValue("@START", txtStart.Text);
                    cmd.Parameters.AddWithValue("@END", txtEnd.Text);
                    con.Open();
                    cmd.ExecuteReader();
                }
                con.Close();
            }
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "dialog", "dialog('Success!','Data Success Reassigned','success','ReassignedBucket.aspx');", true);
        }
    }
}