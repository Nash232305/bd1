package tec.bd.weather.cli;

import picocli.CommandLine;

import tec.bd.weather.cli.ForecastLog.LogCommand;
import tec.bd.weather.cli.city.CreateCityCommand;
import tec.bd.weather.cli.city.DeleteCityCommand;
import tec.bd.weather.cli.city.ReadCityCommand;
import tec.bd.weather.cli.city.UpdateCityCommand;
import tec.bd.weather.cli.country.CreateCountryCommand;
import tec.bd.weather.cli.country.DeleteCountryCommand;
import tec.bd.weather.cli.country.ReadCountryCommand;
import tec.bd.weather.cli.country.UpdateCountryCommand;
import tec.bd.weather.cli.forecast.*;
import tec.bd.weather.cli.state.CreateStateCommand;
import tec.bd.weather.cli.state.DeleteStateCommand;
import tec.bd.weather.cli.state.ReadStateCommand;
import tec.bd.weather.cli.state.UpdateStateCommand;

@CommandLine.Command(
        name = "Weather App",
        subcommands = {
                CreateCountryCommand.class,
                DeleteCountryCommand.class,
                ReadCountryCommand.class,
                UpdateCountryCommand.class,
                //State related Commands
                CreateStateCommand.class,
                DeleteStateCommand.class,
                ReadStateCommand.class,
                UpdateStateCommand.class,
                //City related Commands
                CreateCityCommand.class,
                DeleteCityCommand.class,
                ReadCityCommand.class,
                UpdateCityCommand.class,
                // forecast related Commands
                CreateForecastCommand.class,
                DeleteForecastCommand.class,
                ReadForecastByIdCommand.class,
                ReadForecastByDateCommand.class,
                ReadForecastByZipCommand.class,
                UpdateForecastCommand.class,
                //forecast log related Commands
                LogCommand.class,
        },
        description = "Weather App")
public class MainCommand implements Runnable {

    @Override
    public void run() {

    }
}













