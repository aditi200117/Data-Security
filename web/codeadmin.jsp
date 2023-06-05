<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="com.apps.Logcreation.Log"%>
<%@page import="java.util.Vector"%>
<%@page import="java.sql.*" %>
<%@page  session="true" %>
<%

Log objLog  = objLog = new Log();
 
try
{
    //getting value from 
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    //session 
    session.setAttribute("x", username);
   
    Vector<Object> rsp = null;
    Statement st = null;
    ResultSet rs = null;
    Connection con = null;
    int count = 0;
    
    //jdbc coding
    try
    {
         
        if( ((username!=null) && (!username.trim().equals(""))) && ((password!=null) && (!password.trim().equals(""))))
        {           
            String sql = "select * "
                    + "from admindetails "
                    + "where Username = '"+username+"' "
                    + "and Password = '"+password+"' ";

            //CALLING DATABASE Class           
            rsp = DatabaseFile.getInstance().codeselect(sql);

            st = (Statement) rsp.get(0);
            rs = (ResultSet) rsp.get(1);
            con = (Connection) rsp.get(2);

            while(rs.next())
            { 
                count = rs.getInt(1);
                                
                //page redirection
                 %>
                    <jsp:forward page="ViewAllProfile.jsp"></jsp:forward>
                 <%
            }                                              
                 //page redirection
                 %>
                     <jsp:forward page="admin.jsp">
                         <jsp:param name="msg" value="101"/>
                     </jsp:forward>
                 <%           
        }
        else
        {
             //page redirection
             %>
                 <jsp:forward page="admin.jsp">
                     <jsp:param name="msg" value="102"/>
                 </jsp:forward>
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
}
catch(Exception e)
{
    e.printStackTrace();
            
    Log.logger.error("Error:", e);
    Log.logger.warn("This is a warning message");
    Log.logger.trace("This message will not be logged since log level is set as DEBUG");
}
%>
