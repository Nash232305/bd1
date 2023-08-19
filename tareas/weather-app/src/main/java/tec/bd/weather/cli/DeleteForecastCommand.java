
package tec.bd.weather.cli;

import picocli.CommandLine;
import tec.bd.weather.ApplicationContext;
import tec.bd.weather.entity.Forecast;

/**
 *
 * @author henge
 */

@CommandLine.Command(name = "delete-forecast", aliases ={"uf"}, description= "delete  forecast the data")

public class DeleteForecastCommand implements Runnable {
    
    
    @CommandLine.Parameters(paramLabel = "<forecast id>", description = "The detele forecast id")
    private int deleteForecastId;
    
    @CommandLine.Parameters(paramLabel = "<country name>", description = "The delete country name")
    private String countryName;
    
    @CommandLine.Parameters(paramLabel = "<city name>", description = "The delete city name")
    private String cityName;
    
    @CommandLine.Parameters(paramLabel = "<zip code", description = "The delete Zip code")
    private String zipCode;
    
    @CommandLine.Parameters(paramLabel = "temperature", description = "Delete temperature value")
    private float temperature;

    
    
  
    
    
    @Override
    public void run() {
         try {
            var appContext = new ApplicationContext();
            var weatherService = appContext.getWeatherService();
            var forecast = new Forecast(deleteForecastId, countryName, cityName, zipCode, temperature);
            weatherService.removeForecast(deleteForecastId);
            System.out.println(forecast);              
          } catch (Exception e) {
              System.out.println("Can't delete forecast " + e.getMessage());
          }
    }

}
    

