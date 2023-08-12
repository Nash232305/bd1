
package weather;

import java.util.HashMap;
import java.util.Map;
import static java.util.Optional.*;

/**
 *
 * @author henge
 */
public  class WeatherServicelmpl implements WeatheService {

    private Map<String, Float> cityTemperatureData;
    private Map<String, Float> zipTemperatureData;
    
    public WeatherServicelmpl(){
        this.cityTemperatureData = new HashMap (){
                { put ("Alajuela",23.0f);}
                { put ("San Jose",24.0f);}
                { put ("Heredia",25.0f);}
                { put ("Cartago",26.0f);}
                { put ("Limon",27.0f);}
                { put ("Punteranas",28.0f);}
                { put ("Guanacaste",29.0f);}
        };
        
        this.zipTemperatureData = new HashMap (){
                { put ("90210",23.0f);}
                { put ("33122",24.0f);}
                { put ("506",25.0f);}
        };
        
        
    }
    
   
    public float getCityTemperature(String city) {
        var temperature = ofNullable(this.cityTemperatureData.get(city));
        return temperature.orElseThrow();
    }

    
    public float getZipCodeTemperature(String zipCode) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

   
    
}
