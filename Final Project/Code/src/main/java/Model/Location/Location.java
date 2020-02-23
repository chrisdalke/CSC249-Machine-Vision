////////////////////////////////////////////////
// CSC 249 Final Project
// Chris Dalke & Nate Conroy
////////////////////////////////////////////////
// Module: Location Object
////////////////////////////////////////////////

package Model.Location;

////////////////////////////////////////////////
// Module Imports
////////////////////////////////////////////////

import Model.Photo.Photo;
import Model.Photo.PhotoCollection;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Set;

////////////////////////////////////////////////
// Location Model
////////////////////////////////////////////////

@JsonIgnoreProperties(value = { "numFaces" })
public class Location {
    private String cityName;
    private String stateName;
    private float latitude;
    private float longitude;
    private HashMap<String, Float> emotions;
    private HashMap<String, Float> weather;

    private int numFaces;

    public int getNumFaces() {
        ArrayList<Photo> photosWithLoc = PhotoCollection.getPhotosWithLocation(this);
        numFaces = 0;
        for (Photo photo : photosWithLoc){
            numFaces += photo.getFaces().size();
        }
        return numFaces;
    }

    public Location(){
        emotions = new HashMap<>();
        weather = new HashMap<>();
    }

    public Location(String cityName, String stateName, float latitude, float longitude) {
        this();
        this.cityName = cityName;
        this.stateName = stateName;
        this.latitude = latitude;
        this.longitude = longitude;
    }

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }

    public String getStateName() {
        return stateName;
    }

    public void setStateName(String stateName) {
        this.stateName = stateName;
    }

    public float getLatitude() {
        return latitude;
    }

    public void setLatitude(float latitude) {
        this.latitude = latitude;
    }

    public float getLongitude() {
        return longitude;
    }

    public void setLongitude(float longitude) {
        this.longitude = longitude;
    }

    public HashMap<String, Float> getEmotions() {
        return emotions;
    }

    public void setEmotions(HashMap<String, Float> emotions) {
        this.emotions = emotions;
    }

    public void normalizeEmotions() {
        float sum = 0;
        // calculate sum
        Set<String> keys = emotions.keySet();
        for(String key: keys) {
            sum += emotions.get(key);
        }
        // normalize
        for(String key: keys) {
            emotions.put(key, emotions.get(key) / sum);
        }
    }

    public float getWeatherField(String fieldName) {
        if (weather.containsKey(fieldName)) {
            return weather.get(fieldName);
        } else {
            return -1;
        }
    }

    public void setWeatherField(String fieldName, float value) {
        weather.put(fieldName,value);
    }

    public HashMap<String, Float> getWeather() {
        return weather;
    }

    public void setWeather(HashMap<String, Float> weather) {
        this.weather = weather;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Location location = (Location) o;

        if (Float.compare(location.latitude, latitude) != 0) return false;
        if (Float.compare(location.longitude, longitude) != 0) return false;
        if (cityName != null ? !cityName.equals(location.cityName) : location.cityName != null) return false;
        return stateName != null ? stateName.equals(location.stateName) : location.stateName == null;
    }

    @Override
    public int hashCode() {
        int result = cityName != null ? cityName.hashCode() : 0;
        result = 31 * result + (stateName != null ? stateName.hashCode() : 0);
        result = 31 * result + (latitude != +0.0f ? Float.floatToIntBits(latitude) : 0);
        result = 31 * result + (longitude != +0.0f ? Float.floatToIntBits(longitude) : 0);
        return result;
    }
}

////////////////////////////////////////////////
// End of File
////////////////////////////////////////////////