////////////////////////////////////////////////
// CSC 249 Final Project
// Chris Dalke & Nate Conroy
////////////////////////////////////////////////
// Module: Face Instance Model
////////////////////////////////////////////////

package Model;

////////////////////////////////////////////////
// Module Imports
////////////////////////////////////////////////

import java.util.HashMap;

////////////////////////////////////////////////
// Face Instance Model
////////////////////////////////////////////////

public class FaceInstance {

    private BoundingBox boundingBox;
    private HashMap<String, Float> emotions;

    public FaceInstance(){}

    public FaceInstance(BoundingBox boundingBox, HashMap<String, Float> emotions) {
        this.boundingBox = boundingBox;
        this.emotions = emotions;
    }

    public BoundingBox getBoundingBox() {
        return boundingBox;
    }

    public void setBoundingBox(BoundingBox boundingBox) {
        this.boundingBox = boundingBox;
    }

    public HashMap<String, Float> getEmotions() {
        return emotions;
    }

    public void setEmotions(HashMap<String, Float> emotions) {
        this.emotions = emotions;
    }
}

////////////////////////////////////////////////
// End of File
////////////////////////////////////////////////
