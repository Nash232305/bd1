package tec.bd.weather.repository;

//import java.io.Serializable;
import java.util.List;
import java.util.Optional;
/**i
 *
 * @author henge
 * @param <T>
 * @param <ID>
 */
public interface Repository <T, ID >{
    
    /**
     * 
     * Find item by id
     * @param id
     * @return Item
     */
    
    //nullable
    Optional <T> findById(ID id);
    
    List <T> findAll();
    
    void save(T t);
    
    void delete(ID id);
    
    T update(T source);
    
}
