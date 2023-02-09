package hello.world.demo.service.impl;

import hello.world.demo.entity.Flight;
import hello.world.demo.repository.FlightRepository;
import hello.world.demo.service.FlightService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FlightServiceImpl implements FlightService {

    @Autowired
    private FlightRepository flightRepository;

    @Override
    public List<Flight> getAllFlights() {
        return (List<Flight>) flightRepository.findAll();
    }

    @Override
    public Flight getFlightById(int idflight) {
        return flightRepository.findById(idflight).orElse(null);
    }

    @Override
    public Flight addOrUpdateFlight(Flight flight) {
        return flightRepository.save(flight);
    }

    @Override
    public Flight deleteFlight(int idflight) throws Exception {
        Flight deletedFlight = null;
        try {
            deletedFlight = flightRepository.findById(idflight).orElse(null);
            if (deletedFlight == null) {
                throw new Exception("Flight not available");
            } else {
                flightRepository.deleteById(idflight);
            }
        } catch (Exception ex) {
            throw ex;
        }
        return deletedFlight;
    }
}
