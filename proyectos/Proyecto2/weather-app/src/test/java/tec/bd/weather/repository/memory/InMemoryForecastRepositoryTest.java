package tec.bd.weather.repository.memory;

import org.junit.jupiter.api.Test;
import tec.bd.weather.repository.memory.InMemoryForecastBeforeRepository;

import static org.assertj.core.api.Assertions.*;

public class InMemoryForecastRepositoryTest{

    private InMemoryForecastBeforeRepository repository;

    @Test
    public void givenInMemoryCollection_whenGetCurrentMaxId_thenReturnMaxId() {
        // Arrange
        this.repository = new InMemoryForecastBeforeRepository();

        // Act
        var actual = this.repository.getCurrentMaxId();

        // Assert
        assertThat(actual).isEqualTo(4);
    }
}
