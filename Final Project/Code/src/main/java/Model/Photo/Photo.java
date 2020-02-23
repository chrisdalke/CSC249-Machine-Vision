package Model.Photo;

import Model.BoundingBox;
import Model.FaceInstance;
import Model.Location.Location;
import Model.SubscriptionKeyManager;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import java.io.IOException;
import java.net.URI;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class Photo {

    private String url;
    private Location location;
    private ArrayList<FaceInstance> faces;

    public Photo(){}

    public Photo(String url, Location location) {
        this.url = url;
        this.location = location;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Photo photo = (Photo) o;

        return url != null ? url.equals(photo.url) : photo.url == null;
    }

    @Override
    public int hashCode() {
        return url != null ? url.hashCode() : 0;
    }

    public void buildFaceInstances(){

        faces = new ArrayList<>();

        String subscriptionKey = SubscriptionKeyManager.getKey();

        HttpClient httpclient = HttpClients.createDefault();

        try
        {
            URIBuilder builder = new URIBuilder("https://westus.api.cognitive.microsoft.com/emotion/v1.0/recognize");


            URI uri = builder.build();
            HttpPost request = new HttpPost(uri);
            request.setHeader("Content-Type", "application/json");
            request.setHeader("Ocp-Apim-Subscription-Key", subscriptionKey);

            // Request body
            StringEntity reqEntity = new StringEntity("{ \"url\": \"" + url +"\" }");
            request.setEntity(reqEntity);

            HttpResponse response = httpclient.execute(request);
            HttpEntity entity = response.getEntity();

            String stringObj = EntityUtils.toString(entity);
            //System.out.println(stringObj);

            if (entity != null)
            {
                parseJSON(stringObj);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
            System.out.println("There was a problem, the program will now quit.");
            System.exit(0);
        }
    }

    public void parseJSON(String jsonString) throws IOException {

        //create ObjectMapper instance
        ObjectMapper objectMapper = new ObjectMapper();

        try {
            //read JSON like DOM Parser
            JsonNode rootNode = objectMapper.readTree(jsonString);
            Iterator<JsonNode> faceElements = rootNode.elements();

            // loop through every face rectangle
            while(faceElements.hasNext()) {
                JsonNode face = faceElements.next();

                // get face rectangle coordinates
                JsonNode faceRectangleNode = face.path("faceRectangle");
                Iterator<JsonNode> faceRectangleElements = faceRectangleNode.elements();

                // get height, left, top, and width of bounding box
                JsonNode heightNode = faceRectangleElements.next();
                int height = heightNode.asInt();
                JsonNode leftNode = faceRectangleElements.next();
                int left = leftNode.asInt();
                JsonNode topNode = faceRectangleElements.next();
                int top = topNode.asInt();
                JsonNode widthNode = faceRectangleElements.next();
                int width = widthNode.asInt();

                // create BoundingBox
                BoundingBox boundingBox = new BoundingBox(height, left, top, width);
                // create HashMap
                HashMap<String, Float> emotions = new HashMap<>();

                // iterate through scores and add keys and values to map
                JsonNode scoresNode = face.path("scores");
                Iterator<Map.Entry<String, JsonNode>> scoreEntries = scoresNode.fields();
                while (scoreEntries.hasNext()) {
                    Map.Entry<String, JsonNode> entry = scoreEntries.next();
                    emotions.put(entry.getKey(), Float.valueOf(entry.getValue().toString()));
                }

                // add FaceInstance to faces ArrayList
                faces.add(new FaceInstance(boundingBox, emotions));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Location getLocation() {
        return location;
    }

    public void setLocation(Location location) {
        this.location = location;
    }

    public ArrayList<FaceInstance> getFaces() {
        return faces;
    }

    public void setFaces(ArrayList<FaceInstance> faces) {
        this.faces = faces;
    }

    public static void main(String[] args){

        Location location = new Location();
        location.setCityName("Rochester");
        location.setStateName("NY");
        location.setLatitude(0);
        location.setLongitude(0);

        Photo photo = new Photo();
        photo.setUrl("http://weknowyourdreams.com/images/people/people-06.jpg");
        photo.setLocation(location);
        photo.buildFaceInstances();
    }
}
