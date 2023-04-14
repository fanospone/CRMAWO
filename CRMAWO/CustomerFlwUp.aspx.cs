using OfficeOpenXml;
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
    public partial class CustomerFlwUp : System.Web.UI.Page
    {
        DataTable dtAll;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetData();
            }
        }
        public DataTable GetData()
        {
            GenericPrincipal principal = (GenericPrincipal)HttpContext.Current.User;
            string user = "%%";
            if (principal.IsInRole("AWO"))
            {
                user = principal.Identity.Name;
            }
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("spGET_CUSTOMER_FLWUP", con))
                {
                    dtAll = new DataTable();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandTimeout = 2000;
                    con.Open();
                    dtAll.Clear();
                    dtAll.Load(cmd.ExecuteReader());
                    if(dtAll.Rows.Count == 0)
                    {
                        btnExport.Enabled = false;
                    }
                    else
                    {
                        btnExport.Enabled = true;
                    }
                    gvGrid.DataSource = dtAll;
                    gvGrid.DataBind();
                    gvGrid.HeaderRow.TableSection = TableRowSection.TableHeader;
                }
                con.Close();
            }
            return dtAll;
        }
        protected void Export_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionStringName"].ConnectionString))
                {
                    Response.Clear();
                    Response.AddHeader("content-disposition", "attachment;filename=CustomerFlwUp.xls");
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    var package = new ExcelPackage();
                    var sheet = package.Workbook.Worksheets.Add("Sheet 1");
                    sheet.Cells["A1"].LoadFromDataTable(GetData(), true);
                    byte[] byteExcel = package.GetAsByteArray();
                    Response.BinaryWrite(byteExcel);
                    Response.Flush();
                    Response.Close();
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}