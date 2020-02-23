////////////////////////////////////////////////
// CSC 249 Final Project
// Chris Dalke & Nate Conroy
////////////////////////////////////////////////
// Module: Lat/Long Parser
// Parses latitude/longitude from string -> float
////////////////////////////////////////////////

package Utility;

////////////////////////////////////////////////
// Lat/Lon Parser
////////////////////////////////////////////////

public class LatLongParser {

    public static float latLongStringToFloat(String input){
        input = input.toUpperCase();
        input = input.replace(" ",""); //remove spaces
        char direction = input.charAt(input.length() - 1);
        input = input.substring(0,input.length()-1);

        float value = Float.parseFloat(input);
        switch (direction){
            case 'N':{
                break;
            }
            case 'S':{
                value = -value;
                break;
            }
            case 'E':{
                break;
            }
            case 'W':{
                value = -value;
                break;
            }
        }

        return value;
    }
}

////////////////////////////////////////////////
// End of File
////////////////////////////////////////////////