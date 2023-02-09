package hello.world.demo.controller;


import hello.world.demo.entity.AirplaneType;
import hello.world.demo.entity.Flight;
import hello.world.demo.entity.FlightGenerator;
import hello.world.demo.service.FlightService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(maxAge = 3600)
@RestController
@RequestMapping("/flights")
public class FlightController {

    @Autowired
    private FlightService flightService;

    @GetMapping("/allFlights")
    public ResponseEntity<List<Flight>> getAllFlights() {
        List<Flight> flights = null;
        try {
            flights = flightService.getAllFlights();
        } catch (Exception ex) {
            ex.getMessage();
            ResponseEntity.noContent().build();
        }

        return new ResponseEntity<List<Flight>>(flights, HttpStatus.OK);
    }

    @GetMapping("/selected")
    public ResponseEntity<List<Flight>> getSelected() {
        List<Flight> flights = null;
        try {
            flights = flightService.getAllFlights();
            flights.removeIf(x -> !x.isSelected());
        } catch (Exception ex) {
            ex.getMessage();
            ResponseEntity.noContent().build();
        }

        return new ResponseEntity<List<Flight>>(flights, HttpStatus.OK);
    }

    @GetMapping("/getById/{id}")
    public ResponseEntity<Flight> getUsersbyId(@PathVariable("id") int idflight) {
        Flight flight = null;
        try {
            flight = flightService.getFlightById(idflight);
        } catch (Exception ex) {
            ex.getMessage();
        }

        return new ResponseEntity<Flight>(flight, HttpStatus.OK);
    }

    @PostMapping("/createFiftyFlights")
    public ResponseEntity<Flight> create(@RequestBody Flight flight) {
        Flight flight1 = null;
        try {
            for (int i = 0; i < 50; i++) {
                Flight dummy = FlightGenerator.generateFlight();
                flight1 = flightService.addOrUpdateFlight(dummy);
            }
        } catch (Exception ex) {
            ex.getMessage();
        }

        return new ResponseEntity<Flight>(flight1, HttpStatus.OK);
    }

    @PostMapping("/update")
    public ResponseEntity<Flight> update(@RequestBody Flight flight) {
        Flight flight1 = flight;
        try {
            flightService.addOrUpdateFlight(flight1);
        } catch (Exception ex) {
            ex.getMessage();
        }

        return new ResponseEntity<Flight>(flight1, HttpStatus.OK);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<Flight> delete(@PathVariable("id") int idflight) {
        Flight flight = null;
        try {
            flight = flightService.deleteFlight(idflight);
        } catch (Exception ex) {
            ex.getMessage();
        }

        return new ResponseEntity<Flight>(flight, HttpStatus.OK);
    }


}
