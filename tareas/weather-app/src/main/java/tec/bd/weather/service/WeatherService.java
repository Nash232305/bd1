package tec.bd.weather.service;

public interface WeatherService {

    float getCityTemperature(String city);
    float getZipCodeTemperature(String zipCode);
}