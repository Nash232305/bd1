package tec.bd.weather.repository.service;

import tec.bd.weather.entity.Country;
import tec.bd.weather.entity.State;
import tec.bd.weather.repository.Repository;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

public class CountryServiceImpl implements CountryService{

    private Repository<Country, Integer> countryRepository;
    private StateService stateRepository;


    public CountryServiceImpl(Repository<Country, Integer> countryRepository) {
        this.countryRepository = countryRepository;


    }
    public void initService(StateService stateRepository){
        this.stateRepository = stateRepository;
    }

    @Override
    public List<Country> getAllCountries() {
        return this.countryRepository.findAll();

    }

    @Override
    public Optional<Country> getCountryById(int countryId) {
        return this.countryRepository.findById(countryId);
    }

    @Override
    public Country newCountry(String countryName) {
        for (Country country : this.getAllCountries()) {
            if (Objects.equals(countryName, country.getCountryName())){
                throw new RuntimeException("El país ya existe en la base de datos");
            }

        }

        var countryToBeSave = new Country(null,countryName);
        var newCountry = (this.countryRepository.save(countryToBeSave));
        return newCountry;
    }

    @Override
    public void removeByCountryId(int countryId){
        for (State state : this.stateRepository.getAllStates()) {
            if (state.getCountry_id() == countryId){
                throw new RuntimeException("have states");
            }

        }

        if (countryId <= 0) {
            throw new RuntimeException("El id no puede ser menor a 0");
        }
        var countryFromDBOpt = this.getCountryById(countryId);

        if (countryFromDBOpt.isEmpty()) {
            throw new RuntimeException("Country Id: " + countryId + " no encontrada");
        }

        this.countryRepository.delete(countryId);
    }

    @Override
    public Country updateCountry(Country country) {

        var countryUpdated = this.countryRepository.update(country);
        return countryUpdated;
    }
}
