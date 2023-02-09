package hello.world.demo.service.impl;

import hello.world.demo.entity.Flight;
import hello.world.demo.entity.POI;
import hello.world.demo.repository.POIRepository;
import hello.world.demo.service.POIService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class POIServiceImpl implements POIService {

    @Autowired
    private POIRepository poiRepository;

    @Override
    public List<POI> getAllPOIs() {
        return (List<POI>) poiRepository.findAll();
    }

    @Override
    public POI getPOIById(int idPOI) {
        return poiRepository.findById(idPOI).orElse(null);
    }

    @Override
    public POI addPOI(POI poi) {
        return poiRepository.save(poi);
    }

    @Override
    public POI deleteFlight(int idPoi) throws Exception {
        POI deletedPOI = null;
        try {
            deletedPOI = poiRepository.findById(idPoi).orElse(null);
            if (deletedPOI == null) {
                throw new Exception("POI not available");
            } else {
                poiRepository.deleteById(idPoi);
            }
        } catch (Exception ex) {
            throw ex;
        }
        return deletedPOI;
    }
}
