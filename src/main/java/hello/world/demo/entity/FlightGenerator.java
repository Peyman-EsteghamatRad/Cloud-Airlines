package hello.world.demo.entity;

import java.time.LocalDateTime;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class FlightGenerator {
    private static Random rand = new Random(System.currentTimeMillis());
    private static City munich = new City("Munich", 48.1371079F, 11.5753822F);
    private static City hamburg = new City("Hamburg", 53.550341F, 10.000654F);
    private static City berlin = new City("Berlin", 52.516181F, 13.376935F);
    private static City frankfurt = new City("Frankfurt", 50.1106444F, 8.6820917F);


    private static City vienna = new City("Vienna", 48.2083537F, 16.3725042F);
    private static City prague = new City("Prague", 50.0874654F, 14.4212535F);

    private static City paris = new City("Paris", 48.8588897F, 2.320041F);

    private static City marseille = new City("Marseille", 43.2961743F, 5.3699525F);
    private static City lyon = new City("Lyon", 45.7578137F, 4.8320114F);
    private static City strasbourg = new City("Strasbourg", 48.584614F, 7.7507127F);
    private static City warsaw = new City("Warsaw", 52.2319581F, 21.0067249F);
    private static City madrid = new City("Madrid", 40.4167047F, -3.7035825F);

    private static City sevilla = new City("Sevilla", 37.3886303F, -5.9953403F);
    private static City mallorca = new City("Mallorca", 39.613432F, 2.8803536F);
    private static City barcelona = new City("Barcelona", 41.3828939F, 2.1774322F);
    private static City lisbon = new City("Lisbon", 38.7077507F, -9.1365919F);
    private static City venice = new City("Venice", 45.4371908F, 12.3345898F);
    private static City florence = new City("Florence", 43.7698712F, 11.2555757F);
    private static City rome = new City("Rome", 41.8933203F, 12.4829321F);
    private static City capri = new City("Capri", 40.5487747F, 14.2280874F);

    private static City athens = new City("Athens", 37.9839412F, 23.7283052F);
    private static City istanbul = new City("Istanbul", 41.0091982F, 28.9662187F);
    private static City moscow = new City("Moscow", 55.7504461F, 37.6174943F);
    private static City kiev = new City("Kiev", 50.4500336F, 30.5241361F);
    private static City stockholm = new City("Stockholm", 59.3251172F, 18.0710935F);
    private static City newYork = new City("New York", 40.7127281F, -74.0060152F);
    private static City washington = new City("Washington DC", 38.8950368F, -77.0365427F);
    private static City chicago = new City("Chicago", 41.8755616F, -87.6244212F);
    private static City losAngeles = new City("Los Angeles", 34.0536909F, -118.242766F);
    private static City sanFrancisco = new City("San Francisco", 37.7790262F, -122.419906F);
    private static City mexCity = new City("Mexico City", 19.4326296F, -99.1331785F);
    private static City rioDeJaneiro = new City("Rio de Janeiro", -22.9110137F, -43.2093727F);
    private static City kairo = new City("Kairo", 30.0443879F, 31.2357257F);
    private static City tokyo = new City("Tokyo", 35.6828387F, 139.7594549F);
    private static City melbourne = new City("Melbourne", -37.8142176F, 144.9631608F);
    private static City tashkent = new City("Tashkent", 41.3123363F, 69.2787079F);
    private static City delhi = new City("Delhi", 28.6517178F, 77.2219388F);


    private static City london = new City("London", 51.5073219F, -0.1276474F);
    private static City manchester = new City("Manchester", 53.4794892F, -2.2451148F);
    private static List<City> CITIES = List.of(
            london, manchester, munich, berlin, hamburg, vienna, munich, prague, paris, munich,
            marseille, munich, lyon, strasbourg, warsaw, madrid, sevilla, mallorca, barcelona, lisbon, munich, venice,
            florence, rome, capri, athens, istanbul, moscow, munich, kiev, stockholm, newYork, washington, chicago, munich,
            losAngeles, sanFrancisco, mexCity, rioDeJaneiro, kairo, munich, tokyo, melbourne, tashkent,
            munich, delhi, frankfurt);

    public static List<Airline> AIRLINES = List.of(Airline.AMERICAN_AIRLINES, Airline.CORENDON_AIRLINES, Airline.AIRFORCE, Airline.PEGASUS_AIRLINES, Airline.EASY_JET, Airline.EMIRATES, Airline.EUROWINGS, Airline.KLM, Airline.LUFTHANSA, Airline.TURKISH_AIRLINES);
    public static List<AirplaneType> AIRPLANETYPE = List.of(AirplaneType.GLIDER, AirplaneType.JUMBO_JET, AirplaneType.TURBOPROP, AirplaneType.LIGHT_JET, AirplaneType.MILITARY_AIRCRAFT, AirplaneType.PRIVAT_JET, AirplaneType.REGIONAL_JET);

    /**
     * Generates a new flight, with a random starting City, a random destination, random gate,terminal,airline, airplane type,,start Time in the next weeks.
     * The arrival Time is calculated accordingly!
     * Seat is set to -1, because no seat is selected yet
     * Delayed is set to false on standard
     */
    public static Flight generateFlight() {
        City city = generateStartCity();
        City destination = generateDestinationCity(city);
        LocalDateTime startTime = generateStartTime();
        AirplaneType airplanetype = generateAirplaneType();
        LocalDateTime endTime = generateEndTime(startTime, city, destination, airplanetype);
        int cancelled = rand.nextInt(20);
        String gate = generateGate();
        int terminal = generateTerminal();
        Airline airline = generateAirline();
        String flightNumber = generateFlightNumber(airline);
        int seat = generateSeat();
        boolean delayed = generateDelayed();
        if (cancelled == 5){
            return new Flight(flightNumber,
                    false,
                    city.toString(),
                    destination.toString(),
                    "CANCELLED",
                    "CANCELLED",
                    gate,
                    airline.toString(),
                    airplanetype.toString(),
                    terminal,
                    seat,
                    true,
                    "",
                    city.getLaengengrad(),
                    city.getBreitengrad(),
                    destination.getLaengengrad(),
                    destination.getBreitengrad());
        }
        else {
            return new Flight(flightNumber,
                    false,
                    city.toString(),
                    destination.toString(),
                    startTime.toString(),
                    endTime.toString(),
                    gate,
                    airline.toString(),
                    airplanetype.toString(),
                    terminal,
                    seat,
                    delayed,
                    "",
                    city.getLaengengrad(),
                    city.getBreitengrad(),
                    destination.getLaengengrad(),
                    destination.getBreitengrad());
        }

    }

    private static AirplaneType generateAirplaneType() {
        return AIRPLANETYPE.get(rand.nextInt(AIRPLANETYPE.size() - 1));
    }

    private static City generateStartCity() {
        int cityIndex = rand.nextInt(CITIES.size() - 1);
        return CITIES.get(cityIndex);
    }
    private static boolean generateDelayed(){
        int delayed = rand.nextInt(21);
        if (delayed == 5){
            return true;
        }
        else {
            return false;
        }
    }

    private static City generateDestinationCity(City startCity) {
        int cityIndex = rand.nextInt(CITIES.size() - 1);
        if (CITIES.get(cityIndex).equals(startCity)) {
            //return CITIES.get(Math.floorMod(cityIndex + 1, CITIES.size()) - 1);
            return generateDestinationCity(startCity);
        }
        return CITIES.get(cityIndex);
    }

    private static LocalDateTime generateStartTime() {
        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        month = Math.floorMod((rand.nextInt(5) + month), 12);
        int day = now.getDayOfMonth();
        day = Math.floorMod((rand.nextInt(31) + day), YearMonth.of(year, month).lengthOfMonth());
        if (day == 0) {
            day++;
        }
        return LocalDateTime.of(
                year,
                month,
                day,
                rand.nextInt(5, 20),
                rand.nextInt(59));
    }

    private static int getDistance(City A, City B) {
        double lon1 = Math.toRadians(A.getLaengengrad());
        double lon2 = Math.toRadians(B.getLaengengrad());
        double lat1 = Math.toRadians(A.getBreitengrad());
        double lat2 = Math.toRadians(B.getBreitengrad());

        double dlon = lon2 - lon1;
        double dlat = lat2 - lat1;
        double a = Math.pow(Math.sin(dlat / 2), 2)
                + Math.cos(lat1) * Math.cos(lat2)
                * Math.pow(Math.sin(dlon / 2), 2);

        double c = 2 * Math.asin(Math.sqrt(a));
        double r = 6371;
        return (int) (c * r);
    }

    private static double calculateFlightTime(int distance, AirplaneType airplaneType) {
        return 1 + (distance / 850.0);
    }

    private static LocalDateTime generateEndTime(LocalDateTime startTime, City A, City B, AirplaneType airplaneType) {
        int year = startTime.getYear();
        int month = startTime.getMonthValue();
        int day = startTime.getDayOfMonth();
        int hour = startTime.getHour();
        int minute = rand.nextInt(59);

        double dauer = calculateFlightTime(getDistance(A, B), airplaneType);
        int deltaMinutes = (int) ((dauer - (int) dauer) * 60);

        minute += deltaMinutes;
        if (minute >= 60) {
            hour++;
            minute = Math.floorMod(minute, 60);
        }

        //Wenn der nächste Tag anbricht.
        if (hour + (int) dauer >= 24) {
            //Nächster Tag im Monat
            if (day + 1 <= YearMonth.of(year, month).lengthOfMonth()) {
                day++;
            }
            //Letzter Tag im Monat, aber nicht Dezember
            else if (day + 1 > YearMonth.of(year, month).lengthOfMonth() && month != 12) {
                day = 1;
                month++;
            }
            //31.Dezember
            else {
                day = 1;
                month++;
                year++;
            }
            hour = Math.floorMod(hour + (int) dauer, 24);
        } else {
            hour += dauer;
        }
        return LocalDateTime.of(year, month, day, hour, minute);
    }

    private static String generateGate() {
        return String.valueOf((Character.valueOf((char) (rand.nextInt(26) + 'A'))) + String.valueOf(rand.nextInt(99)));
    }

    private static int generateTerminal() {
        return rand.nextInt(5) + 1;
    }

    private static Airline generateAirline() {
        return AIRLINES.get(rand.nextInt(AIRLINES.size() - 1));
    }

    private static String generateFlightNumber(Airline airline) {
        StringBuilder aS = new StringBuilder();
        String airlineSign = "";
        switch (airline) {
            case KLM -> {
                aS.append("KL ");
                break;
            }
            case EASY_JET -> {
                aS.append("EJ ");
                break;
            }
            case LUFTHANSA -> {
                aS.append("LH ");
                break;
            }
            case TURKISH_AIRLINES -> {
                aS.append("TA ");
                break;
            }
            case EUROWINGS -> {
                aS.append("EW ");
                break;
            }
            case PEGASUS_AIRLINES -> {
                aS.append("PG ");
                break;
            }
            case CORENDON_AIRLINES -> {
                aS.append("CA ");
                break;
            }
            case EMIRATES -> {
                aS.append("EA ");
                break;
            }
            case AIRFORCE -> {
                aS.append("GOV ");
                break;
            }
            case AMERICAN_AIRLINES -> {
                aS.append("AA ");
                break;
            }
            default -> aS.append("FN ");
        }
        for (int i = 0; i < 8; i++) {
            aS.append(String.valueOf(rand.nextInt(9)));
        }

        return String.valueOf(aS);
    }

    private static int generateSeat() {
        return rand.nextInt(500);
    }


}

