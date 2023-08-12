/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package weather;

/**
 *
 * @author henge
 */
public interface WeatheService {
    float getCityTemperature(String city);
    float getZipCodeTemperature(String zipCode);
    
}
