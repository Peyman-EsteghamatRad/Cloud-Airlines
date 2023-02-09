package hello.world.demo.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;

@CrossOrigin(maxAge = 3600)
@RestController
@RequestMapping("/survey")
public class SurveyController {

    @PostMapping("/receive")
    public ResponseEntity<String> reveive(@RequestBody String s) {
        try {
            File survery = new File("src/main/java/hello/world/demo/repository/surveys/surveys.txt");
            PrintWriter out = new PrintWriter(new FileWriter(survery, true));
            out.append(s + "\n");
            out.close();
        } catch (Exception ex) {
            ex.getMessage();
        }

        return new ResponseEntity<String>(s, HttpStatus.OK);
    }
}
