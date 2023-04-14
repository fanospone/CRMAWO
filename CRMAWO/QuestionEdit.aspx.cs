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
    public partial class QuestionEdit : System.Web.UI.Page
    {
        DataTable dtAll;
        string QuestionID;
        protected void Page_Load(object sender, EventArgs e)
        {
            string Id = Request.QueryString["Id"];
            QuestionID = Request.QueryString["Id"];
            if (!IsPostBack)
            {
                if (Id != null)
                {
                    GetQuestion(Id);
                }
            }
        }
        public void GetQuestion(string id)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("spGET_QUESTION", con))
                {
                    dtAll = new DataTable();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@WHERESTAT", " AND QUESTION_ID = " + id);
                    con.Open();
                    dtAll.Clear();
                    dtAll.Load(cmd.ExecuteReader());

                    if (dtAll.Rows[0]["TYPE"].ToString() == "OPTION")
                    {
                        divOption.Visible = true;
                        divQuestion.Visible = true;
                        txtCampaign.Text = dtAll.Rows[0]["CAMPAIGN_NAME"].ToString();
                        txtBrand.Text = dtAll.Rows[0]["BRAND"].ToString();
                        txtNo.Text = dtAll.Rows[0]["QUESTION_NO"].ToString();
                        txtQuestion.Text = dtAll.Rows[0]["QUESTION"].ToString();

                        using (SqlCommand cmdddl = new SqlCommand("spGET_QUESTION_OPTION", con))
                        {
                            cmdddl.CommandType = CommandType.StoredProcedure;
                            cmdddl.Parameters.AddWithValue("@QuestionNo", dtAll.Rows[0]["QUESTION_NO"].ToString() );

                            using (SqlDataReader dr = cmdddl.ExecuteReader())
                            {
                                if (dr.HasRows)
                                {
                                    ddQuestion.DataSource = dr;
                                    ddQuestion.DataTextField = "QUESTIONLIST";
                                    ddQuestion.DataValueField = "ID";
                                    ddQuestion.DataBind();
                                    ddQuestion.Items.Insert(0, new ListItem("-Select-", "0"));
                                }
                            }
                        }
                    }
                    else
                    {
                        divOption.Visible = false;
                        divQuestion.Visible = true;
                        txtCampaign.Text = dtAll.Rows[0]["CAMPAIGN_NAME"].ToString();
                        txtBrand.Text = dtAll.Rows[0]["BRAND"].ToString();
                        txtNo.Text = dtAll.Rows[0]["QUESTION_NO"].ToString();
                        txtQuestion.Text = dtAll.Rows[0]["QUESTION"].ToString();
                    }

                    con.Close();
                }
            }
        }
        public void Edit(string id)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("spEDIT_QUESTION", con))
                {
                    GenericPrincipal principal = (GenericPrincipal)HttpContext.Current.User;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@QUESTION_ID", Int32.Parse(id));
                    cmd.Parameters.AddWithValue("@QUESTION", txtQuestion.Text);
                    cmd.Parameters.AddWithValue("@USR", principal.Identity.Name);

                    con.Open();
                    cmd.ExecuteReader();
                    con.Close();
                }
            }
        }
        protected void Cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Question.aspx");
        }
        protected void Save_Click(object sender, EventArgs e)
        {
            string Id = Request.QueryString["Id"];
            Edit(Id);
            Response.Redirect("Question.aspx");
        }
        [System.Web.Services.WebMethod]
        public static string SubmitOptionQuestion(string fields, string table, string questno, string questionid)
        {
            string msg = "";
            string QuestionInt = questno;

            try
            {
                int iCnt = 0;
                string sColumns = "";

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("spDELETE_QUESTION_OPTION", con))
                    {
                        GenericPrincipal principal = (GenericPrincipal)HttpContext.Current.User;
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@QuestionNo", Int32.Parse(questno));

                        con.Open();
                        cmd.ExecuteReader();
                        con.Close();
                    }
                }


                for (iCnt = 0; iCnt <= fields.Split(',').Length - 1; iCnt++)
                {
                    if (string.IsNullOrEmpty(sColumns))
                    {
                        sColumns = fields.Split(',')[iCnt];
                    }
                    else
                    {
                        sColumns = fields.Split(',')[iCnt];
                    }

                    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
                    {
                        using (SqlCommand cmd = new SqlCommand("spADD_QUESTION_OPTION", con))
                        {
                            GenericPrincipal principal = (GenericPrincipal)HttpContext.Current.User;
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@QuestionNo", Int32.Parse(questno));
                            cmd.Parameters.AddWithValue("@Option", sColumns);
                            cmd.Parameters.AddWithValue("@Questionid", Int32.Parse(questionid));

                            con.Open();
                            cmd.ExecuteReader();
                            con.Close();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                msg = "There was an error : " + ex.Message;
            }
            return msg;
        }
    }
}