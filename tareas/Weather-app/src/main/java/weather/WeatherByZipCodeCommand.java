
package weather;

import picocli.CommandLine;

/**
 *
 * @author henge
 */

@CommandLine.Command(name ="by-zip", description ="Get weather for a Zip code")

public class WeatherByZipCodeCommand implements Runnable{

    @CommandLine.Parameters(paramLabel ="zip Code", description ="the zip Code")
    private String zipCode;
   
    @Override
    public void run() {
        System.out.println("By Zip code"+ zipCode);
    }
    
}
