////////////////////////////////////////////////
// CSC 249 Final Project
// Chris Dalke & Nate Conroy
////////////////////////////////////////////////
// Module: Stage 3
// Trims photos that don't contain faces
// from the photo database
////////////////////////////////////////////////

package Stages;

////////////////////////////////////////////////
// Module Imports
////////////////////////////////////////////////

import Model.Photo.Photo;
import Model.Photo.PhotoCollection;
import java.util.ArrayList;

////////////////////////////////////////////////
// Stage 3
////////////////////////////////////////////////

public class Stage3 {

    public static void main(String[] args) throws InterruptedException{

        //Trim out all the photos that don't have faces

        PhotoCollection.loadFromFile();
        ArrayList<Photo> photos = new ArrayList<>();
        photos.addAll(PhotoCollection.getPhotos());
        int numFaces = 0;
        for(Photo photo : photos) {
            if (photo.getFaces() == null | photo.getFaces().size() == 0) {
                PhotoCollection.removePhoto(photo);
            } else {
                numFaces += photo.getFaces().size();
            }
        }

        System.out.println("Num photos: "+PhotoCollection.getPhotos().size());
        System.out.println("Num faces: "+numFaces);

        PhotoCollection.saveCopy("photosTrimmedJson.json");
    }
}

////////////////////////////////////////////////
// End of File
////////////////////////////////////////////////
