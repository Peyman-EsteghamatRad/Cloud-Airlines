package hello.world.demo.entity;

public enum Airline {
    LUFTHANSA, TURKISH_AIRLINES, EUROWINGS, PEGASUS_AIRLINES, CORENDON_AIRLINES, EASY_JET, EMIRATES, KLM, AIRFORCE, AMERICAN_AIRLINES;

    @Override
    public String toString() {
        return switch(this) {
            case LUFTHANSA -> "Lufthansa";
            case TURKISH_AIRLINES -> "Turkish Airlines";
            case EUROWINGS -> "Eurowings";
            case PEGASUS_AIRLINES -> "Pegasus Airlines";
            case CORENDON_AIRLINES -> "Corendon Airlines";
            case EASY_JET -> "Easy Jet";
            case EMIRATES -> "Emirates";
            case KLM -> "KLM";
            case AIRFORCE -> "Airforce";
            case AMERICAN_AIRLINES -> "American Airlines";
        };
    }
}
