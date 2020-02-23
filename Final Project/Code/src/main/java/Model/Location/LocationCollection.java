////////////////////////////////////////////////
// CSC 249 Final Project
// Chris Dalke & Nate Conroy
////////////////////////////////////////////////
// Module: Location Object Collection
////////////////////////////////////////////////

package Model.Location;

////////////////////////////////////////////////
// Module Imports
////////////////////////////////////////////////

import Utility.CSVParser;
import Utility.LatLongParser;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

////////////////////////////////////////////////
// Location Collection
////////////////////////////////////////////////

public class LocationCollection {

    private static ArrayList<Location> locations = new ArrayList<Location>();

    private static final String FILE_LOCATIONS_RAW = "locationsRaw.csv";
    private static final String FILE_LOCATIONS_JSON = "locationsJson.json";

    public static void loadRawCities(){

        CSVParser csvParser = new CSVParser(FILE_LOCATIONS_RAW);
        locations.clear();
        for (int row = 0; row < csvParser.getNumRows(); row++){
            Location tempLocation = new Location();

            tempLocation.setCityName(csvParser.getCell(0,row).trim());
            tempLocation.setStateName(csvParser.getCell(1,row).trim());
            tempLocation.setLatitude(LatLongParser.latLongStringToFloat(csvParser.getCell(2,row)));
            tempLocation.setLongitude(LatLongParser.latLongStringToFloat(csvParser.getCell(3,row)));

            int col = 4;
            try {
                tempLocation.setWeatherField("averageTempHigh",Float.parseFloat(csvParser.getCell(col++, row).trim()));
            } catch (NumberFormatException e){
                tempLocation.setWeatherField("averageTempHigh",-1);
            }
            try {
                tempLocation.setWeatherField("averageTempMid",Float.parseFloat(csvParser.getCell(col++, row).trim()));
            } catch (NumberFormatException e){
                tempLocation.setWeatherField("averageTempMid",-1);
            }
            try {
                tempLocation.setWeatherField("averageTempLow",Float.parseFloat(csvParser.getCell(col++, row).trim()));
            } catch (NumberFormatException e){
                tempLocation.setWeatherField("averageTempLow",-1);
            }
            try {
                tempLocation.setWeatherField("rainfall",Float.parseFloat(csvParser.getCell(col++, row).trim()));
            } catch (NumberFormatException e){
                tempLocation.setWeatherField("rainfall",-1);
            }
            try {
                tempLocation.setWeatherField("snowfall",Float.parseFloat(csvParser.getCell(col++, row).trim()));
            } catch (NumberFormatException e){
                tempLocation.setWeatherField("snowfall",-1);
            }
            try {
                tempLocation.setWeatherField("daysRain",Float.parseFloat(csvParser.getCell(col++, row).trim()));
            } catch (NumberFormatException e){
                tempLocation.setWeatherField("daysRain",-1);
            }
            try {
                tempLocation.setWeatherField("hoursSunshine",Float.parseFloat(csvParser.getCell(col++, row).trim()));
            } catch (NumberFormatException e){
                tempLocation.setWeatherField("hoursSunshine",-1);
            }

            locations.add(tempLocation);
        }
    }

    public static void saveLocations(){

        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(SerializationFeature.INDENT_OUTPUT, true);
        try {
            mapper.writeValue(new File(FILE_LOCATIONS_JSON), locations);
        } catch (IOException e){
            System.out.println("Failed to save location file!");
            e.printStackTrace();
        }
    }

    public static void sortByNumFaces(){
        Collections.sort(locations, new Comparator<Location>() {
            @Override
            public int compare(Location o1, Location o2) {
                return o1.getNumFaces() - o2.getNumFaces();
            }
        });
    }

    public static void loadLocations(){
        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(SerializationFeature.INDENT_OUTPUT, true);
        try {
            List<Location> objs = mapper.readValue(new File(FILE_LOCATIONS_JSON), new TypeReference<List<Location>>(){});
            locations.clear();
            locations.addAll(objs);
            System.out.println("Loaded "+locations.size()+" location files.");
        } catch (Exception e){
            System.out.println("Failed to load location files.");
            e.printStackTrace();
        }
    }

    public static Location getLocation(int id){
        return locations.get(id);
    }

    public static ArrayList<Location> getLocations() {
        return locations;
    }

    public static int getNumLocations(){
        return locations.size();
    }
}

////////////////////////////////////////////////
// End of File
////////////////////////////////////////////////