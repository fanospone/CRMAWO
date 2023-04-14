using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace CRMAWO
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {

        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {
            if (HttpContext.Current.User != null)
            {
                if (HttpContext.Current.User.Identity.IsAuthenticated)
                {
                    if (HttpContext.Current.User.Identity is FormsIdentity)
                    {
                        FormsIdentity id = (FormsIdentity)HttpContext.Current.User.Identity;
                        FormsAuthenticationTicket ticket = id.Ticket;
                        string userData = ticket.UserData;
                        string[] roles = userData.Split(',');
                        HttpContext.Current.User = new GenericPrincipal(new GenericIdentity(id.Name,"Forms"), roles);
                    }
                }
            }
        }
        protected void Application_Error(object sender, EventArgs e)
        {
            string cookieName = FormsAuthentication.FormsCookieName;
            HttpCookie authCookie = Context.Request.Cookies[cookieName];

            if (null == authCookie)
            {
                //There is no authentication cookie.
                return;
            }
            FormsAuthenticationTicket authTicket = null;
            try
            {
                authTicket = FormsAuthentication.Decrypt(authCookie.Value);
            }
            catch (Exception ex)
            {
                //Write the exception to the Event Log.
                return;
            }
            if (null == authTicket)
            {
                //Cookie failed to decrypt.
                return;
            }
            //When the ticket was created, the UserData property was assigned a
            //pipe-delimited string of group names.
            string[] groups = authTicket.UserData.Split(new char[] { '|' });
            //Create an Identity.
            GenericIdentity id = new GenericIdentity(authTicket.Name, "LdapAuthentication");
            //This principal flows throughout the request.
            GenericPrincipal principal = new GenericPrincipal(id, groups);
            Context.User = principal;
        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}