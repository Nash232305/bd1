package tec.bd.weather.repository.service;

import tec.bd.weather.entity.beforeForecast;
import java.util.List;
public interface WeatherService {
    float getByCityTemperature(String city);

    float getByZipCodeTemperature(String zipCode);

    List<beforeForecast> getAllForecasts();

    beforeForecast newForecast(beforeForecast weather);

    beforeForecast updateForecast(beforeForecast weather);

    void removeForecast(int forecastId);
}