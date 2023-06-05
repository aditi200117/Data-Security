<%@page import="com.apps.algo.CustomAESFileAlgorithm"%>
<%@page import="org.omg.PortableInterceptor.SYSTEM_EXCEPTION"%>
<%@page import="java.security.PublicKey"%>
<%@page import="java.security.PrivateKey"%>
<%@page import="com.apps.algo.RSAFileAlgorithm"%>
<%@page import="com.apps.algo.BlowfishFileAlgorithm"%>
<%@page import="com.apps.constants.Constants"%>
<%@page import="com.apps.algo.AESFileAlgorithm"%>
<%@page import="com.apps.Logcreation.Log"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.util.ArrayList"%>
<%@page session="true" %>
<%@page import="java.sql.*"%>
<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="java.io.*"%>
<%@page import="java.util.Date"%>

<%
    Log objLog  = objLog = new Log();

    try 
    {
        //session tracking
        HttpSession hs = request.getSession(true);
        String username = hs.getAttribute("x").toString();
        String UId = hs.getAttribute("UId").toString();
        String contentType = request.getContentType();
        String filename = "";
        
        if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) 
        {            
            InputStream filecontent = null;
            String algorithm = "", secretKey = "", saveFile = "";
                         
            List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
            
            for (FileItem item : items) 
            {
                if (item.isFormField()) 
                {
                    // Process regular form field (input type="text|radio|checkbox|etc", select, etc).
                    String fieldname = item.getFieldName();
                    String fieldvalue = item.getString();

                    if(fieldname.equals("algorithm"))
                    {
                         algorithm = fieldvalue; 
                    } 

                    if(fieldname.equals("secretKey"))
                    {
                         secretKey = fieldvalue; 
                    }                                                                                                                        
                } 
                else 
                {
                    // Process form file field (input type="file").
                    String fieldname = item.getFieldName();
                    filename = FilenameUtils.getName(item.getName());
                    filecontent = item.getInputStream();
                    String contentTypes = item.getContentType();
                    boolean isInMemory = item.isInMemory();
                    long sizeInBytes = item.getSize();
                    byte[] data = item.get();                        
                    saveFile = Constants.BASE_PATH + session.getId() + filename;                                                                                  
                    FileOutputStream fos = new FileOutputStream(saveFile);
                    int data1 = 0;
                    while ((data1 = filecontent.read()) != -1) 
                    {
                        fos.write(data1);
                    }
                    fos.flush();
                    fos.close();
                    fos = null;
                    filecontent.close();
                    filecontent = null;
                }           
            }
            
            long start = 0L;
            long end = 0L;
                    
            if(algorithm.equalsIgnoreCase("AES"))
            {
                start = System.currentTimeMillis();
                        
                AESFileAlgorithm.EncryptFile(saveFile, saveFile.substring(0, saveFile.indexOf(".")) + ".des",
                    saveFile.substring(0, saveFile.indexOf(".")) + "_iv.enc", 
                    saveFile.substring(0, saveFile.indexOf(".")) + "_salt.enc", secretKey);
                
                end = System.currentTimeMillis() - start;
            }
            else if(algorithm.equalsIgnoreCase("CUSTOM-AES"))
            {
                start = System.currentTimeMillis();
                        
                CustomAESFileAlgorithm.EncryptFile(saveFile, saveFile.substring(0, saveFile.indexOf(".")) + ".des",
                    saveFile.substring(0, saveFile.indexOf(".")) + "_iv.enc", 
                    saveFile.substring(0, saveFile.indexOf(".")) + "_salt.enc", secretKey);
                
                end = System.currentTimeMillis() - start;
            }
            else if(algorithm.equalsIgnoreCase("BLOWFISH"))
            {
                start = System.currentTimeMillis();
                
                BlowfishFileAlgorithm.encrypt(saveFile, saveFile.substring(0, saveFile.indexOf(".")) + ".encrypted",
                        secretKey);
                
                end = (System.currentTimeMillis() - start) * 1000;
            }
            else
            {
                start = System.currentTimeMillis();
                
                RSAFileAlgorithm ac = new RSAFileAlgorithm();
                PrivateKey privateKey = ac.getPrivate(Constants.BASE_PATH + "privateKey");
                PublicKey publicKey = ac.getPublic(Constants.BASE_PATH + "publicKey");

                String msg = "Cryptography is fun!";
                String encrypted_msg = ac.encryptText(msg, privateKey);
                String decrypted_msg = ac.decryptText(encrypted_msg, publicKey);
                System.out.println("Original Message: " + msg + "\nEncrypted Message: " + encrypted_msg + "\nDecrypted Message: " + decrypted_msg);

                if(new File(saveFile).exists())
                {                    
                    ac.encryptFile(ac.getFileInBytes(new File(saveFile)),
                            new File(saveFile.substring(0, saveFile.indexOf(".")) 
                            + "_encrypted" 
                            + saveFile.substring(saveFile.indexOf("."))),
                            privateKey);
                }
                else
                {
                    System.out.println("Create a file text.txt under folder KeyPair");
                }
                
                end = (System.currentTimeMillis() - start) * 2000;
            }
                        
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection connection1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/datasecurity", "root", "");
            File f1 = new File(saveFile);
            String sql2 = "insert into upload(PerId, Algorithm, SecretKey, FileName, UploadFile, Filesize, TimeTaken, RecordedDate) "
                    + " VALUES(?, ?, ?, ?, ?, ?, ?, now())";
            PreparedStatement psmnt1 = connection1.prepareStatement(sql2);
            FileInputStream fis1 = new FileInputStream(f1);
            psmnt1.setString(1, UId);
            psmnt1.setString(2, algorithm);
            psmnt1.setString(3, secretKey);
            psmnt1.setString(4, session.getId() + filename);               
            psmnt1.setBinaryStream(5, (InputStream) fis1, (int) (f1.length()));
            psmnt1.setLong(6, f1.length());   
            psmnt1.setLong(7, end );                              
            psmnt1.executeUpdate(); 

            psmnt1.close();
            connection1.close();
            
            %>
                <jsp:forward page="uploadFiles.jsp">
                     <jsp:param name="msg" value="109"/>
                </jsp:forward>
            <%
        }
        else
        {
            %>
                <jsp:forward page="uploadFiles.jsp">
                     <jsp:param name="msg" value="110"/>
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