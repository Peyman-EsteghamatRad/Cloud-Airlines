package hello.world.demo.controller;

import hello.world.demo.entity.Flight;
import hello.world.demo.entity.POI;
import hello.world.demo.service.POIService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(maxAge = 3600)
@RestController
@RequestMapping("/poi")
public class POIController {

    @Autowired
    POIService poiService;

    @GetMapping("/allPOIs")
    public ResponseEntity<List<POI>> getAllFlights() {
        List<POI> pois = null;
        try {
            pois = poiService.getAllPOIs();
        } catch (Exception ex) {
            ex.getMessage();
            ResponseEntity.noContent().build();
        }

        return new ResponseEntity<List<POI>>(pois, HttpStatus.OK);
    }

    @PostMapping("/add")
    public ResponseEntity<POI> update(@RequestBody POI poi) {
        POI poi1 = poi;
        try {
            poiService.addPOI(poi1);
        } catch (Exception ex) {
            ex.getMessage();
        }

        return new ResponseEntity<POI>(poi1, HttpStatus.OK);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<POI> delete(@PathVariable("id") int idpoi) {
        POI poi = null;
        try {
            poi = poiService.deleteFlight(idpoi);
        } catch (Exception ex) {
            ex.getMessage();
        }

        return new ResponseEntity<POI>(poi, HttpStatus.OK);
    }
}
