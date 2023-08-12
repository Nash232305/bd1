package weather;

import picocli.CommandLine;

/**
 *
 * @author henge
 */

@CommandLine.Command(name ="by-city", description ="Get weather for a particular city")

public class WeatherByCityCommand implements Runnable {

    @CommandLine.Parameters(paramLabel ="city name", description ="the city name")
    private String cityName;
    
    @Override
    public void run() {
      System.out.println("By city" + cityName);
      try{
             WeatheService weatherService = new WeatherServicelmpl();
             System.out.println(weatherService.getCityTemperature(cityName));
      }catch (Exception e){
          System.out.println("City Name"+ "is not supported");
      }
   
    }
}
