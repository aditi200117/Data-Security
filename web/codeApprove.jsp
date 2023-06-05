<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="java.util.Vector"%>
<%@page import="com.apps.Logcreation.Log"%>
<%@page import="java.sql.*"%>
<%@page session="true" %>
<%
    Log objLog  = objLog = new Log();
                            
    try 
    {
        //session
        HttpSession hs = request.getSession(true);

        //argument
        String username = hs.getAttribute("x").toString();
        int requestid = Integer.parseInt(request.getParameter("index"));
        String status = request.getParameter("index1");
       
        if (((username != null) && (!username.trim().equals(""))) && (requestid != 0)) 
        {    
            if(status.equalsIgnoreCase("0"))
            {
                status = "1";
            }
            else if(status.equalsIgnoreCase("1"))
            {
                status = "0";
            }
                
            String sql = "update userdetails "
                        + "set Status = '" + status + "' "
                        + "where PerId = '" + requestid + "' ";
                
            DatabaseFile.getInstance().codeupdate(sql);
            
            %>
                <jsp:forward page="Approve.jsp">
                    <jsp:param name="msg" value="107"/>
                </jsp:forward>
            <%
        }
        else
        {
            %>
                <jsp:forward page="Approve.jsp">
                    <jsp:param name="msg" value="100"/>
                </jsp:forward>
            <%
        }          
    } 
    catch (Exception e) 
    {
         e.printStackTrace();

         Log.logger.error("Error:", e);
         Log.logger.warn("This is a warning message");
         Log.logger.trace("This message will not be logged since log level is set as DEBUG");
    }
%>