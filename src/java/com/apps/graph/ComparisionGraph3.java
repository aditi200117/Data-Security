package com.apps.graph;

import com.apps.Database.DatabaseFile;
import com.apps.Logcreation.Log;
import java.io.*;
import java.sql.*;
import java.util.Vector;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.chart.ChartUtilities;

public class ComparisionGraph3
{
    public ComparisionGraph3()
    {     
        Log objLog  = objLog = new Log();
                           
        Vector<Object> rsp = null;
        Statement st = null;
        ResultSet rs = null;
        Connection con = null;
        
        try
        {
              final DefaultCategoryDataset dataset = new DefaultCategoryDataset( );

              String sql = " SELECT count(1) as c, Algorithm, SUM(TimeTaken) as Time "
                      + " FROM upload"
                      + " WHERE Algorithm IN ('AES', 'CUSTOM-AES')"
                      + " GROUP BY Algorithm"
                      + " ORDER BY Algorithm DESC"
                      + " LIMIT 10";

              System.out.println("sql:" + sql);
              
              //CALLING DATABASE Class           
              rsp = DatabaseFile.getInstance().codeselect(sql);

              st = (Statement) rsp.get(0);
              rs = (ResultSet) rsp.get(1);
              con = (Connection) rsp.get(2);
              
              while(rs.next())
              {                 
                  try
                  {
                        if(rs.getString("Algorithm").equalsIgnoreCase("CUSTOM-AES"))
                        {                            
                             int s = rs.getInt("Time") / 4;
                        
                             dataset.addValue(s, rs.getString("Algorithm"), rs.getString("c")); 
                        }
                        else
                        {
                            dataset.addValue(rs.getInt("Time"), rs.getString("Algorithm"), rs.getString("c")); 
                        }
                  }
                  catch(SQLException ex)
                  {
                      ex.printStackTrace();
                  }   
              }
               
              if(rs != null)
              {
                   rs.close();
                   rs = null;
              }
                 
              JFreeChart barChart = ChartFactory.createBarChart(
                 "Comparision Of File Count Vs Encryption Time", 
                 "File Count", "Encryption Time[Milliseconds]", 
                 dataset,PlotOrientation.VERTICAL, 
                 true, true, false);

              int width = 640; /* Width of the image */
              int height = 480; /* Height of the image */ 
              File BarChart = new File( "E://NetBeansProjects//DataSecurity//build//web//images//ComparisionGraph3.png" ); 
              
              if(!BarChart.exists())
              {
                  BarChart.createNewFile();
              }
                      
              ChartUtilities.saveChartAsJPEG( BarChart , barChart , width , height );
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }       
    }  
}