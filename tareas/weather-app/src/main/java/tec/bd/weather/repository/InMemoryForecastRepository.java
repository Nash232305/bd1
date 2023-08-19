package tec.bd.weather.repository;

import java.util.ArrayList;
import java.util.HashSet;
import tec.bd.weather.entity.Forecast;

import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.Set;


public class InMemoryForecastRepository implements Repository<Forecast, Integer>{
    
    private Set<Forecast> inMemoryWeatherData;
    
    
    public InMemoryForecastRepository(){
        //Inicializando la base de datos
        this.inMemoryWeatherData = new HashSet<>();
        
        this.inMemoryWeatherData.add(new Forecast(1,"Costa Rica","Alajuela","10101",23.0f));
        this.inMemoryWeatherData.add(new Forecast(2,"Costa Rica","Cartago","20201",24.0f));
        this.inMemoryWeatherData.add(new Forecast(3,"Costa Rica","San Jose","30301",25.0f));
        this.inMemoryWeatherData.add(new Forecast(4,"Costa Rica","Limon","40401",26.0f));
    }
    

    @Override
    public Optional <Forecast> findById(Integer id) {
        return this.inMemoryWeatherData
            .stream()
            .filter(e -> Objects.equals(e.getId(), id))
            .findFirst();
    }
     

    @Override
    public List<Forecast> findAll() {
        return new ArrayList<>(this.inMemoryWeatherData);
    }

    @Override
    public void save(Forecast weather) {
        this.inMemoryWeatherData.add(weather);
    }

    @Override
    public void delete(Integer id) {
        var weatherToDelete = this.findById(id);
        this.inMemoryWeatherData.remove(weatherToDelete.get());
    
    }

    @Override
    public Forecast update(Forecast source) {
        var current = this.findById(source.getId()).get();
       
        current.setCityName(source.getCityName());
        current.setZipCode(source.getZipCode());
        current.setTemperature(source.getTemperature());
        
        this.delete(current.getId());
        this.save(current);
        
        return current;
    }

   

}