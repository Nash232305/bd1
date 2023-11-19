package tec.bd.weather.repository.service;

import tec.bd.weather.entity.beforeForecast;
import tec.bd.weather.repository.Repository;

import javax.management.remote.MBeanServerForwarder;
import java.util.List;

public class WeatherServiceImpl implements WeatherService{
    private final Repository<beforeForecast, Integer> weatherRepository;
    public WeatherServiceImpl(Repository<beforeForecast, Integer> weatherRepository){
        this.weatherRepository = weatherRepository;

    }



    @Override
    public float getByCityTemperature(String city) {
        var weather = this.weatherRepository
                .findAll()
                .stream()
                .filter(e -> e.getCityName().equals(city))
                .findFirst()
                .orElseThrow(() -> new RuntimeException(city + " is not supported"));

        return weather.getTemperature();
    }

    @Override
    public float getByZipCodeTemperature(String zipCode) {
        var weather = this.weatherRepository
                .findAll()
                .stream()
                .filter(e -> e.getZipCode().equals(zipCode))
                .findFirst()
                .orElseThrow(() -> new RuntimeException(zipCode + " is not supported"));

        return weather.getTemperature();
    }

    @Override
    public List<beforeForecast> getAllForecasts() {
        return this.weatherRepository.findAll();
    }

    @Override
    public beforeForecast newForecast(beforeForecast newForecastBefore) {
        beforeForecast.validate(newForecastBefore);
        var current = this.weatherRepository.findById(newForecastBefore.getId());
        if (current.isPresent()) {
            throw new RuntimeException("El weather ID ya existe en la base de datos");
        }

        return this.weatherRepository.save(newForecastBefore);
    }
    @Override
    public beforeForecast updateForecast(beforeForecast forecastAnterior) {
        beforeForecast.validate(forecastAnterior);
        if (forecastAnterior.getId() < 1) {
            throw new RuntimeException("Invalid forecast Id " + forecastAnterior.getId());
        }
        var current = this.weatherRepository.findById(forecastAnterior.getId());
        if (current.isEmpty()) {
            throw new RuntimeException("El forecast ID no existe en la base de datos");
        }
        return this.weatherRepository.update(forecastAnterior);
    }

    @Override
    public void removeForecast(int forecastId) {
        var current = this.weatherRepository.findById(forecastId);
        if (current.isEmpty()) {
            throw new RuntimeException("El forecast ID no existe en la base de datos");
        }
        this.weatherRepository.delete(forecastId);
    }
}
