////////////////////////////////////////////////
// CSC 249 Final Project
// Chris Dalke & Nate Conroy
////////////////////////////////////////////////
// Module: Stage 1
// Builds location database from CSV
////////////////////////////////////////////////

package Stages;

////////////////////////////////////////////////
// Module Imports
////////////////////////////////////////////////

import Model.Location.Location;
import Model.Location.LocationCollection;

////////////////////////////////////////////////
// Stage 1
////////////////////////////////////////////////

public class Stage1 {

    public static void main(String[] args){
        System.out.println("== Loading Raw Locations List ==");
        LocationCollection.loadRawCities();
        System.out.println(LocationCollection.getNumLocations() + " locations loaded.");
        System.out.println("Locations: ");
        for (Location tempLocation : LocationCollection.getLocations()){
            System.out.println(tempLocation.getCityName()+ ", "+tempLocation.getStateName());
        }
        System.out.print("Saving compiled locations to JSON file...");
        LocationCollection.saveLocations();
        LocationCollection.loadLocations();
        //System.out.println("== Loading Weather Data for Locations ==");
        //LocationCollection.saveLocations();

        //temp high, temp avg, temp low, rainfall, snowfall, days rain, hours sunshine

        System.out.println("Done.");
    }
}

////////////////////////////////////////////////
// End of File
////////////////////////////////////////////////

