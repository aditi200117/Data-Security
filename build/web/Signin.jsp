<%@page import="com.apps.constants.Constants"%>
<%@page import="com.apps.ResourceBundle.AppBundle"%>
<%@page import="java.sql.*"%>
<%@page errorPage="ErrorPage.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
<head profile="http://gmpg.org/xfn/11">
<title>Data Security Using Enhance AES Algorithm In Cloud Computing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="imagetoolbar" content="no" />
<link rel="stylesheet" href="styles/layout.css" type="text/css" />

</head>
<body id="top">
<div class="wrapper row1">
  <div id="header" class="clear">
    <div class="fl_left">
      <h1><a href="index.jsp">Data Security Using Enhance AES Algorithm In Cloud Computing</a></h1>
      <p>Secure Cloud Storage</p>
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
        <li class="active"><a href="index.jsp">User</a></li>
        <li><a href="admin.jsp">Admin</a></li>
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
      <h1>User Registration Form</h1>
     
      <form action="codesignin.jsp" method="post">
         
          <table align="center" border="0px" width="100px">
              
              <tr style="color: red;">
                  <td>Name:</td><td><input type="text" name="name" size="54px"/></td>
              </tr>
              
              <tr style="color: red;">
                  <td>Phone No:</td><td><input type="text" name="phone" size="54px"/></td>
              </tr>
              
              <tr style="color: red;">
                  <td>Email Id:</td><td><input type="text" name="email" size="54px"/></td>
              </tr>
              
              <tr style="color: red;">
                  <td>Address:</td><td><textarea cols="53" rows="6" name="address"></textarea></td>
              </tr>
              
              <tr style="color: red;">
                  <td>Algorithm:</td>
                  <td><select name="algorithm" style="width: 338px;">
                          <option value="select">-Select-</option>
                          <option value="AES">AES</option>
                          <option value="CUSTOM-AES">CUSTOM-AES</option>
                          <option value="RSA">RSA</option>
                          <option value="BLOWFISH">BLOWFISH</option>
                      </select>
                  </td>
              </tr>
              
              <tr style="color: red;">
                  <td>Username:</td><td><input type="text" name="username" size="54px"/></td>
              </tr>
              
              <tr style="color: red;">
                  <td>Password:</td><td><input type="password" name="password" size="54px"/></td>
              </tr>
              
              <tr>
                  <td>&nbsp;</td>
                  <td><input type="submit" value="Submit"/><input type="reset" value="Reset"/></td>
              </tr>
              
          </table>
      </form>
                      
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
