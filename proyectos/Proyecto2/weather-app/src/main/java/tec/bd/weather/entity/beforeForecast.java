package tec.bd.weather.entity;

import java.util.Date;

public class beforeForecast {
    private Integer id;
    private float temperature;

    private Date forecastDate;
    private String cityName;

    private String zipCode;
    private String countryName;

    public beforeForecast() { }
    public beforeForecast(Integer id, String countryName, String cityName, String zipCode, Date forecastDate, float temperature) {
        this.id = id;
        this.temperature = temperature;
        this.cityName = cityName;
        this.zipCode = zipCode;
        this.forecastDate = forecastDate;
        this.countryName = countryName;

    }
    public beforeForecast(String countryName, String cityName, String zipCode, Date forecastDate, float temperature) {
        this(0, countryName, cityName, zipCode, forecastDate, temperature);
    }



    public float getTemperature() {
        return temperature;
    }

    public void setTemperature(float temperature) {
        this.temperature = temperature;
    }

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCountryName() {
        return countryName;
    }

    public Date getForecastDate() {
        return forecastDate;
    }

    public void setForecastDate(Date forecastDate) {
        this.forecastDate = forecastDate;
    }

    @Override
    public String toString() {
        return "Forecast {" +
                "id = " + id +
                ", temperature = " + temperature +
                ", country = '" + countryName + '\'' +
                ", city = '" + cityName + '\'' +
                ", zipCode = '" + zipCode + '\'' +
                ", date = '" + forecastDate + '\'' +
                ", temperature = " + temperature +
                '}';
    }

    public void setCountryName(String countryName) {
        this.countryName = countryName;
    }

    public static void validate(beforeForecast beforeForecasts) {
        if (beforeForecasts == null) {
            throw new RuntimeException("No weather forecast was provided");
        }
        if (beforeForecasts.getCountryName().isBlank()) {
            throw new RuntimeException("Weather forecast country invalid");
        }
        if (beforeForecasts.getCityName().isBlank()) {
            throw new RuntimeException("Weather forecast city invalid");
        }
        if (beforeForecasts.getZipCode().isBlank()) {
            throw new RuntimeException("Weather forecast zip code invalid");
        }
        if (beforeForecasts.getTemperature() < 0) {
            throw new RuntimeException("Weather forecast temperature invalid");
        }
    }


}
