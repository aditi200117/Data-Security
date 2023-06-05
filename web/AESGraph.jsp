<%@page import="com.apps.graph.ComparisionGraph3"%>
<%@page import="com.apps.graph.ComparisionGraph2"%>
<%@page import="com.apps.Logcreation.Log"%>
<%@page import="java.util.Random"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
<head profile="http://gmpg.org/xfn/11">
<title>Data Security Using Enhance AES Algorithm In Cloud Computing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="imagetoolbar" content="no" />
<link rel="stylesheet" href="styles/layout.css" type="text/css" />
<%@page errorPage="ErrorPage.jsp"%>
</head>
<body id="top">
<div class="wrapper row1">
  <div id="header" class="clear">
    <div class="fl_left">
      <h1><a href="index.jsp">Data Security Using Enhance AES Algorithm In Cloud Computing</a></h1>
       <p>Secure Cloud Storage
          <span style="padding-left: 650px; color: red;"> Welcome : <%=session.getAttribute("x")%></span>  </p>
    </div>
    <div class="fl_right">
      <ul>
<!--        <li><a href="#">Home</a></li>
        <li><a href="#">Contact Us</a></li>
        <li><a href="#">A - Z Index</a></li>-->
<!--<li class="last"><a href="Admin.jsp">Admin Login</a></li>-->
<!--        <li class="last"><a href="#">Staff Login</a></li>-->
      </ul>
<!--      <form action="#" method="post" id="sitesearch">
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
        <li><a href="ViewAllProfile.jsp">View Profile</a></li> 
        <li><a href="Approve.jsp">Approve</a></li>
        <li><a href="Graph.jsp">Graph</a></li>  
        <li class="active"><a href="AESGraph.jsp">AES Comparision Graphs</a></li> 
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
      
      <h1>Graph 1 :</h1>
            
     <%                                        
        ComparisionGraph3  objBarChart3 = new ComparisionGraph3();                                                                                                                                            
     %>  

    <table border="0px" align="center">
        <tr>                                                         
            <td><img src="${pageContext.request.contextPath}/images/ComparisionGraph3.png" alt="Graph"/></td>                                                       
        </tr>
    </table>
        
     <h1>Graph 2 :</h1>
            
     <%                                        
        ComparisionGraph2  objBarChart2 = new ComparisionGraph2();                                                                                                                                            
     %>  

    <table border="0px" align="center">
        <tr>                                                         
            <td><img src="${pageContext.request.contextPath}/images/ComparisionGraph2.png" alt="Graph"/></td>                                                       
        </tr>
    </table>
                                                                
      <%
      //getting response
      
      out.println("<font color = 'red' >");
      
      try
      {
          if( (request.getParameter("msg") != null) && (!(request.getParameter("msg").trim().equals(""))) )
          {
              out.println(request.getParameter("msg"));
          }
      }
      catch(Exception e)
      {
          e.printStackTrace();
          Log.logger.error("Error:", e); 
      }
      out.println("<font>");
      %>
      <!-- ####################################################################################################### -->
    </div>
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