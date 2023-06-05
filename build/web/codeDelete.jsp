<%@page import="java.sql.*"%>
<%@page import="java.util.Vector"%>
<%@page import="com.apps.Logcreation.Log"%>
<%@page import="com.apps.Database.DatabaseFile"%>
<%@page session="true" %>
<%    
    Log objLog  = objLog = new Log();
  
    try 
    {
        //session
        HttpSession hs = request.getSession(true);
       
        //argument
        String username =  hs.getAttribute("x").toString();
        int RequestId = Integer.parseInt(request.getParameter("index"));   
         
        if (((username != null) && (!username.trim().equals(""))) && (RequestId != 0)) 
        {            
            String sql1 = "delete "
                    + "from upload "
                    + "where UploadId = '" + RequestId + "' ";

            DatabaseFile.getInstance().codedelete(sql1);
         
             %>
                <jsp:forward page="viewFiles.jsp">
                     <jsp:param name="msg" value="112"/>
                 </jsp:forward>
             <%                          
        } 
        else 
        {
             %>
                <jsp:forward page="viewFiles.jsp">
                     <jsp:param name="msg" value="113"/>
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
%>