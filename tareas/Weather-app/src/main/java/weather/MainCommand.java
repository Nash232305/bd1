package weather;
import picocli.CommandLine;

/**
 *
 * @author henge
 */
@CommandLine.Command(
        name ="Weather App",
        subcommands ={
            WeatherByCityCommand.class,
            CommandLine.HelpCommand.class
        },
        description = "Weather App service by City and Zip code"
)

public class MainCommand implements Runnable {

    @Override
    public void run() {
     
    }
    
    
}
