////////////////////////////////////////////////
// CSC 249 Final Project
// Chris Dalke & Nate Conroy
////////////////////////////////////////////////
// Module: Bounding Box Object
////////////////////////////////////////////////

package Model;

////////////////////////////////////////////////
// Bounding Box Object
////////////////////////////////////////////////

public class BoundingBox {
    private int height;
    private int left;
    private int top;
    private int width;

    public BoundingBox(){}

    public BoundingBox(int height, int left, int top, int width) {
        this.height = height;
        this.left = left;
        this.top = top;
        this.width = width;
    }

    public int getHeight() {
        return height;
    }

    public void setHeight(int height) {
        this.height = height;
    }

    public int getLeft() {
        return left;
    }

    public void setLeft(int left) {
        this.left = left;
    }

    public int getTop() {
        return top;
    }

    public void setTop(int top) {
        this.top = top;
    }

    public int getWidth() {
        return width;
    }

    public void setWidth(int width) {
        this.width = width;
    }
}

////////////////////////////////////////////////
// End of File
////////////////////////////////////////////////