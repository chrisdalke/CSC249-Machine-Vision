////////////////////////////////////////////////
// CSC 249 Final Project
// Chris Dalke & Nate Conroy
////////////////////////////////////////////////
// Module: Azure Subscription Key Manager
////////////////////////////////////////////////

package Model;

////////////////////////////////////////////////
// Module Imports
////////////////////////////////////////////////

import java.util.ArrayList;
import java.util.Date;
import java.util.concurrent.TimeUnit;

////////////////////////////////////////////////
// Subscription Key Manager
////////////////////////////////////////////////

public class SubscriptionKeyManager {

    private static ArrayList<String> keys = new ArrayList<>();
    private static int currentKey;
    private static boolean isInitialized;

    public static String getKey(){
        if (!isInitialized){

            keys.add("1fe9a09315bf4185a4fc8c1361e8b79e");
            keys.add("75886437133b47d4b7adc5ba0278c1a5");

            isInitialized = true;
        }


        String returnKey = keys.get(currentKey);
        currentKey = (currentKey + 1) % keys.size();

        System.out.print("[key " +returnKey+"]");

        try {
            Thread.sleep(3000 / keys.size());
        } catch (Exception e){}

        return returnKey;
    }

    public static long getDateDiff(Date date1, Date date2, TimeUnit timeUnit) {
        long diffInMillies = date2.getTime() - date1.getTime();
        return timeUnit.convert(diffInMillies,TimeUnit.MILLISECONDS);
    }

    public static void main(String[] args){
        while (true){
            getKey();
            System.out.println();
        }
    }

}

////////////////////////////////////////////////
// End of File
////////////////////////////////////////////////