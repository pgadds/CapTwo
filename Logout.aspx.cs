using System;
using System.Web;

namespace CIS4396_Template
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();

            if (HttpContext.Current.Request.IsLocal.Equals(false))
            {
                string domain = Request.Url.Host;
                Response.Redirect("https://" + domain + "/Shibboleth.sso/Logout?return=https://" + GetFimEnvironment(domain) + ".temple.edu/idp/profile/Logout");
            }
        }

        private string GetFimEnvironment(string domain)
        {
            switch (domain)
            {
                case "np-stem.temple.edu":
                case "pre-stem.temple.edu":
                    return "np-fim";
                default:
                    return "fim";                             
            }       
        }

    }
}