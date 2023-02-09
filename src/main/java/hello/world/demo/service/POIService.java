package hello.world.demo.service;

import hello.world.demo.entity.Flight;
import hello.world.demo.entity.POI;

import java.util.List;

public interface POIService {

    public List<POI> getAllPOIs();

    public POI getPOIById(int idPois);

    public POI addPOI(POI poi);

    public POI deleteFlight(int idpois) throws Exception;
}
