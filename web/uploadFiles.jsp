<%@page import="java.util.Vector"%>
<%@page import="com.apps.constants.Constants"%>
<%@page import="com.apps.ResourceBundle.AppBundle"%>
<%@page import="com.apps.Logcreation.Log"%>
<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="java.sql.*"%>
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
                    <!--      <ul>
                            <li><a href="#">Home</a></li>
                            <li><a href="#">Contact Us</a></li>
                            <li><a href="#">A - Z Index</a></li>
                            <li class="last"><a href="#">Admin Login</a></li>
                            <li class="last"><a href="#">Staff Login</a></li>
                          </ul>
                          <form action="#" method="post" id="sitesearch">
                            <fieldset>
                              <strong>Search:</strong>
                              <input type="text" value="Search Our Website&hellip;" onfocus="this.value=(this.value=='Search Our Website&hellip;')? '' : this.value ;" />
                              <input type="image" src="images/search.gif" id="search" alt="Search" />
                            </fieldset>
                          </form>-->
                </div>
            </div>
        </div>
        <!-- ####################################################################################################### -->
        <div class="wrapper row2">
            <div class="rnd">
                <!-- ###### -->
                <div id="topnav">
                    <ul>
                        <li><a href="ViewProfile.jsp">View Profile</a></li>                       
                        <li class="active"><a href="uploadFiles.jsp">Upload</a></li>
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
                    <h1>Upload Files To Cloud Server</h1>

                     <form action="codeUploadFiles.jsp" method="post" enctype="multipart/form-data">
                       
                        <table align="center" border="0px" width="100px">
                         
                            <tr>
                                  <td>File Upload</td>
                                  <td><input type="file" name="filepath" id="filepath"></input></td>
                            </tr>
                      
                            <tr>                                   
                                  <td>Algorithm</td>
                                  
                                  <td>
                                      <select name="algorithm" id="algorithm" style="width: 200px;">
                                        
                                          <%                                         
                                          Log objLog  = objLog = new Log();
                                          Vector<Object> rsp = null;
                                          Statement st = null;
                                          ResultSet rs = null;
                                          Connection con = null;
                                          String algo = "";
                                          
                                          try
                                          {                                              
                                              String sql = "select Algorithm "
                                                      + "from userdetails "
                                                      + "Where PerId = '"+session.getAttribute("UId")+"'";

                                              //CALLING DATABASE Class           
                                              rsp = DatabaseFile.getInstance().codeselect(sql);

                                              st = (Statement) rsp.get(0);
                                              rs = (ResultSet) rsp.get(1);
                                              con = (Connection) rsp.get(2);

                                              while(rs.next())
                                              {
                                                  algo = rs.getString(1);
                                                          
                                                  %>
                                                  <option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
                                                  <%
                                              }

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
                                      </select>
                                  </td>
                              </tr>
                                      
                              <%
                              
                                if(null != algo && !algo.equalsIgnoreCase("") && algo.equalsIgnoreCase("RSA"))
                                {
                                    %>
                                    
                                    <tr>
                                          <td>File Password</td>
                                          <td><input type="text" name="secretKey" id="secretKey" maxlength="6" readonly="true"></input></td>
                                    </tr>
                                    
                                    <%
                                }
                                else
                                {
                                    %>
                                    
                                    <tr>
                                          <td>File Password</td>
                                          <td><input type="text" name="secretKey" id="secretKey" maxlength="6"></input></td>
                                    </tr>
                                    
                                    <%      
                                }
                                                  
                              %>
                                                                    
                            <tr>
                                <td>&nbsp;</td>
                                <td><input type="submit" value="Submit" /><input type="reset" value="Reset"/></td>
                            </tr>
                        </table>
                        
                    </form>
                    
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
            </div>
        </div>
        <!-- ####################################################################################################### 
        <div class="wrapper row4">
          <div class="rnd">
            <div id="footer" class="clear">
               ####################################################################################################### 
              <div class="fl_left clear">
                <div class="fl_left center"><img src="images/demo/worldmap.gif" alt="" /><br />
                  <a href="#">Find Us With Google Maps &raquo;</a></div>
                <address>
                Address Line 1<br />
                Address Line 2<br />
                Town/City<br />
                Postcode/Zip<br />
                <br />
                Tel: xxxx xxxx xxxxxx<br />
                Email: <a href="#">contact@domain.com</a>
                </address>
              </div>
              <div class="fl_right">
                <div id="social" class="clear">
                  <p>Stay Up to Date With Whats Happening</p>
                  <ul>
                    <li><a style="background-position:0 0;" href="#">Twitter</a></li>
                    <li><a style="background-position:-72px 0;" href="#">LinkedIn</a></li>
                    <li><a style="background-position:-142px 0;" href="#">Facebook</a></li>
                    <li><a style="background-position:-212px 0;" href="#">Flickr</a></li>
                    <li><a style="background-position:-282px 0;" href="#">RSS</a></li>
                  </ul>
                </div>
                <div id="newsletter">
                  <form action="#" method="post">
                    <fieldset>
                      <legend>Subscribe To Our Newsletter:</legend>
                      <input type="text" value="Enter Email Here&hellip;" onfocus="this.value=(this.value=='Enter Email Here&hellip;')? '' : this.value ;" />
                      <input type="text" id="subscribe" value="Submit" />
                    </fieldset>
                  </form>
                </div>
              </div>
               ####################################################################################################### 
            </div>
          </div>
        </div>
         ####################################################################################################### 
        <div class="wrapper">
          <div id="copyright" class="clear">
            <p class="fl_left">Copyright &copy; 2011 - All Rights Reserved - <a href="#">Domain Name</a></p>
            <p class="fl_right">Template by <a href="http://www.os-templates.com/" title="Free Website Templates">OS Templates</a></p>
          </div>
        </div>-->
    </body>
</html>
