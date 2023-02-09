package hello.world.demo.entity;

import javax.persistence.*;
@Entity
@Table(name = "pois")

public class POI {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idpois")
    private int idPOI;

    @Column(name = "poi_num")
    private String pointOfIntNr;

    public POI(int idPOI, String pointOfIntNr) {
        this.idPOI = idPOI;
        this.pointOfIntNr = pointOfIntNr;
    }

    public POI(String pointOfIntNr) {
        this.pointOfIntNr = pointOfIntNr;
    }

    public POI() {

    }

    public int getIdPOI() {
        return idPOI;
    }

    public void setIdPOI(int idPOI) {
        this.idPOI = idPOI;
    }

    public String getPointOfIntNr() {
        return pointOfIntNr;
    }

    public void setPointOfIntNr(String pointOfIntNr) {
        this.pointOfIntNr = pointOfIntNr;
    }
}
