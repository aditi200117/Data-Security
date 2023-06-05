/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.apps.Logcreation;

import com.apps.ResourceBundle.AppBundle;
import com.apps.constants.Constants;
import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;


/**
 *
 * @author kiruba
 */
public class Log {

    public static Logger logger = Logger.getLogger(Log.class.getName());
    
    public Log() 
    {
        try
        {   
            BasicConfigurator.configure(); 
            
            PropertyConfigurator.configure(getClass().getResource(AppBundle.getInstance().loadpropertyfile("LogPath", Constants.Config))); 
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
