package tec.bd.weather.service;

import org.junit.jupiter.api.Test;
import tec.bd.weather.repository.memory.InMemoryForecastBeforeRepository;

import static org.assertj.core.api.Assertions.*;

public class InMemoryForecastBeforeRepositoryTestAnterior {

    private InMemoryForecastBeforeRepository repository;

    @Test
    public void givenInMemoryCollection_whenGetCurrentMaxId_thenReturnMaxId() {

        this.repository = new InMemoryForecastBeforeRepository();

        var actual = this.repository.getCurrentMaxId();

        assertThat(actual).isEqualTo(4);
    }
}