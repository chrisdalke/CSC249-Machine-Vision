////////////////////////////////////////////////
// CSC 249 Final Project
// Chris Dalke & Nate Conroy
////////////////////////////////////////////////
// Module: CSV Parser
// Converts a CSV file into a readable array format
////////////////////////////////////////////////

package Utility;

////////////////////////////////////////////////
// Module Imports
////////////////////////////////////////////////

import org.apache.commons.io.input.BOMInputStream;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import static org.apache.commons.io.ByteOrderMark.*;

////////////////////////////////////////////////
// CSV Parser
////////////////////////////////////////////////

public class CSVParser {

    private String filename;
    private int numRows;
    private int numColumns;
    private String[][] cells; //X, Y (column, row)

    public CSVParser(String filename){

        this.filename = filename;
        BufferedReader bufferedReader = null;

        try {

            ArrayList<String> tempLines = new ArrayList<>();


            FileInputStream fis = new FileInputStream(filename);
            BOMInputStream bomInputStream =new BOMInputStream(fis, UTF_8, UTF_16BE, UTF_16LE, UTF_32BE, UTF_32LE);
            bufferedReader = new BufferedReader(new InputStreamReader(new BOMInputStream(fis),"UTF8"));
            String line = null;
            while ((line = bufferedReader.readLine()) != null) {
                tempLines.add(line);
            }

            numRows = tempLines.size();
            numColumns = tempLines.get(0).split(",").length;
            cells = new String[numColumns][numRows];

            for (int i = 0; i < tempLines.size(); i++){
                String[] tempLineArray = tempLines.get(i).split(",");
                for (int x = 0; x < numColumns; x++){
                    cells[x][i] = tempLineArray[x];
                }
            }
        } catch (Exception e){
            e.printStackTrace();
            int numRows = 0;
            int numColumns = 0;
        } finally {
            if (bufferedReader != null){
                try {
                    bufferedReader.close();
                } catch (Exception e){}
            }
        }
    }

    public int getNumRows(){
        return numRows;
    }

    public int getNumColumns(){
        return numColumns;
    }

    public String[] getRow(int rowId){
        if (numRows == 0){ return null;}

        String[] rowArray = new String[numColumns];
        for (int i = 0; i < numColumns; i++){
            rowArray[i] = cells[i][rowId];
        }

        return rowArray;
    }

    public String[] getColumn(int columnId){
        if (numColumns == 0){ return null;}

        String[] columnArray = new String[numRows];
        for (int i = 0; i < numRows; i++){
            columnArray[i] = cells[columnId][i];
        }

        return columnArray;
    }

    public String getCell(int columnId,int rowId){
        if (numRows == 0){ return null;}
        if (numColumns == 0){ return null;}

        return cells[columnId][rowId];
    }
}

////////////////////////////////////////////////
// End of File
////////////////////////////////////////////////