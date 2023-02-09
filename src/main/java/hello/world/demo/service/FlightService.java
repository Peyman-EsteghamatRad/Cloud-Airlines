package hello.world.demo.service;

import hello.world.demo.entity.Flight;

import java.util.List;

public interface FlightService {

    public List<Flight> getAllFlights();

    public Flight getFlightById(int idflights);

    public Flight addOrUpdateFlight(Flight flight);

    public Flight deleteFlight(int idflights) throws Exception;
}
