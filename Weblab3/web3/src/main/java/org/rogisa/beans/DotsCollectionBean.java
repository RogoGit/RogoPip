package org.rogisa.beans;

import java.io.Serializable;
import java.util.ArrayList;

public class DotsCollectionBean implements Serializable {

    private ArrayList<DotMaker> areaDots;

    public DotsCollectionBean(ArrayList<DotMaker> areaDots) {
        this.areaDots = areaDots;
    }

    public DotsCollectionBean() {

    }

    public void addDot(DotMaker newDot) {
        areaDots.add(newDot);
    }

    public ArrayList<DotMaker> getAreaDots() {
        return areaDots;
    }
}
