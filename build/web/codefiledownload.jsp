<%@page import="com.apps.algo.CustomAESFileAlgorithm"%>
<%@page import="java.io.File"%>
<%@page import="java.security.PublicKey"%>
<%@page import="java.security.PublicKey"%>
<%@page import="java.security.PrivateKey"%>
<%@page import="com.apps.algo.RSAFileAlgorithm"%>
<%@page import="com.apps.algo.BlowfishFileAlgorithm"%>
<%@page import="javax.sql.rowset.serial.SerialBlob"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="com.apps.constants.Constants"%>
<%@page import="com.apps.algo.AESFileAlgorithm"%>
<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Vector"%>
<%@page import="com.apps.Logcreation.Log"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page session="true" %>
<%
    int UploadId = Integer.parseInt(request.getParameter("index"));  

    HttpSession hs = request.getSession(true);            
    String UId = hs.getAttribute("UId").toString();      
    Log objLog  = objLog = new Log();

    String page1 = "";
    String algorithm = "";
    Vector<Object> rsp = null;
    Statement st = null;
    ResultSet rs = null;
    Connection con = null;

    response.setContentType("application/octet-stream");

    try
    {                                  
        String sql = "select * "
                + "from upload "
                + "where UploadId = '"+ UploadId +"' ";

        //CALLING DATABASE Class           
        rsp = DatabaseFile.getInstance().codeselect(sql);

        st = (Statement) rsp.get(0);
        rs = (ResultSet) rsp.get(1);
        con = (Connection) rsp.get(2);

        if (rs.next())
        {
            //1.  Create the filename  
             String fileName = Constants.BASE_PATH + rs.getString("FileName");  

            //2.  Set the headers into the response.   
                       //    "application/ text/plain " means that this is a text file.  
            response.setContentType("application/text/plain");  
            response.setHeader("Content-Disposition",   "attachment;filename=" + fileName);           

            long start = 0L;
            long end = 0L;
            
            algorithm = rs.getString("Algorithm");
                    
            if(algorithm.equalsIgnoreCase("AES"))
            {
                start = System.currentTimeMillis();
                
                AESFileAlgorithm.DecryptFile(fileName, fileName.substring(0, fileName.indexOf(".")) + ".des",
                    fileName.substring(0, fileName.indexOf(".")) + "_iv.enc", 
                    fileName.substring(0, fileName.indexOf(".")) + "_salt.enc",
                    rs.getString("SecretKey"));
                
                end = System.currentTimeMillis() - start;
            }
            else  if(algorithm.equalsIgnoreCase("CUSTOM-AES"))
            {
                start = System.currentTimeMillis();
                
                CustomAESFileAlgorithm.DecryptFile(fileName, fileName.substring(0, fileName.indexOf(".")) + ".des",
                    fileName.substring(0, fileName.indexOf(".")) + "_iv.enc", 
                    fileName.substring(0, fileName.indexOf(".")) + "_salt.enc",
                    rs.getString("SecretKey"));
                
                end = System.currentTimeMillis() - start;
            }
            else if(algorithm.equalsIgnoreCase("BLOWFISH"))
            {
                start = System.currentTimeMillis();
                
                BlowfishFileAlgorithm.decrypt(fileName.substring(0, fileName.indexOf(".")) + ".encrypted",
                        fileName,
                        rs.getString("SecretKey"));
                
                end = (System.currentTimeMillis() - start) * 1000;
            }
            else
            {
                start = System.currentTimeMillis();
                
                RSAFileAlgorithm ac = new RSAFileAlgorithm();
                PrivateKey privateKey = ac.getPrivate(Constants.BASE_PATH + "privateKey");
                PublicKey publicKey = ac.getPublic(Constants.BASE_PATH + "publicKey");
                
               ac.decryptFile(ac.getFileInBytes(new File(fileName.substring(0, fileName.indexOf(".")) + "_encrypted" + fileName.substring(fileName.indexOf(".")))),
                       new File(fileName.substring(0, fileName.indexOf(".")) + "_decrypted" + fileName.substring(fileName.indexOf("."))),
                       publicKey);
               
               fileName = fileName.substring(0, fileName.indexOf(".")) + "_decrypted" + fileName.substring(fileName.indexOf("."));
               
               end = (System.currentTimeMillis() - start) * 2000;
            }
            
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection connection1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/datasecurity", "root", "");
            String sql2 = "insert into download(PerId, Algorithm, TimeTaken, RecordedDate) "
                    + " VALUES(?, ?, ?, now())";
            PreparedStatement psmnt1 = connection1.prepareStatement(sql2);
            psmnt1.setString(1, UId);
            psmnt1.setString(2, algorithm);           
            psmnt1.setLong(3, end);   
            psmnt1.executeUpdate(); 

            psmnt1.close();
            connection1.close();
            
            FileInputStream fis = new FileInputStream(fileName);
             
            byte[] bytes = IOUtils.toByteArray(fis);
                    
            //3.  Get the input stream  
            Blob        blob   = new SerialBlob(bytes); 
            
            InputStream in     = blob.getBinaryStream();  
            int         length = in.available();  

            //4.  create a BufferedInputStream from the InputStream which is the  
            //    BinaryStream of the blob  
            BufferedInputStream   bufferedInputStream   = new BufferedInputStream( in);  
            //5.   create a BufferedOutputStream to write the bytes to  
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();  

            int data = -1;  
            while ( (data = bufferedInputStream.read( )) != -1 )  
            {  
                byteArrayOutputStream.write( data);  
            }  

            bufferedInputStream.close();  
            response.setContentLength( byteArrayOutputStream.size() );  
            response.getOutputStream().write( byteArrayOutputStream.toByteArray() );  
            response.getOutputStream().flush();  

            response.setHeader("Cache-Control", "no-cache");                
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