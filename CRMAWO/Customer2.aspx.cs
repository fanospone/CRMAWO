using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CRMAWO
{
    public partial class Customer2 : System.Web.UI.Page
    {
        DataTable dtAll;
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!IsPostBack)
            {
                GetCampaign();
                //GetData(-1, Int32.Parse(ddlIsClose.SelectedItem.Value));
            }
        }
        //protected void myListDropDown_Change(object sender, EventArgs e)
        //{
        //    GetData(Int32.Parse(ddlCampaign.SelectedItem.Value), Int32.Parse(ddlIsClose.SelectedItem.Value));
        //}
        //public void GetData(int id, int close)
        //{
        //    GenericPrincipal principal = (GenericPrincipal)HttpContext.Current.User;
        //    string user = "%%";
        //    if (principal.IsInRole("AWO") || principal.IsInRole("VERIFICATOR"))
        //    {
        //        user = principal.Identity.Name;
        //    }
        //    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
        //    {
        //        using (SqlCommand cmd = new SqlCommand("spGET_CUSTOMER", con))
        //        {
        //            dtAll = new DataTable();
        //            cmd.CommandType = CommandType.StoredProcedure;
        //            cmd.CommandTimeout = 5000;
        //            cmd.Parameters.AddWithValue("@CAMPAIGN_ID", id);
        //            cmd.Parameters.AddWithValue("@CLOSE", close);
        //            cmd.Parameters.AddWithValue("@CAMPAIGN_RES", ddlCampaignResult.SelectedItem.Value);
        //            cmd.Parameters.AddWithValue("@USR", user);
        //            con.Open();
        //            dtAll.Clear();
        //            dtAll.Load(cmd.ExecuteReader());
        //            gvGrid.DataSource = dtAll;
        //            gvGrid.DataBind();
        //            gvGrid.HeaderRow.TableSection = TableRowSection.TableHeader;
        //        }
        //        con.Close();
        //    }
        //}
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

        [WebMethod]
        public static List<QuestionEnt> GetQuestionOption(string questionid, string agmtnno)
        {
            var questList = new List<QuestionEnt>();
            //QuestionEnt qent = new QuestionEnt();
            string sResult = "";
            DataTable dtAll;
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
            {
                var cmd = new SqlCommand("spGETLIST_OPTIONANSWER", con) { CommandType = CommandType.StoredProcedure };
                cmd.CommandTimeout = 0;
                cmd.Parameters.AddWithValue("@QuestionId", Int32.Parse(questionid));
                cmd.Parameters.AddWithValue("@AgrmntNo", agmtnno);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(dr);
                QuestionEnt tx;
                foreach (DataRow dx in dt.Rows)
                {
                    tx = new QuestionEnt();
                    tx.QUESTIONNO = int.Parse(dx["QUESTIONNO"].ToString());
                    tx.TYPE = dx["TYPE"].ToString();
                    tx.QUESTIONID = int.Parse(dx["QUESTIONID"].ToString());
                    tx.ANSWER = dx["ANSWER"].ToString();
                    tx.QUESTIONLIST = dx["QUESTIONLIST"].ToString();

                    //detail
                    //var objEnt = new QuestionEnt();
                    //var listObjEnt = new List<QuestionEnt>();

                    //objEnt.QUESTIONID = tx.QUESTIONID;
                    //listObjEnt.Add(objEnt);


                    //tx.QLIST = listObjEnt;

                    questList.Add(tx);
                }
            }
            return questList;
        }

        [WebMethod]
        public static List<QuestionEnt> GetQuestion(string campaign, string agrmnt)
        {
            var questList = new List<QuestionEnt>();
            DataTable dtAll;

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
            {
                var cmd = new SqlCommand("spGET_QUESTION_ANSWER", con) { CommandType = CommandType.StoredProcedure };
                cmd.CommandTimeout = 0;
                cmd.Parameters.AddWithValue("@CAMPAIGN_ID", Int32.Parse(campaign));
                cmd.Parameters.AddWithValue("@AGRMNT_NO", agrmnt);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(dr);
                QuestionEnt tx;
                dr.Close();
                foreach (DataRow dx in dt.Rows)
                {
                    tx = new QuestionEnt();
                    tx.QUESTION_ID = int.Parse(dx["QUESTION_ID"].ToString());
                    tx.QUESTION_NO = int.Parse(dx["QUESTION_NO"].ToString());
                    tx.QUESTION = dx["QUESTION"].ToString();
                    tx.ANSWER = dx["ANSWER"].ToString();
                    tx.TYPE = dx["TYPE"].ToString();

                    //Details
                    var cmdOption = new SqlCommand("spGet_OPTIONLIST", con) { CommandType = CommandType.StoredProcedure };
                    cmdOption.CommandTimeout = 0;
                    cmdOption.Parameters.AddWithValue("@AgrmntNo", agrmnt);
                    cmdOption.Parameters.AddWithValue("@QuestionID", tx.QUESTION_ID);
                    SqlDataReader drOption = cmdOption.ExecuteReader();
                    DataTable dtOption = new DataTable();
                    dtOption.Load(drOption);

                    var objDetail = new QuestionDetails();
                    var listObjDetail = new List<QuestionDetails>();
                    drOption.Close();

                    foreach (DataRow dxOption in dtOption.Rows)
                    {
                        objDetail = new QuestionDetails();
                        objDetail.LsQuestionNo = dxOption["QUESTION_NO"].ToString();
                        objDetail.LsQuestionType = dxOption["TYPE"].ToString();
                        objDetail.LsQuestionAnswer = dxOption["ANSWER"].ToString();
                        objDetail.LsQuestionList = dxOption["QUESTIONLIST"].ToString();

                        listObjDetail.Add(objDetail);
                    }
                    tx.QLIST = listObjDetail;
                    questList.Add(tx);
                }
            }
            return questList;
        }
    }
}