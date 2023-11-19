package tec.bd.weather.repository.memory;

import tec.bd.weather.entity.beforeForecast;
import tec.bd.weather.repository.Repository;

import java.util.*;

public class InMemoryForecastBeforeRepository implements Repository<beforeForecast, Integer> {

    private Set<beforeForecast> inMemoryForecastDatumBefores;

    public InMemoryForecastBeforeRepository() {
        // "inicializando" la base de datos
        this.inMemoryForecastDatumBefores = new HashSet<>();
        this.inMemoryForecastDatumBefores.add(new beforeForecast(1, "Costa Rica", "Alajuela", "10101", new Date(), 23.0f));
        this.inMemoryForecastDatumBefores.add(new beforeForecast(2, "Costa Rica", "Cartago", "20201", new Date(), 24.0f));
        this.inMemoryForecastDatumBefores.add(new beforeForecast(3, "Costa Rica", "San Jose", "30301", new Date(), 25.0f));
        this.inMemoryForecastDatumBefores.add(new beforeForecast(4, "Costa Rica", "Limon", "40401", new Date(), 25.0f));
    }

    public int getCurrentMaxId() {
        return this.inMemoryForecastDatumBefores
                .stream()
                .max(Comparator.comparing(beforeForecast::getId))
                .map(beforeForecast::getId)
                .orElse(0);
    }

    @Override
    public Optional<beforeForecast> findById(Integer id) {
        return this.inMemoryForecastDatumBefores
                .stream()
                .filter(e -> Objects.equals(e.getId(), id))
                .findFirst();
    }

    @Override
    public List<beforeForecast> findAll() {
        return new ArrayList<>(this.inMemoryForecastDatumBefores);
    }

    @Override
    public beforeForecast save(beforeForecast forecastBefores) {
        forecastBefores.setId(this.getCurrentMaxId() + 1);
        this.inMemoryForecastDatumBefores.add(forecastBefores);
        return forecastBefores;
    }

    @Override
    public void delete(Integer id) {
        System.out.println("En memoria");
        var weatherToDelete = this.findById(id);
        this.inMemoryForecastDatumBefores.remove(weatherToDelete.get());
    }

    @Override
    public beforeForecast update(beforeForecast source) {
        var current = this.findById(source.getId()).get();

        current.setCountryName(source.getCountryName());
        current.setCityName(source.getCityName());
        current.setZipCode(source.getZipCode());
        current.setTemperature(source.getTemperature());

        this.delete(current.getId());
        this.save(current);

        return current;
    }
}