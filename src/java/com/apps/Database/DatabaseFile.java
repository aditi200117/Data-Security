/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.apps.Database;

import com.apps.ResourceBundle.AppBundle;
import com.apps.Logcreation.Log;
import com.apps.constants.Constants;
import java.sql.*;
import java.util.Vector;

/**
 *
 * @author KIRUBAKARAN
 */
public class DatabaseFile 
{
    public static DatabaseFile objDatabaseFile = null;
    public static ConnectionPool cp = null;
    public static Connection con = null;
    public static Statement st = null;
    public static ResultSet rs = null; 
            
    public static DatabaseFile getInstance()
    {
        Log.logger.info("DatabaseFile-->getInstance()");
        
        if(objDatabaseFile == null)
        {
            objDatabaseFile = new DatabaseFile();
            
            Log.logger.info("DatabaseFile Instance Created");
            
            try 
            {
                if(cp == null)
                {                    
                    Log.logger.info(Integer.parseInt(AppBundle.getInstance().loadpropertyfile("MaxPool", Constants.Config).toString().trim()));
                    Log.logger.info(Integer.parseInt(AppBundle.getInstance().loadpropertyfile("MinPool", Constants.Config).toString().trim()));
                    Log.logger.info(AppBundle.getInstance().loadpropertyfile("dbpath", Constants.Config).toString().trim() + AppBundle.getInstance().loadpropertyfile("databaseName", Constants.Config).toString().trim());
                    Log.logger.info(AppBundle.getInstance().loadpropertyfile("username", Constants.Config).toString().trim());
                    Log.logger.info(AppBundle.getInstance().loadpropertyfile("password", Constants.Config).toString().trim());
                    Log.logger.info(AppBundle.getInstance().loadpropertyfile("driver", Constants.Config).toString().trim());
                            
                    cp = new ConnectionPool(
                            Integer.parseInt(AppBundle.getInstance().loadpropertyfile("MaxPool", Constants.Config).toString().trim()), 
                            Integer.parseInt(AppBundle.getInstance().loadpropertyfile("MinPool", Constants.Config).toString().trim()), 
                            AppBundle.getInstance().loadpropertyfile("dbpath", Constants.Config).toString().trim() + AppBundle.getInstance().loadpropertyfile("databaseName", Constants.Config).toString().trim(), 
                            AppBundle.getInstance().loadpropertyfile("username", Constants.Config).toString().trim(), 
                            AppBundle.getInstance().loadpropertyfile("password", Constants.Config).toString().trim(), 
                            AppBundle.getInstance().loadpropertyfile("driver", Constants.Config).toString().trim());
                    
                    Log.logger.info("DatabaseFile Connection Pool Created");
                }
            } 
            catch (Exception e) 
            {
                e.printStackTrace();

                Log.logger.error("Error:", e);
                Log.logger.warn("This is a warning message");
                Log.logger.trace("This message will not be logged since log level is set as DEBUG");
            }       
        }
        
        return objDatabaseFile;
    }
            
    //select code here
    public Vector<Object> codeselect(String sql)
    {            
        Vector<Object> objRes = null;
        
        Log.logger.info("DatabaseFile-->codeselect()");
        
        try
        {      
            objRes = new Vector<Object>();
            
            con = cp.borrowConnection();
            
            if(con != null)
            {
                st = con.createStatement();
            
                rs  = st.executeQuery(sql);                      
            }
            else
            {
                System.out.println("No Connection :" + con);
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
                    objRes.add(st);
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
                    objRes.add(rs);
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
                   objRes.add(con);
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
                
        return objRes;
    }
    
    //insert code here
    public void codeinsert(String sql)
    { 
        Log.logger.info("DatabaseFile-->codeinsert()");
        
        try
        {                      
            con = cp.borrowConnection();
            
            if(con != null)
            {
                st = con.createStatement();
                
                st.executeUpdate(sql);     
            }
            else
            {
                System.out.println("No Connection :" + con);
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
                if(con != null)
                {
                    cp.surrenderConnection(con); 
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
        }
    }
    
    //update code here
    public void codeupdate(String sql)
    {
        Log.logger.info("DatabaseFile-->codeupdate()");
        
        try
        {         
            con = cp.borrowConnection();
            
            if(con != null)
            {
                st = con.createStatement();
                
                st.executeUpdate(sql);     
            }
            else
            {
                System.out.println("No Connection :" + con);
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
                if(con != null)
                {
                    cp.surrenderConnection(con); 
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
        }
    }
    
    //delete code here
    public void codedelete(String sql)
    {  
        Log.logger.info("DatabaseFile-->codedelete()");
        
        try
        {
            con = cp.borrowConnection();
            
            if(con != null)
            {
                st = con.createStatement();
                
                st.executeUpdate(sql);     
            }
            else
            {
                System.out.println("No Connection :" + con);
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
                if(con != null)
                {
                    cp.surrenderConnection(con); 
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
        }
    }
}