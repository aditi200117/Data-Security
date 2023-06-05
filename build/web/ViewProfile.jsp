<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="com.apps.Logcreation.Log"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Vector"%>
<%@page import="com.apps.constants.Constants"%>
<%@page import="com.apps.ResourceBundle.AppBundle"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
    <head profile="http://gmpg.org/xfn/11">
        <title>Data Security Using Enhance AES Algorithm In Cloud Computing</title>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <meta http-equiv="imagetoolbar" content="no" />
        <link rel="stylesheet" href="styles/layout.css" type="text/css" />
        <%@page errorPage="ErrorPage.jsp"%>
        <%@page session="true" %>
    </head>
    <body id="top">
        <div class="wrapper row1">
            <div id="header" class="clear">
                <div class="fl_left">
                    <h1><a href="index.jsp">Data Security Using Enhance AES Algorithm In Cloud Computing</a></h1>
                    <p>Secure Cloud Storage
                        <span style="padding-left: 650px; color: red;"> Welcome : <%=session.getAttribute("x")%></span>
                    </p>
                </div>
                <div class="fl_right">
                    
                </div>
            </div>
        </div>
        <!-- ####################################################################################################### -->
        <div class="wrapper row2">
            <div class="rnd">
                <!-- ###### -->
                <div id="topnav">
                    <ul>
                        <li class="active"><a href="ViewProfile.jsp">View Profile</a></li>                       
                        <li><a href="uploadFiles.jsp">Upload</a></li>
                        <li><a href="viewFiles.jsp">View Files</a></li>
                        <li class="last"><a href="Signout.jsp">Sign Out</a></li>
                    </ul>
                </div>
                <!-- ###### -->
            </div>
        </div>
        <!-- ####################################################################################################### -->
        <div class="wrapper row3">
            <div class="rnd">
                <div id="container" class="clear">
                    <!-- ####################################################################################################### -->
                    <h1>User Profile Details</h1>

                    <%
                        session.getAttribute("UId").toString();
                        Log objLog  = objLog = new Log();
                        Vector<Object> rsp = null;
                        Statement st = null;
                        ResultSet rs = null;
                        Connection con = null;
                        
                        try
                        {                              
                                 int g = 1;
                                                             
                                 out.println("<table border='2px' align='center'>");
                                 out.println("<tr>");
                                 out.println("<th>Sno</th>");
                                 out.println("<th>Name</th>");                               
                                 out.println("<th>Phoneno</th>");
                                 out.println("<th>EmailId</th>");
                                 out.println("<th>Address</th>");  
                                 out.println("<th>Cryptographic Algorithm</th>");                                                              
                                 out.println("</tr>");

                                 String sql = "select * "
                                         + "from userdetails "
                                         + "where username = '" + session.getAttribute("x") + "' ";

                                 Log.logger.info("sql:"+sql);	  

                                 //CALLING DATABASE Class           
                                 rsp = DatabaseFile.getInstance().codeselect(sql);

                                 st = (Statement) rsp.get(0);
                                 rs = (ResultSet) rsp.get(1);
                                 con = (Connection) rsp.get(2);

                                 while(rs.next())
                                 {                                                             
                                     out.println("<tr>"
                                             + "<td>" + g++ + "</td>"
                                             + "<td>" + rs.getString("Name") +  "</td>"
                                             + "<td>" + rs.getString("Phoneno") + "</td>"
                                             + "<td>" + rs.getString("Email") +  "</td>"
                                             + "<td>" + rs.getString("Address") + "</td>"
                                             + "<td>" + rs.getString("Algorithm") + "</td>"
                                             + "</tr>");
                                 }
                                
                                 out.println("</table>");
                        }
                        catch(Exception e)
                        {
                            e.printStackTrace();

                            Log.logger.error("Error:", e);
                            Log.logger.warn("This is a warning message");
                            Log.logger.trace("This message will not be logged since log level is set as DEBUG");
                        }
                        finally
                        {
                            try
                            {
                                if(st != null)
                                {
                                    st.close(); 
                                    st = null;
                                }
                            }
                            catch(Exception e)
                            {
                                e.printStackTrace();

                                Log.logger.error("Error:", e);
                                Log.logger.warn("This is a warning message");
                                Log.logger.trace("This message will not be logged since log level is set as DEBUG");
                            }

                            try
                            {
                                if(rs != null)
                                {
                                    rs.close(); 
                                    rs = null;
                                }
                            }
                            catch(Exception e)
                            {
                                e.printStackTrace();

                                Log.logger.error("Error:", e);
                                Log.logger.warn("This is a warning message");
                                Log.logger.trace("This message will not be logged since log level is set as DEBUG");
                            }

                            try
                            {
                                if(con != null)
                                {
                                    DatabaseFile.cp.surrenderConnection(con);

                                    con.close();
                                    con = null;
                                }
                            }
                            catch(Exception e)
                            {
                                e.printStackTrace();

                                Log.logger.error("Error:", e);
                                Log.logger.warn("This is a warning message");
                                Log.logger.trace("This message will not be logged since log level is set as DEBUG");
                            }

                            rsp = null;
                        }
                    %>
                    </div>

                   <%
                      //getting response

                      out.println("<font color = 'red' >");

                      try
                      {
                          if( (request.getParameter("msg") != null) && (!request.getParameter("msg").toString().trim().equals("")))
                          {
                              String respMsg = AppBundle.getInstance().loadpropertyfile(request.getParameter("msg"), Constants.Config);

                              out.println(respMsg != null ? respMsg : AppBundle.getInstance().loadpropertyfile("100", Constants.Config));
                          }
                      }
                      catch(Exception e)
                      {
                          e.printStackTrace();
                      }

                      out.println("<font>");
                    %>  
                    <!-- ####################################################################################################### -->
                </div>
            </div>               
    </body>
</html>
