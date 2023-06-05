<%@page import="com.apps.Logcreation.Log"%>
<%@page import="java.sql.*"%>
<%@page session="true" %>
<%
Log objLog  = objLog = new Log();

try
{
    //session  close
    session.getAttribute("x");
       
    //invalidate session or destroy session
    session.invalidate();
    
    %>
        <jsp:forward page="index.jsp"></jsp:forward>
    <%
}
catch(Exception e)
{
    e.printStackTrace();

    Log.logger.error("Error:", e);
    Log.logger.warn("This is a warning message");
    Log.logger.trace("This message will not be logged since log level is set as DEBUG");
}
%>