package Model.Photo;

import Model.Location.Location;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class PhotoCollection {

    private static final String FILE_PHOTOS_JSON = "photosJson.json";

    private static ArrayList<Photo> photos = new ArrayList<>();

    public static ArrayList<Photo> getPhotos(){
        return photos;
    }

    public static ArrayList<Photo> getPhotosWithLocation(Location location){
        ArrayList<Photo> tempPhotos = new ArrayList<>();

        for (Photo photo : photos){
            if (photo.getLocation().equals(location)) {
                tempPhotos.add(photo);
            }
        }

        return tempPhotos;
    }

    public static void addPhoto(Photo photo){
        if (!photos.contains(photo)) {
            photos.add(photo);
        } else {
            System.out.println("Didn't add duplicate photo to collection!");
        }
    }

    public static void removePhoto(Photo photo){
        photos.remove(photo);
    }

    public static boolean hasPhoto(Photo photo){
        return photos.contains(photo);
    }

    public static void loadFromFile(){
        loadFromFile(FILE_PHOTOS_JSON);
    }

    public static void loadFromFile(String filename){

        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(SerializationFeature.INDENT_OUTPUT, true);
        try {
            List<Photo> objs = mapper.readValue(new File(filename), new TypeReference<List<Photo>>(){});
            photos.clear();
            photos.addAll(objs);
            System.out.println("Loaded "+photos.size()+" photos from file.");
        } catch (Exception e){
            System.out.println("Failed to load photo collection file.");
            e.printStackTrace();
        }
    }

    public static void saveToFile(){
        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(SerializationFeature.INDENT_OUTPUT, true);
        try {
            mapper.writeValue(new File(FILE_PHOTOS_JSON), photos);
            System.out.println("Saved photo collection file.");
        } catch (IOException e){
            System.out.println("Failed to save photo collection file!");
            e.printStackTrace();
        }
    }

    public static void saveCopy(String copyFilename){

        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(SerializationFeature.INDENT_OUTPUT, true);
        try {
            mapper.writeValue(new File(copyFilename), photos);
            System.out.println("Saved photo collection file.");
        } catch (IOException e){
            System.out.println("Failed to save photo collection file!");
            e.printStackTrace();
        }
    }

}
