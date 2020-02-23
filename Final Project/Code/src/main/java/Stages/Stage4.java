////////////////////////////////////////////////
// CSC 249 Final Project
// Chris Dalke & Nate Conroy
////////////////////////////////////////////////
// Module: Stage 4
// Calculate emotion values for location db
////////////////////////////////////////////////

package Stages;

////////////////////////////////////////////////
// Module Imports
////////////////////////////////////////////////

import Model.FaceInstance;
import Model.Location.Location;
import Model.Location.LocationCollection;
import Model.Photo.Photo;
import Model.Photo.PhotoCollection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Set;

////////////////////////////////////////////////
// Stage 4
////////////////////////////////////////////////

public class Stage4 {
    public static void main(String[] args){

        LocationCollection.loadLocations();
        PhotoCollection.loadFromFile("photosTrimmedJson.json");

        ArrayList<Photo> allPhotos = PhotoCollection.getPhotos();
        ArrayList<Location> allLocations = LocationCollection.getLocations();

        for(Photo photo: allPhotos) {
            for (Location location : allLocations) {
                // if the location matches that found in the photo
                if(photo.getLocation().equals(location)) {

                    if(location.getEmotions() == null) {
                        location.setEmotions(new HashMap<>());
                    }

                    ArrayList<FaceInstance> faceInstances = photo.getFaces();
                    for(FaceInstance face : faceInstances) {

                        HashMap<String, Float> emotions = face.getEmotions();
                        for(int i=0; i < emotions.size(); i++) {
                            // get set of keys (emotion names)
                            Set<String> keys = emotions.keySet();

                            for(String key : keys) {
                                float value = emotions.get(key);
                                // if key already exists in location HashMap, update its value
                                if(location.getEmotions().containsKey(key)) {
                                    location.getEmotions().put(key, location.getEmotions().get(key) + value);
                                }
                                else {
                                    location.getEmotions().put(key, value);
                                }
                            }
                        }
                    }
                    // move on to next photo
                    break;
                }
            }
        }

        for(Location location: allLocations) {
            System.out.println(location.getCityName()+", "+location.getStateName()+") "+location.getNumFaces() + " faces.");

            if(location.getEmotions() != null) {
                location.normalizeEmotions();
            }
        }

        LocationCollection.saveLocations();
    }
}

////////////////////////////////////////////////
// End of File
////////////////////////////////////////////////