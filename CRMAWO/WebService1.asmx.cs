using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Principal;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;

namespace CRMAWO
{
    /// <summary>
    /// Summary description for WebService1
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class WebService1 : System.Web.Services.WebService
    {
        static Int32 count;
        [WebMethod]
        [ScriptMethod(XmlSerializeString = false, ResponseFormat = ResponseFormat.Json)]
        public void InsertCallInfo(string callinfo, string data)
        {
            JavaScriptSerializer js = new JavaScriptSerializer();
            CallInfo call = js.Deserialize<CallInfo>(callinfo);

             js = new JavaScriptSerializer();
            List<Answer> answers = js.Deserialize<List<Answer>>(data);
            

            string res = "{\"Result\":\"Success\",\"Message\":\"Call information has been saved.\"}";
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("spINSERT_CALL_INFO", con))
                    {
                        GenericPrincipal principal = (GenericPrincipal)HttpContext.Current.User;
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@AGRMNT_NO", call.agrmnt);
                        cmd.Parameters.AddWithValue("@CAMPAIGN_ID", Int32.Parse(call.campaignid));
                        cmd.Parameters.AddWithValue("@CALL", Int32.Parse(call.call));
                        cmd.Parameters.AddWithValue("@START_CALL", call.start);
                        cmd.Parameters.AddWithValue("@END_CALL", call.end);
                        cmd.Parameters.AddWithValue("@CONNECTED", Int32.Parse(call.connect));
                        cmd.Parameters.AddWithValue("@REASON_CONN", call.reasonconn);
                        cmd.Parameters.AddWithValue("@CONTACTED", Int32.Parse(call.contact));
                        cmd.Parameters.AddWithValue("@REASON_CONT", call.reasoncont);
                        cmd.Parameters.AddWithValue("@TELP_TYPE", call.telptype);
                        cmd.Parameters.AddWithValue("@IS_CLOSE", Int32.Parse(call.close));
                        cmd.Parameters.AddWithValue("@CAMPAIGN_RES", call.campaignres);
                        cmd.Parameters.AddWithValue("@NOTE", call.note);
                        cmd.Parameters.AddWithValue("@FOLLOW_UP", call.followup);
                        cmd.Parameters.AddWithValue("@USR", principal.Identity.Name);
                        con.Open();
                        cmd.ExecuteReader();
                        con.Close();
                    }
                }
                int i;
                for(i=0; i < answers.Count; i++)
                {
                    if(answers[i].answer == null)
                    {
                        answers[i].answer = "";
                    }
                    if(!answers[i].answer.Equals(""))
                    InsertDataAnswer(answers[i].questionid, answers[i].agrmnt, answers[i].campaignid, answers[i].answer);
                }
            }
            catch (Exception e)
            {
                res = "{\"Result\":\"Failed\",\"Message\":\"" + Regex.Replace(e.Message, @"\t|\n|\r", "") + "\"}";
            }
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(res);
        }

        [WebMethod]
        [ScriptMethod(XmlSerializeString = false, ResponseFormat = ResponseFormat.Json)]
        public void GetQuestion(string campaign, string agrmnt)
        {
            string sResult = "";

            try
            {
                int nDraw = Convert.ToInt32(HttpContext.Current.Request.Params["draw"]);

                DataTable dt = new DataTable();
                dt = GetData(campaign, agrmnt);
                //DataTable dtM = (DataTable)rows;
                ReturnData oResult = new ReturnData();
                oResult.draw = nDraw;
                oResult.recordsTotal = dt.Rows.Count;
                oResult.recordsFiltered = dt.Rows.Count;

                foreach (DataRow row in dt.Rows)
                {
                    oResult.data.Add("["
                        + "\"" + row["QUESTION_ID"].ToString() + "\"" + ","
                        + "\"" + row["QUESTION_NO"].ToString() + "\"" + ","
                        + "\"" + row["QUESTION"].ToString() + "\"" + ","
                        + "\"" + row["ANSWER"].ToString() + "\"" + ","
                        + "\"" + row["TYPE"].ToString() + "\""
                        + "]");
                }
                sResult = oResult.ToString();
            }
            catch (Exception err)
            {
                string sMsg = err.Message;
                sResult = "";
            }
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(sResult);
        }
        [WebMethod]
        //[ScriptMethod(XmlSerializeString = false, ResponseFormat = ResponseFormat.Json)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public List<QuestionEnt> GetQuestionOption(string questionno)
        {
            var questList = new List<QuestionEnt>();
            //QuestionEnt qent = new QuestionEnt();
            string sResult = "";
            try
            {
                int nDraw = Convert.ToInt32(HttpContext.Current.Request.Params["draw"]);

                DataTable dt = new DataTable();
                dt = GetDataQuestionOption(questionno);

                //DataTable dtM = (DataTable)rows;
                ReturnData oResult = new ReturnData();
                oResult.draw = nDraw;
                oResult.recordsTotal = dt.Rows.Count;
                oResult.recordsFiltered = dt.Rows.Count;
                foreach (DataRow row in dt.Rows)
                {
                    questList.Add(new QuestionEnt
                    {
                        ID = Convert.ToInt32(row["ID"].ToString()),
                        QUESTIONLIST = row["QUESTIONLIST"].ToString()
                    });
                    //oResult.data.Add("["
                    //    + "\"" + row["ID"].ToString() + "\"" + ","
                    //    + "\"" + row["QUESTIONLIST"].ToString() + "\""
                    //    + "]");
                }
                //sResult = oResult.ToString();

            }
            catch (Exception err)
            {
                string sMsg = err.Message;
                sResult = "";
            }
            //Context.Response.Clear();
            //Context.Response.ContentType = "application/json";
            //Context.Response.Write(sResult);
            return questList;
        }

        [WebMethod]
        [ScriptMethod(XmlSerializeString = false, ResponseFormat = ResponseFormat.Json)]
        public void GetCustPhone(string agrmntno)
        {
            string sResult = "";

            try
            {
                int nDraw = Convert.ToInt32(HttpContext.Current.Request.Params["draw"]);

                DataTable dt = new DataTable();
                dt = GetDataPhone(agrmntno);
                //DataTable dtM = (DataTable)rows;
                ReturnData oResult = new ReturnData();
                oResult.draw = nDraw;
                oResult.recordsTotal = dt.Rows.Count;
                oResult.recordsFiltered = dt.Rows.Count;

                if (dt.Rows.Count > 0)
                {
                    //foreach (DataRow row in dt.Rows)
                    //{
                    oResult.data.Add("["
                        + "\"Mobile Phone 1\"" + ","
                        + "\"" + dt.Rows[0]["MOBILE1"].ToString() + "\""
                        + "]");
                    oResult.data.Add("["
                            + "\"Mobile Phone 2\"" + ","
                            + "\"" + dt.Rows[0]["MOBILE2"].ToString() + "\""
                            + "]");
                    oResult.data.Add("["
                            + "\"Mobile Phone 3\"" + ","
                            + "\"" + dt.Rows[0]["MOBILE3"].ToString() + "\""
                            + "]");
                    oResult.data.Add("["
                            + "\"Spouse Mobile Phone 1\"" + ","
                            + "\"" + dt.Rows[0]["SPOUSE1"].ToString() + "\""
                            + "]");
                    oResult.data.Add("["
                            + "\"Spouse Mobile Phone 2\"" + ","
                            + "\"" + dt.Rows[0]["SPOUSE2"].ToString() + "\""
                            + "]");
                    oResult.data.Add("["
                            + "\"Spouse Mobile Phone 3\"" + ","
                            + "\"" + dt.Rows[0]["SPOUSE3"].ToString() + "\""
                            + "]");
                    //}
                }
                sResult = oResult.ToString();
            }
            catch (Exception err)
            {
                string sMsg = err.Message;
                sResult = "";
            }
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(sResult);
        }
        [WebMethod]
        [ScriptMethod(XmlSerializeString = false, ResponseFormat = ResponseFormat.Json)]
        public void GetHistoryCall(string campaign, string agrmnt)
        {
            string sResult = "";

            try
            {
                int nDraw = Convert.ToInt32(HttpContext.Current.Request.Params["draw"]);

                DataTable dt = new DataTable();
                dt = GetDataHist(campaign, agrmnt);
                //DataTable dtM = (DataTable)rows;
                ReturnData oResult = new ReturnData();
                oResult.draw = nDraw;
                oResult.recordsTotal = dt.Rows.Count;
                oResult.recordsFiltered = dt.Rows.Count;

                foreach (DataRow row in dt.Rows)
                {
                    oResult.data.Add("["
                        + "\"" + row["CALL"].ToString() + "\"" + ","
                        + "\"" + row["START_CALL"].ToString() + "\"" + ","
                        + "\"" + row["END_CALL"].ToString() + "\"" + ","
                        + "\"" + row["CONNECTED"].ToString() + "\"" + ","
                        + "\"" + row["REASON_CONN"].ToString() + "\"" + ","
                        + "\"" + row["CONTACTED"].ToString() + "\"" + ","
                        + "\"" + row["REASON_CONT"].ToString() + "\"" + ","
                        + "\"" + row["TELP_TYPE"].ToString() + "\"" + ","
                        + "\"" + row["IS_CLOSE"].ToString() + "\"" + ","
                        + "\"" + row["CAMPAIGN_RES"].ToString() + "\"" + ","
                        + "\"" + row["NOTE"].ToString() + "\"" + ","
                        + "\"" + row["FOLLOW_UP"].ToString() + "\"" + ","
                        + "\"" + row["DTM_CRT"].ToString() + "\""
                        + "]");
                }
                sResult = oResult.ToString();
            }
            catch (Exception err)
            {
                string sMsg = err.Message;
                sResult = "";
            }
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(sResult);
        }
        [WebMethod]
        [ScriptMethod(XmlSerializeString = false, ResponseFormat = ResponseFormat.Json)]
        public void GetCallInfo(string agrmnt, string campaignid)
        {
            string result = "";
            try
            {
                DataTable dt = new DataTable();
                dt = GetDataCall(agrmnt, campaignid);
                foreach (DataRow row in dt.Rows)
                {
                    result = "{"
                        + "\"call\": " + row["CALL"].ToString() + ","
                        + "\"start\": \"" + row["START_CALL"].ToString() + "\"" + ","
                        + "\"end\": \"" + row["END_CALL"].ToString() + "\"" + ","
                        + "\"connect\": " + row["CONNECTED"].ToString() + ","
                        + "\"reasonconn\": \"" + row["REASON_CONN"].ToString() + "\"" + ","
                        + "\"contact\": " + row["CONTACTED"].ToString() + ","
                        + "\"reasoncont\": \"" + row["REASON_CONT"].ToString() + "\"" + ","
                        + "\"telptype\": \"" + row["TELP_TYPE"].ToString() + "\"" + ","
                        + "\"close\": " + row["IS_CLOSE"].ToString() + ","
                        + "\"campaignres\": \"" + row["CAMPAIGN_RES"].ToString() + "\"" + ","
                        + "\"note\": \"" + row["NOTE"].ToString() + "\"" + ","
                        + "\"followup\": \"" + row["FOLLOW_UP"].ToString() + "\""
                        + "}";
                }
            }
            catch (Exception err)
            {
                result = "{"+ err.Message + "}";
            }
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(result);
        }
        public static void InsertDataAnswer(string questionid, string agrmnt, string campaignid, string answer)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("spINSERT_ANSWER", con))
                {
                    GenericPrincipal principal = (GenericPrincipal)HttpContext.Current.User;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@QUESTION_ID", Int32.Parse(questionid));
                    cmd.Parameters.AddWithValue("@AGRMNT_NO", agrmnt);
                    cmd.Parameters.AddWithValue("@CAMPAIGN_ID", Int32.Parse(campaignid));
                    cmd.Parameters.AddWithValue("@ANSWER", answer);
                    cmd.Parameters.AddWithValue("@USR", principal.Identity.Name);
                    con.Open();
                    cmd.ExecuteReader();
                }
                con.Close();
            }
        }
        public static DataTable GetData(string campaign, string agrmnt)
        {
            DataTable dtAll;
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("spGET_QUESTION_ANSWER", con))
                {
                    dtAll = new DataTable();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@CAMPAIGN_ID",  Int32.Parse(campaign));
                    cmd.Parameters.AddWithValue("@AGRMNT_NO", agrmnt);
                    con.Open();
                    dtAll.Clear();
                    dtAll.Load(cmd.ExecuteReader());
                }
                con.Close();
            }
            return dtAll;
        }
        public static DataTable GetDataQuestionOption(string questionno)
        {
            DataTable dtAll;
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("spGET_QUESTION_OPTION", con))
                {
                    dtAll = new DataTable();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@QuestionNo", Int32.Parse(questionno));
                    con.Open();
                    dtAll.Clear();
                    dtAll.Load(cmd.ExecuteReader());
                }
                con.Close();
            }
            return dtAll;
        }
        public static DataTable GetDataHist(string campaign, string agrmnt)
        {
            DataTable dtAll;
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("spGET_CALL_INFO_HIST", con))
                {
                    dtAll = new DataTable();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@CAMPAIGN_ID", Int32.Parse(campaign));
                    cmd.Parameters.AddWithValue("@AGRMNT_NO", agrmnt);
                    con.Open();
                    dtAll.Clear();
                    dtAll.Load(cmd.ExecuteReader());
                }
                con.Close();
            }
            return dtAll;
        }
        public static DataTable GetDataCall(string agrmnt, string campaignid)
        {
            DataTable dtAll;
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("spGET_CALL_INFO", con))
                {
                    dtAll = new DataTable();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@WHERESTAT", "AND AGRMNT_NO = '" + agrmnt + "' AND CAMPAIGN_ID = " + Int32.Parse(campaignid));
                    con.Open();
                    dtAll.Clear();
                    dtAll.Load(cmd.ExecuteReader());
                }
                con.Close();
            }
            return dtAll;
        }
        public static DataTable GetDataPhone(string agrmntno)
        {
            DataTable dtAll;
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("spGET_CUST_PHONE", con))
                {
                    dtAll = new DataTable();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@AGRMNTNO", agrmntno);
                    con.Open();
                    dtAll.Clear();
                    dtAll.Load(cmd.ExecuteReader());
                }
                con.Close();
            }
            return dtAll;
        }
        [WebMethod]
        [ScriptMethod(XmlSerializeString = false, ResponseFormat = ResponseFormat.Json)]
        public void GetDataCustomer(string id, string close, string campaignres)
        {
            string sResult = "";

            try
            {
                int nDraw = Convert.ToInt32(HttpContext.Current.Request.Params["draw"]);
                string search = Convert.ToString(HttpContext.Current.Request.Params["search[value]"]);
                int i = Convert.ToInt32(HttpContext.Current.Request.Params["order[0][column]"]);
                int start = Convert.ToInt32(HttpContext.Current.Request.Params["start"]);
                int length = Convert.ToInt32(HttpContext.Current.Request.Params["length"]);
                string orderColumn = Convert.ToString(HttpContext.Current.Request.Params["columns[" + i + "][name]"]);
                string orderType = Convert.ToString(HttpContext.Current.Request.Params["order[0][dir]"]);

                int page = start / length + 1;
                string orderColumn_ = orderColumn;
                if (orderColumn_.Equals("AGRMNT_NO"))
                {
                    orderColumn_ = "A." + orderColumn_;
                }
                string order = " ORDER by " + orderColumn_ + " " + orderType;

                DataTable dt = new DataTable();
                if (search == "")
                {
                    dt = GetDataCustomerAll(id, close, campaignres, page, length, order);
                }
                else
                    dt = GetDataCustomerSearch(search, page, length, order);

                DataView dv = dt.DefaultView;
                dv.Sort = orderColumn + " " + orderType;
                DataTable dtN = dv.ToTable();

                //DataTable dtM = (DataTable)rows;
                ReturnData oResult = new ReturnData();
                oResult.draw = nDraw;
                oResult.recordsTotal = count;
                oResult.recordsFiltered = count;

                foreach (DataRow row in dtN.Rows)
                {
                    //Askrindo n = new Askrindo() { CUSTOMER_NUMBER = row["CUSTOMER_NUMBER"].ToString(), NOMOR_PENGAJUAN = row["NOMOR_PENGAJUAN"].ToString() };
                    oResult.data.Add("{" + "\"AGRMNT_NO\":\"" + row["AGRMNT_NO"].ToString() + "\"" + ","
                        + "\"PRODUCT\":\"" + row["PRODUCT"].ToString() + "\"" + ","
                        + "\"CUST_NAME\":\"" + row["CUST_NAME"].ToString() + "\"" + ","
                        + "\"BRANCH\":\"" + row["BRANCH"].ToString() + "\"" + ","
                        + "\"USR\":\"" + row["USR"].ToString() + "\"" + ","
                        + "\"GOLIVE_DT\":\"" + row["GOLIVE_DT"].ToString() + "\"" + "}");
                }
                sResult = oResult.ToString();
            }
            catch (Exception err)
            {
                string sMsg = err.Message;
                sResult = "";
            }
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(sResult);
        }
        public static DataTable GetDataCustomerAll(string id, string close, string campaignres, int page, int pagesize, string order) {
            DataTable dt;
            GenericPrincipal principal = (GenericPrincipal)HttpContext.Current.User;
            string user = "%%";
            if (principal.IsInRole("AWO") || principal.IsInRole("VERIFICATOR"))
            {
                user = principal.Identity.Name;
            }

            string parameter = "";
            if (id.Equals(""))
            {
                id = "-99";
            }
            parameter += String.Format("{0}{1}", " AND a.CAMPAIGN_ID = ", id);
            parameter += String.Format("{0}{1}", " AND isnull(b.IS_CLOSE,0) = ", close);
            if (!campaignres.Equals("All"))
            {
                parameter += String.Format("{0}{1}", " AND b.CAMPAIGN_RES = '", campaignres + "'");
            }

            if (!user.Equals(""))
            {
                parameter += String.Format("{0}{1}{2}{3}", " AND a.USR like ", "'", user, "'");
            }
            parameter = parameter.Substring(4,parameter.Length-4);
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SPGET_CUSTOMER_COUNT", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@WHERECOND", parameter);
                    con.Open();
                    count = (Int32)cmd.ExecuteScalar();
                    con.Close();
                }
                using (SqlCommand cmd = new SqlCommand("SPGET_CUSTOMER_NEW", con))
                {
                    dt = new DataTable();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@PAGESIZE", pagesize);
                    cmd.Parameters.AddWithValue("@PAGE", page);
                    cmd.Parameters.AddWithValue("@ORDER", order);
                    cmd.Parameters.AddWithValue("@WHERECOND", parameter);
                    con.Open();
                    dt.Clear();
                    dt.Load(cmd.ExecuteReader());
                    con.Close();
                }
            }
            return dt;
        }
        public static DataTable GetDataCustomerSearch(string search, int page, int pagesize, string order)
        {
            DataTable dt = new DataTable();
            GenericPrincipal principal = (GenericPrincipal)HttpContext.Current.User;
            string user = "%%";
            if (principal.IsInRole("AWO") || principal.IsInRole("VERIFICATOR"))
            {
                user = principal.Identity.Name;
            }

            string parameter = "";

            parameter += String.Format("{0}{1}{2}{3}", " OR A.[AGRMNT_NO] like ", "'%", search, "%'");
            parameter += String.Format("{0}{1}{2}{3}", " OR [PRODUCT] like ", "'%", search, "%'");
            parameter += String.Format("{0}{1}{2}{3}", " OR [CUST_NAME] like ", "'%", search, "%'");
            parameter += String.Format("{0}{1}{2}{3}", " OR [BRANCH] like ", "'%", search, "%'");
            parameter += String.Format("{0}{1}{2}{3}", " OR A.[USR] like ", "'%", search, "%'");
            parameter += String.Format("{0}{1}{2}{3}", " OR A.[GOLIVE_DT] like ", "'%", search, "%'");

            parameter = parameter.Substring(3,parameter.Length-3);
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SPGET_CUSTOMER_COUNT", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@WHERECOND", parameter);
                    con.Open();
                    count = (Int32)cmd.ExecuteScalar();
                    con.Close();
                }
                using (SqlCommand cmd = new SqlCommand("SPGET_CUSTOMER_NEW", con))
                {
                    dt = new DataTable();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@PAGESIZE", pagesize);
                    cmd.Parameters.AddWithValue("@PAGE", page);
                    cmd.Parameters.AddWithValue("@ORDER", order);
                    cmd.Parameters.AddWithValue("@WHERECOND", parameter);
                    con.Open();
                    dt.Clear();
                    dt.Load(cmd.ExecuteReader());
                    con.Close();
                }
            }
            return dt;
        }
    }

    public class QuestionEnt
    {
        public int? QUESTION_ID { get; set; }
        public int? CAMPAIGN_ID { get; set; }
        public string CAMPAIGN_NAME { get; set; }
        public int? QUESTION_NO { get; set; }
        public string QUESTION { get; set; }
        public string DTM_CRT { get; set; }
        public string USR_CRT { get; set; }
        public string agrmnt_no { get; set; }

        public int? ID { get; set; }
        public int? QUESTIONNO { get; set; }
        public string QUESTIONLIST { get; set; }
        public string TYPE { get; set; }
        public int? QUESTIONID { get; set; }
        public string ANSWER { get; set; }
        public List<QuestionDetails> QLIST { get; set; }
    }

    public class QuestionDetails 
    { 
        public string LsQuestionNo { get; set; }
        public string LsQuestionType { get; set; }
        public string LsQuestionAnswer { get; set; }
        public string LsQuestionList { get; set; }
    }

    public class ReturnData
    {
        private int _draw;
        private int _recordsTotal;
        private int _recordsFiltered;
        private List<String> _data = new List<string>();

        public int draw { get { return _draw; } set { _draw = value; } }
        public int recordsTotal { get { return _recordsTotal; } set { _recordsTotal = value; } }
        public int recordsFiltered { get { return _recordsFiltered; } set { _recordsFiltered = value; } }
        public List<String> data { get { return _data; } set { _data = value; } }

        public override string ToString()
        {
            StringBuilder sb = new StringBuilder();

            foreach (string s in _data)
                sb.Append(s + ",");

            string sData = sb.ToString();

            string sData2 = "{ \"draw\": " + this._draw.ToString() + ", \"recordsTotal\": " +
                                this._recordsTotal.ToString() + ", \"recordsFiltered\": " +
                                this._recordsFiltered.ToString() + ", \"data\": [ " + " ] }";

            if (!sData.Equals(""))
            {
                sData = sData.Remove(sData.Count() - 1, 1);       //remove last comma

                sData2 = "{ \"draw\": " + this._draw.ToString() + ", \"recordsTotal\": " +
                                this._recordsTotal.ToString() + ", \"recordsFiltered\": " +
                                this._recordsFiltered.ToString() + ", \"data\": [ " +
                                sData + " ] }";
            }

            return sData2;
        }

    }
    public class CallInfo
    {
        public string agrmnt { get; set; }
        public string campaignid { get; set; }
        public string call { get; set; }
        public string start { get; set; }
        public string end { get; set; }
        public string connect { get; set; }
        public string reasonconn { get; set; }
        public string contact { get; set; }
        public string reasoncont { get; set; }
        public string telptype { get; set; }
        public string close { get; set; }
        public string campaignres { get; set; }
        public string note { get; set; }
        public string followup { get; set; }
    }
    public class Answer
    {
        public string questionid { get; set; }
        public string agrmnt { get; set; }
        public string campaignid { get; set; }
        public string answer { get; set; }
    }
}
