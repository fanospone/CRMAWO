using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CRMAWO
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.IsAuthenticated && !string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]))
            {
                // This is an unauthorized, authenticated request... 
                Response.Redirect("401.aspx");
            }
            errorLabel.Visible = false;
            txtUsername.MaxLength = 15;
            txtPassword.MaxLength = 30;
        }

        private string AvoidSQLInj(string keys)
        {
            string getkeys;
            getkeys = keys.ToUpper();
            getkeys = getkeys.Replace("'", "");
            getkeys = getkeys.Replace("--", "");
            getkeys = getkeys.Replace("INSERT", "");
            getkeys = getkeys.Replace("UPDATE", "");
            getkeys = getkeys.Replace("DELETE", "");
            getkeys = getkeys.Replace("SELECT", "");
            getkeys = getkeys.Replace("JOIN", "");
            return getkeys;
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string adPath = "LDAP://corp.tafinance.com"; //Path to your LDAP directory server
            GetAdAuthentication getAdAuthentication = new GetAdAuthentication();
            string userId = AvoidSQLInj(txtUsername.Text);
            bool adAuth = getAdAuthentication.IsAuthenticatedPost(ConfigurationManager.AppSettings["AdLink"], userId, txtPassword.Text);
            if (adAuth == true)
            {
                try
                {
                    DataTable dtAll;
                    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
                    {
                        using (SqlCommand cmd = new SqlCommand("spGET_USER", con))
                        {
                            dtAll = new DataTable();
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@WHERESTAT", " and USER_ID = '" + userId + "'");
                            con.Open();
                            dtAll.Clear();
                            dtAll.Load(cmd.ExecuteReader());
                        }
                        con.Close();
                    }
                    //string usr = dtAll.Rows[0]["IS_SUPER_USER"].ToString();
                    if (dtAll.Rows.Count > 0)
                    //if(true)
                    {
                        //string groups = adAuth.GetGroups();

                        //Create the ticket, and add the groups.
                        //bool isCookiePersistent = chkPersist.Checked;
                        FormsAuthenticationTicket authTicket = new FormsAuthenticationTicket(1,
                                  userId, DateTime.Now, DateTime.Now.AddMinutes(600), false, dtAll.Rows[0]["ROLE"].ToString());

                        //Encrypt the ticket.
                        string encryptedTicket = FormsAuthentication.Encrypt(authTicket);

                        //Create a cookie, and then add the encrypted ticket to the cookie as data.
                        HttpCookie authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);

                        authCookie.Expires = authTicket.Expiration;

                        //Add the cookie to the outgoing cookies collection.
                        Response.Cookies.Add(authCookie);
                        //this.Application["user"] = adAuth.GetUser();
                        //this.Application["userid"] = txtUsername.Text;
                        string url = "";
                        if (dtAll.Rows[0]["ROLE"].ToString().Equals("AWO") || dtAll.Rows[0]["ROLE"].ToString().Equals("VERIFICATOR"))
                            url = "Customer2.aspx";
                        else
                            url = "CustomerSpv.aspx";
                        //if (dtAll.Rows[0]["ACCESS"].ToString().Equals("TAFS")) url = "User.aspx";
                        //You can redirect now.
                        if (FormsAuthentication.GetRedirectUrl(userId, false).Contains("default.aspx"))
                            Response.Redirect(url);
                        else
                            Response.Redirect(FormsAuthentication.GetRedirectUrl(userId, false));
                    }
                    else
                    {
                        errorLabel.Text = "User do not Register";
                        errorLabel.Visible = true;
                    }
                }
                catch (Exception ex)
                {
                    errorLabel.Text = "Error authenticating. " + ex.Message;
                    errorLabel.Visible = true;
                }
            }
            else
            {
                errorLabel.Text = "Authentication did not succeed. Check user name and password.";
                errorLabel.Visible = true;
            }
        }
    }
}