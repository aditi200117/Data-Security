<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="java.util.Vector"%>
<%@page import="com.apps.Logcreation.Log"%>
<%@page import="java.sql.*"%>

<%
 Log objLog  = objLog = new Log();
 Vector<Object> rsp = null;
 Statement st = null;
 ResultSet rs = null;
 Connection con = null;
 int count = 0;
 int perId = 0;
 
try
{
    //getting values from design page
    String name = request.getParameter("name");   
    String phoneno = request.getParameter("phone");
    String email = request.getParameter("email");
    String address = request.getParameter("address");  
    String algorithm = request.getParameter("algorithm");     
    String username = request.getParameter("username");
    String password = request.getParameter("password");      
    
    if( ((name!=null) && (!name.trim().equals(""))) && ((phoneno!=null) && (!phoneno.trim().equals(""))) 
            && ((email!=null) && (!email.trim().equals(""))) && ((address!=null) && (!address.trim().equals("")))
            && ((algorithm!=null) && (!algorithm.trim().equalsIgnoreCase("select")))            
            && ((username!=null) && (!username.trim().equals(""))) && ((password!=null) && (!password.trim().equals(""))) )
    {        
        //type casting
        Long mobile = Long.parseLong(phoneno);
      
        //jdbc connection
        try
        {
                        try
                        {                    
                            String sql = "select count(*) as c "
                                       + "from userdetails "
                                       + "where Username = '"+username+"' "
                                       + "and  Password = '"+password+"' "
                                       + "and Name = '"+name+"' ";
                            
                            System.out.println("sql:"+ sql);

                            //CALLING DATABASE Class           
                            rsp = DatabaseFile.getInstance().codeselect(sql);

                            st = (Statement) rsp.get(0);
                            rs = (ResultSet) rsp.get(1);
                            con = (Connection) rsp.get(2);

                            while(rs.next())
                            {
                                count = rs.getInt(1);
                                System.out.println("count:"+ count);
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

                        if(count > 0)
                        {
                           %>
                               <jsp:forward page="Signin.jsp">
                                   <jsp:param name="msg" value="104"></jsp:param>
                               </jsp:forward>
                           <%
                        }

                        if(count == 0)
                        {                            
                            String sql = "insert into userdetails(Name, Phoneno, Email, Address, Algorithm, Username, Password, Status, RecordedDate)"
                                + " values('"+name+"', '"+mobile+"', '"+email+"', '"+address+"', '"+algorithm+"', '"+username+"', '"+password+"', '1', now())";

                            DatabaseFile.getInstance().codeinsert(sql);
                            
                            try
                            {                    
                                String sql1 = "select PerId "
                                           + "from userdetails "
                                           + "where Username = '"+username+"' "
                                           + "and  Password = '"+password+"' "
                                           + "and Name = '"+name+"' ";

                                System.out.println("sql1:"+ sql1);

                                //CALLING DATABASE Class           
                                rsp = DatabaseFile.getInstance().codeselect(sql1);

                                st = (Statement) rsp.get(0);
                                rs = (ResultSet) rsp.get(1);
                                con = (Connection) rsp.get(2);

                                while(rs.next())
                                {
                                    perId = rs.getInt(1);
                                    System.out.println("perId:"+ perId);
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
                               <jsp:forward page="index.jsp">
                                   <jsp:param name="msg" value="105"></jsp:param>
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
    else
    {
           %>
           <jsp:forward page="Signin.jsp">
               <jsp:param name="msg" value="102"></jsp:param>
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