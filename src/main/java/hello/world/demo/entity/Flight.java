package hello.world.demo.entity;

import javax.persistence.*;

@Entity
@Table(name = "flights")
public class Flight {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idflights")
    private int idflights;

    @Column(name = "flight_num")
    private String flightNum;

    @Column(name = "selected")
    private boolean selected;

    @Column(name = "from_city")
    private String from;

    @Column(name = "to_city")
    private String to;

    @Column(name = "start_time")
    private String start;

    @Column(name = "end_time")
    private String end;

    @Column(name = "gate_nr")
    private String gate;

    @Column(name = "air_line")
    private String airLine;

    @Column(name = "airplane_type")
    private String airplaneType;

    @Column(name = "terminal")
    private int terminal;

    @Column(name = "seat")
    private int seat;

    @Column(name = "delay")
    private boolean delayed;

    @Column(name = "trip_name")
    private String trip;

    @Column(name = "llt")
    private float fromLng;

    @Column(name = "bbt")
    private float fromLat;

    @Column(name = "dllt")
    private float toLng;

    @Column(name = "dbbt")
    private float toLat;

    public Flight() {
    }

    public Flight(int idflights, String flightNum, boolean selected, String from, String to, String start, String end, String gate, String airLine, String airplaneType, int terminal, int seat, boolean delayed, String trip, float fromLng, float fromLat, float toLng, float toLat) {
        this.idflights = idflights;
        this.flightNum = flightNum;
        this.selected = selected;
        this.from = from;
        this.to = to;
        this.start = start;
        this.end = end;
        this.gate = gate;
        this.airLine = airLine;
        this.airplaneType = airplaneType;
        this.terminal = terminal;
        this.seat = seat;
        this.delayed = delayed;
        this.trip = trip;
        this.fromLng = fromLng;
        this.fromLat = fromLat;
        this.toLng = toLng;
        this.toLat = toLat;
    }

    public Flight(String flightNum, boolean selected, String from, String to, String start, String end, String gate, String airLine, String airplaneType, int terminal, int seat, boolean delayed, String trip, float fromLng, float fromLat, float toLng, float toLat) {
        this.flightNum = flightNum;
        this.selected = selected;
        this.from = from;
        this.to = to;
        this.start = start;
        this.end = end;
        this.gate = gate;
        this.airLine = airLine;
        this.airplaneType = airplaneType;
        this.terminal = terminal;
        this.seat = seat;
        this.delayed = delayed;
        this.trip = trip;
        this.fromLng = fromLng;
        this.fromLat = fromLat;
        this.toLng = toLng;
        this.toLat = toLat;
    }

    public int getIdflights() {
        return idflights;
    }

    public void setIdflights(int idflights) {
        this.idflights = idflights;
    }

    public String getFlightNum() {
        return flightNum;
    }

    public void setFlightNum(String flightNum) {
        this.flightNum = flightNum;
    }

    public boolean isSelected() {
        return selected;
    }

    public void setSelected(boolean selected) {
        this.selected = selected;
    }

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getTo() {
        return to;
    }

    public void setTo(String to) {
        this.to = to;
    }

    public String getStart() {
        return start;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public String getEnd() {
        return end;
    }

    public void setEnd(String end) {
        this.end = end;
    }

    public String getGate() {
        return gate;
    }

    public void setGate(String gate) {
        this.gate = gate;
    }

    public String getAirLine() {
        return airLine;
    }

    public void setAirLine(String airLine) {
        this.airLine = airLine;
    }

    public String getAirplaneType() {
        return airplaneType;
    }

    public void setAirplaneType(String airplaneType) {
        this.airplaneType = airplaneType;
    }

    public int getTerminal() {
        return terminal;
    }

    public void setTerminal(int terminal) {
        this.terminal = terminal;
    }

    public int getSeat() {
        return seat;
    }

    public void setSeat(int seat) {
        this.seat = seat;
    }

    public boolean isDelayed() {
        return delayed;
    }

    public void setDelayed(boolean delayed) {
        this.delayed = delayed;
    }

    public String getTrip() {
        return trip;
    }

    public void setTrip(String trip) {
        this.trip = trip;
    }

    public float getFromLng() {
        return fromLng;
    }

    public void setFromLng(float fromLng) {
        this.fromLng = fromLng;
    }

    public float getFromLat() {
        return fromLat;
    }

    public void setFromLat(float fromLat) {
        this.fromLat = fromLat;
    }

    public float getToLng() {
        return toLng;
    }

    public void setToLng(float toLng) {
        this.toLng = toLng;
    }

    public float getToLat() {
        return toLat;
    }

    public void setToLat(float toLat) {
        this.toLat = toLat;
    }
}
