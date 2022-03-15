<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Master_Page.Master" CodeBehind="Home.aspx.cs" Inherits="CIS4396_Template.Home" %>

<asp:Content ID="Content_1" runat="server" ContentPlaceHolderID="Master_Title">
    Home
</asp:Content>

<asp:Content ID="Content_2" runat="server" ContentPlaceHolderID="Master_Custom_Scripts">
    <!--Insert your Custom Scripts here-->

    <script type="text/javascript" src="../Scripts/bootstrap-toggle.min.js"></script>

    <script type="text/javascript">

        $(document).ready(function () {
            var result = AJAX_Demo_Mode("Home.aspx/GetDemoModeStatus");

            if (result.toLowerCase() === 'true') {
                $('#demo_mode').bootstrapToggle('on');
            }
            else if (result.toLowerCase() === 'false') {
                $('#demo_mode').bootstrapToggle('off');
            }
            else {
                alert(result);
            }
        });

        //show list of College/Schools
        function ShowDictionary() {
            $(document).ready(function () {
                $('#Modal_CollegeSchool').modal('show');
            });
        }

        //show LDAP Modal
        function ShowLDAP() {
            $(document).ready(function () {
                $('#Modal_LDAP').modal('show');
            });
        }

        //show Student modal
        function ShowStudent() {
            $(document).ready(function () {
                $('#Modal_Student').modal('show');
            });
        }

        //show Shibboleth attributes
        function ShowAttributes() {
            $(document).ready(function () {
                $('#Modal_Attributes').modal('show');
            });
        }

        $(function () {
            $('#demo_mode').change(function () {
                var toggle = $(this).prop('checked');

                AJAX_Demo_Mode("Home.aspx/SetDemoModeStatus", toggle);
            });
        });


        function AJAX_Demo_Mode(url, param) {

            var input = "";

            if (param === true) {
                input = "true";
            }
            else if (param === false) {
                input = "false";
            }

            var json;
            $.ajax({
                type: "POST",
                url: url,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: '{toggle: "' + input + '"}',
                async: false,
                success: function (response) {
                    json = response.d;
                },
                failure: function (response) {
                    json = response.d;
                },
                error: function (error) {
                    json = error;
                }
            });
            return json;
        }


        //add your JS here
        //add your JS here
        //add your JS here
        //add your JS here
        //add your JS here
    </script>
    <style type="text/css">
        .navbar-brand {
            margin: 10px 0;
        }

        ul > li {
            margin: 10px 0;
            font-weight: bold;
        }

            ul > li > ul > li {
                margin: 0px 0;
                font-weight: 100;
            }

        /*add your CSS here*/
        /*add your CSS here*/
        /*add your CSS here*/
        /*add your CSS here*/
        /*add your CSS here*/
    </style>
    <link href="../Content/demo_mode.css" rel="stylesheet" />
    <link href="../Content/bootstrap-toggle.min.css" rel="stylesheet" />

</asp:Content>

<asp:Content ID="Content_3" runat="server" ContentPlaceHolderID="Master_Main_Content">
    <asp:ScriptManager runat="server" ID="ScriptManager1" EnableCdn="true"></asp:ScriptManager>
    <div>
        <div class="container-fluid">
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                    <h1><b>Web Services</b></h1>
                    <asp:LinkButton ID="lbtn_College_List" runat="server" CssClass="btn btn-primary" Text="College and Programs" OnClientClick="ShowDictionary(); return false;" />
                    <asp:LinkButton ID="lbtn_LDAP" runat="server" CssClass="btn btn-primary" Text="LDAP Information" OnClientClick="ShowLDAP(); return false;" />
                    <asp:LinkButton ID="lbtn_Student" runat="server" CssClass="btn btn-primary" Text="Student Information" OnClientClick="ShowStudent(); return false;" />
                    <%--<asp:LinkButton ID="lbtn_Email" runat="server" CssClass="btn btn-primary" Text="Email" OnClick="lbtn_Email_Click"></asp:LinkButton>--%>
                    <ul>
                        <li>Web Service URLS (SOAP)
                            <ul>
                                <li>Program And Degrees
                                    <ul>
                                        <li><a href="https://preprod-wsw.temple.edu/programsanddegrees/ProgramsAndDegrees.asmx" target="_blank">https://preprod-wsw.temple.edu/programsanddegrees/ProgramsAndDegrees.asmx</a></li>
                                    </ul>
                                </li>
                                <li>LDAP Search
                                    <ul>
                                        <li><a href="https://preprod-wsw.temple.edu/ws_ldapsearch/ldap_search.asmx" target="_blank">https://preprod-wsw.temple.edu/ws_ldapsearch/ldap_search.asmx?op=Search</a></li>
                                    </ul>
                                </li>
                                <li>Student
                                    <ul>
                                        <li><a href="https://preprod-wsw.temple.edu/programsanddegrees/ProgramsAndDegrees.asmx" target="_blank">https://preprod-wsw.temple.edu/ws_student/ws_student.asmx</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                    </ul>
                    <h1><b>Shibboleth</b></h1>
                    <asp:LinkButton ID="lbtn_SSO_Attributes" runat="server" CssClass="btn btn-primary" Text="Attributes" OnClientClick="ShowAttributes(); return false;" />
                    <br />
                    <br />
                    <h1><b>Included in this Template</b></h1>
                    <ul style="list-style-type: square">
                        <li>'Content Security Policy' restrictions
                            <ul>
                                <li>Restrict the system to receive data ONLY from the following URLS:
                                    <ul>
                                        <li>https://ajax.googleapis.com</li>
                                        <li>https://maxcdn.bootstrapcdn.com</li>
                                        <li>https://np-stem.temple.edu</li>
                                        <li>https://pre-stem.temple.edu</li>
                                    </ul>
                                </li>
                                <li>If you need to change this policy, go to Web.config on line #66</li>
                            </ul>
                        </li>
                        <li>Temple logo for all browser tabs using the Master Page
                            <ul>
                                <li>You may change the logo by replacing the "favicon.ico" under: Template > Resources</li>
                                <li>The file type must be ".ico" and must be named "favicon.ico" to work correctly </li>
                            </ul>
                        </li>
                        <li>Default page with redirect to Login page
                            <ul>
                                <li>This page is required to enable your application to redirect to the Login page, if not setup manually</li>
                            </ul>
                        </li>
                        <li>Bootstrap CDNs with integrity checks
                            <ul>
                                <li>An integrity check ensures the CSS or JS rules have not been modified before requesting the files</li>
                                <li>This prevents hackers from implementing malicious code into the CSS or JS files, it will refuse the file if not 100% authenticated</li>
                            </ul>
                        </li>
                        <li>Secured Web.config file
                        <ul>
                            <li>Required SSL requests</li>
                            <li>2GB Upload Limit</li>
                            <li>Content Security Policy
                                <ul>
                                    <li>SRI from third-parties are handled</li>
                                    <li>Unsupported browsers not supported (not tested)</li>
                                </ul>
                            </li>
                            <li>Enforced HTTPS, Invalid otherwise
                                <ul>
                                    <li>If there is no HTTPS/SSL, the page does not submit or receive information</li>
                                </ul>
                            </li>
                            <li>No cached data allowed
                                <ul>
                                    <li>This prevents any data from being stored in the client's storage devices</li>
                                </ul>
                            </li>
                            <li>Rewrite "HTTP" URLs to "HTTPS"
                                <ul>
                                    <li>In case the client deletes the "S" in the URL</li>
                                    <li>Works on localhost, not tested online</li>

                                </ul>
                            </li>
                            <li>Session Time Out increased to 60 minutes</li>
                            <li>Form Time Out increased to 60 minutes</li>
                            <li>Custom Errors disabled
                                <ul>
                                    <li>Some types of errors are not shown by default, disabling this shows the details of the errors for easier debugging</li>
                                </ul>
                            </li>
                            <li>Targets ASP.NET 4.5, supports 4.0+</li>
                        </ul>
                        </li>
                        <li>Example: URL Redirect Exploit
                            <ul>
                                <li>If somebody enters the URL "Home.aspx" without logging-in first, they should not be able to view this page</li>
                            </ul>
                        </li>
                        <li>Session Hijack Exploits
                            <ul>
                                <li>The Session Object is marked as secured in your Master Page</li>
                                <li>Not required, however, it adds another layer of security</li>
                            </ul>
                        </li>
                        <li>Responsive Navigation Bar
                            <ul>
                                <li>The navigation bar will resize itself and correctly display a "mobile" menu with dropdowns</li>
                            </ul>
                        </li>
                        <li>Master Page with Bootstrap CDNs
                            <ul>
                                <li>This is only for convenience - You can always host and manually reference Bootstrap elements</li>
                            </ul>
                        </li>
                        <li>Web Services referenced in the "Web References" folder
                            <ul>
                                <li>LDAP Search - University-wide search (Student, Staff, Faculty)</li>
                                <li>Student Search - Basic student records search (All colleges)</li>
                                <li>Programs & Degrees - School related information</li>
                            </ul>
                        </li>
                        <li>Essential C# classes included in the "Classes" folder
                            <ul>
                                <li>Connection class - Database interaction</li>
                                <li>Email class - Sending emails (added customizable HTML emails)</li>
                                <li>Validation class - Centralized validation methods</li>
                                <li>Web Services - Temple object manipulation</li>
                            </ul>
                        </li>            
                        <li>Screen ratio 1:1 for smaller screens (Mobile support) in the Master Page
                            <ul>
                                <li>Your website will be "zoomed-in" on mobile screens (using all the white spaces)</li>
                            </ul>
                        </li>
                        <li>Temple capstone GitHub repository
                            <ul>
                                <li><a href="https://github.com/TempleDev">TempleDev</a></li>
                            </ul>
                        </li>
                        <li>Cross-Site Request Forgery
                            <ul>
                                <li>It may be possible to steal or manipulate customer session cookies, which might be used to impersonate a legitimate user, allowing the hacker to view or alter user records, and to perform transactions as that user</li>
                                <li>Please take a look at the code in Master_Page.Master.cs on how to implement this into your project</li>
                            </ul>
                        </li>
                    </ul>
                    <h1><b>Not in this Template</b></h1>
                    <ul style="list-style-type: square">
                        <li>Active User Check
                            <ul>
                                <li>You must ensure that your users are 'kicked-out' when not active anymore</li>
                                <li>The best way to achieve this is by implementing the security code at the Master Page</li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                    <div class="well">
                        <h1><b>Connection Status</b></h1>
                        <div class="row" style="margin-left: .5em;">
                            <div class="form-group">
                                <asp:Label ID="lb_Database_Status" runat="server" Text="Database:" Font-Size="13pt" />
                                <span runat="server" id="spanDBCircleCheck" class="glyphicon glyphicon-ok-sign hidden" style="font-size: 20px; color: green;"></span>
                                <span runat="server" id="spanDBCircleError" class="glyphicon glyphicon-remove-sign hidden" style="font-size: 20px; color: red;"></span>
                            </div>
                        </div>
                        <div class="row" style="margin-left: .5em;">
                            <div class="form-group">
                                <asp:Label ID="lbl_WebService_Status" runat="server" Text="Web Service:" Font-Size="13pt" />
                                <span runat="server" id="spanWSCircleCheck" class="glyphicon glyphicon-ok-sign hidden" style="font-size: 20px; color: green;"></span>
                                <span runat="server" id="spanWSCircleError" class="glyphicon glyphicon-remove-sign hidden" style="font-size: 20px; color: red;"></span>
                            </div>
                        </div>
                        <h1><b>Single Sign-On</b></h1>
                        <div class="row">
                            <ul style="list-style-type: square">
                                <li>Shibboleth
                                    <ul>
                                        <li>Two components Service Provider (SP) which requests attributes and the Identity Provider (IdP) which authenticates and broadcasts attributes</li>
                                        <li>Open source</li>
                                        <li>Session Summary <a href="https://np-stem.temple.edu/Shibboleth.sso/Session" target="_blank">https://np-stem.temple.edu/Shibboleth.sso/Session</a></li>
                                    </ul>
                                </li>
                                <li>Security Assertion Markup Language (SAML)
                                    <ul>
                                        <li>XML-based Open Standard</li>
                                        <li>Exchange authentication and authorization data between SP and IdP.
                                            <ul>
                                                <li>Identity Provider (a producer of assertions)</li>
                                                <li>Service Provider (a consumer of assertions)</li>
                                            </ul>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                        <h1><b>Data Classification</b></h1>
                        <div class="row">
                            <ul style="list-style-type: square">
                                <li><a href="https://its.temple.edu/data-classification-grid" target="_blank">Data Classification Grid</a></li>
                            </ul>
                        </div>
                        <h1><b>System Access Role Definitions</b></h1>
                        <div class="row">
                            <ul style="list-style-type: square">
                                <li><a href="https://its.temple.edu/temple-university-system-access-roles-definition" target="_blank">Role Definitions</a></li>
                            </ul>
                        </div>
                        <div>
                            <h1><b>Download</b></h1>
                            <asp:Panel runat="server" ID="ControlPanel">
                            </asp:Panel>
                        </div>
                        <%-- <h1><b>Demo Mode</b></h1>
                        <div class="row">
                            <label class="checkbox-inline">
                                <input type="checkbox" id="demo_mode" checked data-toggle="toggle" />
                            </label>
                        </div>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content_4" runat="server" ContentPlaceHolderID="Master_Secondary_Content">
    <!--Insert Modals, hidden fields, or extra content here-->

    <!--Example College/Schools-->
    <div id="Modal_CollegeSchool" class="modal fade in" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="text-center text-danger">List of Colleges and codes</h1>
                </div>
                <div class="modal-body">
                    <!--"Panel_College_List" is the Dynamic Panel in which the server adds controls programatically-->
                    <asp:Panel ID="Panel_College_List" runat="server" />
                    <div class="text-center">
                        <asp:Label runat="server" ID="lblPanel_College_list_Error" Text="Error: Web Service could not retrieve list of colleges and codes." Font-Size="12pt"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--Example LDAP-->
    <div id="Modal_LDAP" class="modal fade in" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="text-center text-danger">LDAP Information</h1>
                </div>
                <div class="modal-body">
                    <b class="text-danger">Name</b>:&nbsp<asp:Label ID="lbl_First_Name" runat="server" />&nbsp<asp:Label ID="lbl_Last_Name" runat="server" />
                    <br />
                    <b class="text-danger">Email</b>:&nbsp<asp:Label ID="lbl_Email" runat="server" />
                    <br />
                    <b class="text-danger">TUID</b>:&nbsp<asp:Label ID="lbl_TUID" runat="server" />
                    <br />
                    <b class="text-danger">Title</b>:&nbsp<asp:Label ID="lbl_Title" runat="server" />
                    <br />
                    <b class="text-danger">Primary</b>:&nbsp<asp:Label ID="lbl_Affiliation_Primary" runat="server" />
                    <br />
                    <b class="text-danger">Secondary</b>:&nbsp<asp:Label ID="lbl_Affiliation_Secondary" runat="server" />
                    <br />
                    <br />
                </div>
            </div>
        </div>
    </div>

    <!--Example Student-->
    <div id="Modal_Student" class="modal fade in" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="text-center text-danger">Student Information</h1>
                </div>
                <div class="modal-body">
                    <b class="text-danger">School</b>:&nbsp<asp:Label ID="lbl_School" runat="server" />
                    <br />
                    <b class="text-danger">Major #1</b>:&nbsp<asp:Label ID="lbl_Major_1" runat="server" />
                    <br />
                    <b class="text-danger">Major #2</b>:&nbsp<asp:Label ID="lbl_Major_2" runat="server" />
                </div>
            </div>
        </div>
    </div>

    <!--Example Shibboleth Attribute-->
    <div id="Modal_Attributes" class="modal fade in" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="text-center text-danger">Single Sign-On Attributes</h1>
                </div>
                <div class="modal-body" style="word-wrap: break-word">
                    <b class="text-danger">Affiliation</b>:&nbsp<asp:Label ID="lbl_SSO_Affiliation" runat="server" />
                    <br />
                    <b class="text-danger">EduPersonPrincipalName</b>:&nbsp<asp:Label ID="lbl_SSO_EduPersonPrincipalName" runat="server" />
                    <br />
                    <b class="text-danger">Employee Number</b>:&nbsp<asp:Label ID="lbl_SSO_EmployeeNumber" runat="server" />
                    <br />
                    <b class="text-danger">Mail</b>:&nbsp<asp:Label ID="lbl_SSO_Mail" runat="server" />
                    <br />
                    <b class="text-danger">Remote User</b>:&nbsp<asp:Label ID="lbl_SSO_Remote_User" runat="server" />
                    <br />
                    <br />
                    <br />

                    <h2>HTTP Request Headers</h2>
                    <div class="row">
                        <div class="col-lg-12">
                            <asp:TextBox runat="server" ID="txt_Request_Headers" BackColor="White" BorderColor="White" Rows="25" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
