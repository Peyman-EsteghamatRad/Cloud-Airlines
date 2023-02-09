package hello.world.demo.entity;

public enum AirplaneType {
    JUMBO_JET, TURBOPROP, LIGHT_JET, REGIONAL_JET, MILITARY_AIRCRAFT, PRIVAT_JET, GLIDER;

    @Override
    public String toString() {
        return switch(this) {
            case JUMBO_JET -> "Jumbo Jet";
            case TURBOPROP -> "Turboprop";
            case LIGHT_JET -> "Light Jet";
            case REGIONAL_JET -> "Regional Jet";
            case MILITARY_AIRCRAFT -> "Military Aircraft";
            case PRIVAT_JET -> "Private Jet";
            case GLIDER -> "Glider";
        };
    }
}
