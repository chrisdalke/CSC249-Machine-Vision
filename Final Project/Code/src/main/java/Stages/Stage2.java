////////////////////////////////////////////////
// CSC 249 Final Project
// Chris Dalke & Nate Conroy
////////////////////////////////////////////////
// Module: Stage 2
// Builds facial image database
////////////////////////////////////////////////

package Stages;

////////////////////////////////////////////////
// Module Imports
////////////////////////////////////////////////

import Model.Location.Location;
import Model.Location.LocationCollection;
import Model.Photo.PhotoCollection;
import com.flickr4java.flickr.Flickr;
import com.flickr4java.flickr.FlickrException;
import com.flickr4java.flickr.REST;
import com.flickr4java.flickr.photos.Photo;
import com.flickr4java.flickr.photos.PhotoList;
import com.flickr4java.flickr.photos.SearchParameters;
import java.util.ArrayList;
import java.util.Collections;
import static com.flickr4java.flickr.photos.SearchParameters.INTERESTINGNESS_DESC;

////////////////////////////////////////////////
// Stage 2
////////////////////////////////////////////////

public class Stage2 {

    private static final int FACES_THRESHOLD = 100;

    private static String FLICKR_API_KEY = "5a8a08370055d834ac121f240e51a1bc";
    private static String FLICKR_API_SECRET = "ac7137ba77c9eaa8";

    public static void main(String[] args) throws InterruptedException{

        //Step 1: Load the city collection from our collected CSV file.
        LocationCollection.loadLocations();
        LocationCollection.sortByNumFaces();
        ArrayList<Location> locations = LocationCollection.getLocations();
        Collections.shuffle(locations);

        // load photo collection
        PhotoCollection.loadFromFile();

        //Initialize flickr
        Flickr f = new Flickr(FLICKR_API_KEY, FLICKR_API_SECRET, new REST());

        int cityBackupCounter = 0;
        for (Location city : locations){
            int batchCount = 0;
            while(city.getNumFaces() < FACES_THRESHOLD) {

                //System.out.println("== IMAGES FROM CITY: " + city.getCityName() + "===");

                //Step 2: For each city, poll Flickr to retrieve geotagged photos. Convert this into image class and keep metadata.
                SearchParameters searchParameters = new SearchParameters();
                String[] tags = {"people"};
                searchParameters.setTags(tags);
                searchParameters.setAccuracy(1);
                searchParameters.setHasGeo(true);
                searchParameters.setRadius(30);
                searchParameters.setSort(INTERESTINGNESS_DESC);
                searchParameters.setLatitude(Float.toString(city.getLatitude()));
                searchParameters.setLongitude(Float.toString(city.getLongitude()));

                PhotoList<Photo> tempList;
                try {
                    tempList = f.getPhotosInterface().search(searchParameters, 10, batchCount);
                } catch (FlickrException e) {
                    tempList = new PhotoList<>();
                }

                if (tempList.size() == 0){
                    //There are no photos left in this city!!
                    System.out.println("No photos left for city!");
                    break;
                }

                int i = 1;
                boolean usedPhoto = false;
                for (Photo photo : tempList) {

                    Model.Photo.Photo tempPhoto = new Model.Photo.Photo(photo.getMediumUrl(), city);

                    if (!PhotoCollection.hasPhoto(tempPhoto)) {
                        usedPhoto = true;

                        PhotoCollection.addPhoto(tempPhoto);

                        // call emotion API
                        if (tempPhoto.getFaces() == null || tempPhoto.getFaces().size() == 0) {
                            System.out.print(city.getCityName()+ " - Batch #" + batchCount + " (" + i + "/" + tempList.size() + ") Building face instances...");
                            tempPhoto.buildFaceInstances();
                            System.out.print(" found " + tempPhoto.getFaces().size() + " faces. ");

                            if (tempPhoto.getFaces().size() > 0){
                                System.out.print("["+photo.getMediumUrl()+"]");
                            }
                            System.out.println("Done.");
                        }
                    }
                    i++;
                }

                System.out.println(city.getCityName()+ " - Num faces: "+city.getNumFaces()+"/100");

                //Autosave the data at the end of each batch if we've added a photo
                if (usedPhoto) {
                    System.out.println("Saving photos to database...");
                    PhotoCollection.saveToFile();
                }

                batchCount++;
            }

            System.out.println(city.getCityName()+ " FINISHED - Num faces: "+city.getNumFaces()+"/100");

            //Once we have collected all photos for this city, autosave the data
            PhotoCollection.saveToFile();

            //Also save a backed up copy of the data
            PhotoCollection.saveCopy("photos_Backup_"+(cityBackupCounter++)+".json");
        }

        System.out.println("Done generating face database.");
        System.out.println("Total database size:");
        for (Location loc : locations){
            System.out.println(loc.getCityName()+", "+loc.getStateName()+") "+loc.getNumFaces());
        }
    }

}

////////////////////////////////////////////////
// End of File
////////////////////////////////////////////////