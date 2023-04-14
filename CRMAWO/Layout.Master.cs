using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CRMAWO
{
    public partial class Layout : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public string Clients
        {
            get
            {
                GenericPrincipal principal = (GenericPrincipal)HttpContext.Current.User;

                return principal.Identity.Name;
            }
        }
        public string Menus
        {
            get
            {
                GenericPrincipal principal = (GenericPrincipal)HttpContext.Current.User;
                string menu = "";
                if (principal.IsInRole("TAFS"))
                {
                    menu = "<li class=\"treeview\">" +
                        "<a href = \"#\" >" +
                            "<i class=\"fa fa-bars\"></i><span>Master</span>" +
                            "<span class=\"pull-right-container\">" +
                                "<i class=\"fa fa-angle-left pull-right\"></i>" +
                            "</span>" +
                        "</a>" +
                        "<ul class=\"treeview-menu\">" +
                            "<li><a href=\"User.aspx\" ><i class=\"fa fa-circle-o\"></i>User</a></li>" +
                            "<li><a href=\"Campaign.aspx\" ><i class=\"fa fa-circle-o\"></i>Campaign</a></li>" +
                            "<li><a href=\"Question.aspx\" ><i class=\"fa fa-circle-o\"></i>Question</a></li>" +
                            "<li><a href=\"CustomerFlwUp.aspx\"><i class=\"fa fa-circle-o\"></i><span>Follow Up</span></a></li>" +
                        "</ul>" +
                    "</li>";
                }
                if(principal.IsInRole("AWO") || principal.IsInRole("VERIFICATOR"))
                {
                    menu += "<li><a href=\"Customer2.aspx\"><i class=\"fa fa-bars\"></i><span>Customer</span></a></li>";
                }
                else
                {
                    menu += "<li><a href=\"CustomerSpv.aspx\"><i class=\"fa fa-bars\"></i><span>Customer</span></a></li>";
                }
                if (principal.IsInRole("TAFS") || principal.IsInRole("SPV") || principal.IsInRole("VERIFICATOR"))
                {
                    menu += "<li><a href = \"CustomerExport.aspx\" ><i class=\"fa fa-bars\"></i><span>Export Customer</span></a></li>";
                }
                if (principal.IsInRole("TAFS"))
                {
                    menu += "<li><a href = \"ReassignedBucket.aspx\" ><i class=\"fa fa-bars\"></i><span>Reassigned Bucket</span></a></li>";
                }
                return menu;
            }
        }
    }
}