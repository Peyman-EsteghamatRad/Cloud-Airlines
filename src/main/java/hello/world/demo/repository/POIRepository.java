package hello.world.demo.repository;

import hello.world.demo.entity.POI;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface POIRepository extends CrudRepository<POI, Integer> {
}
