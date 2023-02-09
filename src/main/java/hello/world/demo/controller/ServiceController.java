package hello.world.demo.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(maxAge = 3600)
@RestController
@RequestMapping("/service")
public class ServiceController {

    @PostMapping("/receive")
    public ResponseEntity<String> reveive(@RequestBody String s) {
        try {
            assert (true); //This would proceed the service Information to the Servicesystem of the flight
        } catch (Exception ex) {
            ex.getMessage();
        }

        return new ResponseEntity<String>(s, HttpStatus.OK);
    }
}
