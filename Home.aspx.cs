using CIS4396_Template.Classes;
using System;
using System.Configuration;
using System.IO;
using System.Web;
using System.Web.Configuration;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIS4396_Template
{
    public partial class Home : Page
    {
        /*Declaring page-wide global connection object for convenience*/
        Connection conn;

        protected void Page_Load(object sender, EventArgs e)
        {
            /*Check if the user is Authenticated before loading the page*/
            /*Makes it faster and more secured by preventing running further code*/
            if (isAuthenticated() == false)
            {
                Session["Authenticated"] = false;
                Response.Redirect("default.aspx");
            }
            else if (isAuthenticated() == true)
            {
                if (!IsPostBack)
                {
                    /*Executed only on the first Page_Load*/
                    Retreive_Session_Object();
                    Test_Connections();
                    CreateDownloadButton();
                }
                else if (IsPostBack)
                {
                    /*Executed on the second Page_Load and onward*/
                    Retreive_Session_Object();
                    Test_Connections();
                    CreateDownloadButton();
                }
            }

            /*
             * Dynamically created controls must be executed 
             * outside of any Page_Load handlers because 
             */
            Get_College_List(); //<------------ RECREATED
            /* the method above will be re-created at every PostBack event.
             * Remember, they do not exist in HTML, the server creates them DYNAMICALLY.
             */
        }

        protected void CreateDownloadButton()
        {
            LinkButton linkButton = new LinkButton();

            linkButton.ID = "btnDownlaod";
            linkButton.Text = "Download";
            linkButton.CssClass = "btn btn-primary";
            linkButton.Click += new EventHandler(Download_Click);
            ControlPanel.Controls.Add(linkButton);
        }

        /// <summary>
        /// This click event will shows how to download a saved file. The file content
        /// of the document just says "Test PDF".
        /// </summary>
        public void Download_Click(Object sender, EventArgs e)
        {
            String text = "~/File/Test PDF.pdf";

            if (text != string.Empty)
            {
                string filePath = text;

                Response.Clear();
                Response.Buffer = true;
                Response.Charset = "";
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.ContentType = "application/pdf";
                Response.AppendHeader("Content-Disposition", "attachment; filename = TestPDF.pdf");
                Response.TransmitFile(Server.MapPath(filePath));
                Response.Flush();
                Response.End();
            }
        }

        protected Boolean isAuthenticated()
        {
            Boolean isAllowed = false;

            if (Session["Authenticated"] == null)
            {
                isAllowed = false;
            }
            else if (Session["Authenticated"] != null)
            {
                bool isAuthenticated = bool.Parse(Session["Authenticated"].ToString());

                if (!isAuthenticated)
                {
                    isAllowed = false;
                }
                else if (isAuthenticated)
                {
                    isAllowed = true;
                }
            }

            return isAllowed;
        }
        protected void Retreive_Session_Object()
        {
            //LDAP Information
            lbl_First_Name.Text = (Session["First_Name"] != null) ? Session["First_Name"].ToString() : "N/A";
            lbl_Last_Name.Text = (Session["Last_Name"] != null) ? Session["Last_Name"].ToString() : "N/A";
            lbl_Email.Text = (Session["Email"] != null) ? Session["Email"].ToString() : "N/A";
            lbl_TUID.Text = (Session["TU_ID"] != null) ? Session["TU_ID"].ToString() : "N/A";
            lbl_Affiliation_Primary.Text = (Session["Affiliation_Primary"] != null) ? Session["Affiliation_Primary"].ToString() : "N/A";
            lbl_Affiliation_Secondary.Text = (Session["Affiliation_Secondary"] != null) ? Session["Affiliation_Secondary"].ToString() : "N/A";
            StringWriter writer = new StringWriter();

            txt_Request_Headers.Text = (Session["HTTP_Request_Headers"] != null) ? Session["HTTP_Request_Headers"].ToString() : "N/A";


            /*Some values may return null so we need to handle the NullExceptionPointer case*/
            /*a. Title*/
            if (Session["Title"] != null)
            {
                lbl_Title.Text = Session["Title"].ToString();
            }
            else
            {
                lbl_Title.Text = "N/A";
            }

            /*b. School*/
            if (Session["School"] != null)
            {
                lbl_School.Text = Session["School"].ToString();
            }
            else
            {
                lbl_School.Text = "N/A";
            }

            /*c. First Major*/
            if (Session["Major_1"] != null)
            {
                lbl_Major_1.Text = Session["Major_1"].ToString();
            }
            else
            {
                lbl_Major_1.Text = "N/A";
            }

            /*d. Second Major*/
            if (Session["Major_2"] != null)
            {
                lbl_Major_2.Text = Session["Major_2"].ToString();
            }
            else
            {
                lbl_Major_2.Text = "N/A";
            }


            //Single Sign-On Attributes
            if (Session["SSO_Attribute_affiliation"] != null)
            {
                lbl_SSO_Affiliation.Text = Session["SSO_Attribute_affiliation"].ToString();
            }
            else
                lbl_SSO_Affiliation.Text = "N/A";

            if (Session["SSO_Attribute_eduPersonPrincipalName"] != null)
            {
                lbl_SSO_EduPersonPrincipalName.Text = Session["SSO_Attribute_eduPersonPrincipalName"].ToString();
            }
            else
                lbl_SSO_EduPersonPrincipalName.Text = "N/A";

            if (Session["SSO_Attribute_employeeNumber"] != null)
            {
                lbl_SSO_EmployeeNumber.Text = Session["SSO_Attribute_employeeNumber"].ToString();
            }
            else
                lbl_SSO_EmployeeNumber.Text = "N/A";

            if (Session["SSO_Attribute_mail"] != null)
            {
                lbl_SSO_Mail.Text = Session["SSO_Attribute_mail"].ToString();
            }
            else
                lbl_SSO_Mail.Text = "N/A";

            if (Session["SSO_Attribute_remote_user"] != null)
            {
                lbl_SSO_Remote_User.Text = Session["SSO_Attribute_remote_user"].ToString();
            }
            else
                lbl_SSO_Remote_User.Text = "N/A";
        }


        protected void Test_Connections()
        {
            //Database status
            try
            {
                conn = new Connection();
                bool connStatus = conn.Open();

                if (connStatus == true)
                {
                    spanDBCircleCheck.Attributes["class"] = "glyphicon glyphicon-ok-sign";
                }
                else
                    spanDBCircleError.Attributes["class"] = "glyphicon glyphicon-remove-sign";

            }
            catch (Exception)
            {
                spanDBCircleError.Attributes["class"] = "glyphicon glyphicon-remove-sign";
            }

            //WebService Status
            try
            {
                if (Session["Full_Name"] != null)
                {
                    spanWSCircleCheck.Attributes["class"] = "glyphicon glyphicon-ok-sign";
                }
                else
                    spanWSCircleError.Attributes["class"] = "glyphicon glyphicon-remove-sign";
            }
            catch (Exception)
            {
                spanWSCircleError.Attributes["class"] = "glyphicon glyphicon-remove-sign";
            }
        }

        protected void Get_College_List()
        {
            try
            {
                /*1 - Retrieving all colleges*/
                WebService.College[] list = WebService.Webservice.getAllColleges();


                if (list != null)
                {
                    //Make sure error label is not visible
                    lblPanel_College_list_Error.Visible = false;

                    /*2 - Looping through the College object array*/
                    int Unique_ID = 0;
                    foreach (WebService.College college in list)
                    {
                        String name = college.collegeName;
                        String code = college.collegeCode;

                        /*Dynamically creating a Label control*/
                        Label lbl_College = new Label();
                        lbl_College.ID = "lbl_College_" + Unique_ID.ToString();
                        lbl_College.Text = name + " (" + code + ")";
                        lbl_College.CssClass = "control-label";
                        lbl_College.EnableViewState = true;

                        /*Adding the new Label to the Panel*/
                        Panel_College_List.Controls.Add(new LiteralControl("<p align=\"center\">"));
                        Panel_College_List.Controls.Add(new LiteralControl("<b class=\"text-primary\">"));
                        Panel_College_List.Controls.Add(lbl_College);
                        Panel_College_List.Controls.Add(new LiteralControl("</b>"));
                        Panel_College_List.Controls.Add(new LiteralControl("</p>"));

                        /*Increasing the Unique_ID count to prevent non-Unique control error(s)*/
                        Unique_ID++;
                    }
                }
                else
                    lblPanel_College_list_Error.Visible = true;
            }
            catch
            {
                lblPanel_College_list_Error.Visible = true;
            }
        }

        [WebMethod]
        public static string SetDemoModeStatus(string toggle)
        {
            try
            {
                if (bool.TryParse(toggle, out bool newValue))
                {
                    Configuration config = WebConfigurationManager.OpenWebConfiguration("~");

                    if (config != null)
                    {
                        config.AppSettings.Settings["demo_mode"].Value = newValue.ToString();
                        config.Save(ConfigurationSaveMode.Modified);

                        return "Status saved.";
                    }
                    else
                    {
                        return "Config could not be opened.";
                    }
                }

                return "Parameter could not be converted to boolean.";
            }
            catch (Exception ex)
            {
                return ex.ToString();
            }
        }

        [WebMethod]
        public static string GetDemoModeStatus()
        {
            try
            {
                return (!string.IsNullOrWhiteSpace(ConfigurationManager.AppSettings["demo_mode"].ToString())) ? ConfigurationManager.AppSettings["demo_mode"].ToString().ToLower() : "N/A";
            }
            catch (Exception ex)
            {
                return ex.ToString();
            }
        }

        protected void lbtn_Email_Click(object sender, EventArgs e)
        {
            Email email = new Email();

            email.SendMail("tue82272@temple.edu", "no-reply@temple.edu", "This is a test", "Test");
        }
    }
}