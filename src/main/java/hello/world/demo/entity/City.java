package hello.world.demo.entity;

import java.util.Objects;

public class City {
    private String name;
    private float breitengrad;
    private float laengengrad;


    public City(String name, float breitengrad, float laengengrad) {
        this.name = name;
        this.breitengrad = breitengrad;
        this.laengengrad = laengengrad;
    }

    @Override
    public String toString() {
        return name;
    }

    public float getLaengengrad() {
        return laengengrad;
    }

    public void setLaengengrad(int laengengrad) {
        this.laengengrad = laengengrad;
    }

    public float getBreitengrad() {
        return breitengrad;
    }

    public void setBreitengrad(int breitengrad) {
        this.breitengrad = breitengrad;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        City city = (City) o;
        return breitengrad == city.breitengrad && laengengrad == city.laengengrad && Objects.equals(name, city.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, breitengrad, laengengrad);
    }
}