package tec.bd.weather.repository.sql;

import tec.bd.weather.entity.beforeForecast;
import tec.bd.weather.repository.Repository;

import javax.sql.DataSource;
import java.sql.*;
import java.util.*;
import java.util.Date;

public class ForecastBeforeRepository implements Repository<beforeForecast, Integer>  {

    private final DataSource dataSource;

    public ForecastBeforeRepository(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    public Optional<beforeForecast> findById(Integer forecastID) {

        try (Connection connection = this.dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(Queries.FIND_FORECAST_BY_ID)) {
            stmt.setString(1, String.valueOf(forecastID));
            var rs =stmt.executeQuery();

            // loop through the result set
            while (rs.next()) {
                var forecast = this.fromResultSet(rs);
                return Optional.of(forecast);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Failed to retrieve forecast", e);
        }
        return Optional.empty();

    }

    @Override
    public List< beforeForecast> findAll() {


        List<beforeForecast> allForecastBefores = new ArrayList<>();
        try (Connection connection = this.dataSource.getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(Queries.FIND_ALL_FORECAST)) {

            while (rs.next()) {
                var forecast = this.fromResultSet(rs);
                allForecastBefores.add(forecast);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Failed to retrieve forecasts", e);
        }

        return allForecastBefores;
    }

    @Override
    public beforeForecast save(beforeForecast forecastBeforess) {
        try (Connection connection = this.dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(Queries.INSERT_NEW_FORECAST, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, forecastBeforess.getCountryName());
            stmt.setString(2, forecastBeforess.getCityName());
            stmt.setString(3, forecastBeforess.getZipCode());
            stmt.setDate(4, new java.sql.Date(forecastBeforess.getForecastDate().getTime()));
            stmt.setFloat(5, forecastBeforess.getTemperature());
            stmt.executeUpdate();

            ResultSet generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                forecastBeforess.setId(generatedKeys.getInt(1));
            }
            return forecastBeforess;
        } catch (SQLException e) {
            throw new RuntimeException("Failed to save forecast", e);
        }
    }

    @Override
    public void delete(Integer forecastiId) {
        try (Connection connection = this.dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(Queries.DELETE_FORECAST_BY_ID)) {

            stmt.setInt(1, forecastiId);
            stmt.executeUpdate();


            ResultSet generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) {
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to delete forecast", e);
        }
    }

    @Override
    public beforeForecast update(beforeForecast source) {
        try (Connection connection = this.dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(Queries.UPDATE_FORECAST)) {

            stmt.setString(1, source.getCountryName());
            stmt.setString(2, source.getCityName());
            stmt.setString(3, source.getZipCode());
            stmt.setDate(4, new java.sql.Date(source.getForecastDate().getTime()));
            stmt.setFloat(5, source.getTemperature());
            stmt.setInt(6, source.getId());
            int affectedRows = stmt.executeUpdate();

            ResultSet generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) {
            }
            return source;
        } catch (SQLException e) {
            throw new RuntimeException("Failed to save forecast", e);
        }
    }

    private beforeForecast fromResultSet(ResultSet rs) throws SQLException {
        var forecastDate = rs.getDate("forecast_date");
        return new beforeForecast(
                rs.getInt("forecast_id"),
                rs.getString("country_name"),
                rs.getString("city_name"),
                rs.getString("zip_code"),
                new Date(forecastDate.getTime()),
                rs.getFloat("temperature"));
    }

}