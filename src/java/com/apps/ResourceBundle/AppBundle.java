package com.apps.ResourceBundle;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Properties;
import com.apps.Logcreation.Log;
import com.apps.constants.Constants;

public class AppBundle {
       
    public static AppBundle objAppBundle = null;
    
    public static AppBundle getInstance()
    {
        if(objAppBundle == null)
        {
            objAppBundle = new AppBundle();
        }
        
        return objAppBundle;
    }
    
    public String loadpropertyfile(String portno, String config) 
    {
        String value = "";
        InputStream is = null;

        try 
        {
            Properties prop = new Properties();

            is = this.getClass().getResourceAsStream(config + ".properties");

            prop.load(is);

            value = prop.getProperty(portno);         
        } 
        catch (Exception ex) 
        {
            ex.printStackTrace();
            Log.logger.error("Error:", ex);
            Log.logger.warn("This is a warning message");
            Log.logger.trace("This message will not be logged since log level is set as DEBUG");         
        }
        finally
        {
            try
            {
                is.close();
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }         
        }

        return value;
    }
    
     public String getloadpropertyfile(String portno, String config) 
     {
        String value = "";
        FileInputStream in = null;

        try 
        {
            Properties prop = new Properties();
           
            String filepath = AppBundle.getInstance().loadpropertyfile("ConfigDir", Constants.Config);
            
            in = new FileInputStream(new File(filepath + config + ".properties"));

            prop.load(in);

            value = prop.getProperty(portno);           
        } 
        catch (Exception ex) 
        {
            ex.printStackTrace();
            Log.logger.error("Error:", ex);
            Log.logger.warn("This is a warning message");
            Log.logger.trace("This message will not be logged since log level is set as DEBUG");      
        }
        finally
        {
            try
            {
                in.close();                
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }          
        }

        return value;
    }

    public void setloadpropertyfile(String label, String value, String config) 
    {
        OutputStream out = null;

        try 
        {
            Properties props = new Properties();

            String filepath = AppBundle.getInstance().loadpropertyfile("ConfigDir", Constants.Config);
            
            File f = new File(filepath + config + ".properties");

            if (f.exists()) 
            {                
                props.load(new FileReader(f));
                
                //Change your values here
                props.setProperty(label, value);
            } 
            else 
            {                
                //Set default values?
                props.setProperty(label, value);

                f.createNewFile();
            }

            out = new FileOutputStream(f);
            
            props.store(out, "This is an optional header comment string");

            System.out.println(props.get(label));

        } 
        catch (Exception ex) 
        {
            ex.printStackTrace();
            Log.logger.error("Error:", ex);
            Log.logger.warn("This is a warning message");
            Log.logger.trace("This message will not be logged since log level is set as DEBUG");         
        } 
        finally 
        {            
                try 
                {
                    if (out != null) 
                    {
                        out.flush();
                        out.close();
                    }
                } 
                catch (IOException ex) 
                {
                    ex.printStackTrace();
                    Log.logger.error("Error:", ex);
                    Log.logger.warn("This is a warning message");
                    Log.logger.trace("This message will not be logged since log level is set as DEBUG");                   
                }          
        }
    }
}
