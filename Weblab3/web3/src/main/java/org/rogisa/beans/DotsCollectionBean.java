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

    public void addDot(String kx, String ky, String rad) {
        if (this.areaDots==null) {this.areaDots=new ArrayList<>();}
        DotMaker newDot = new DotMaker();
        newDot.setKx(Double.parseDouble(kx));
        newDot.setKy(Double.parseDouble(ky));
        newDot.setRad(Double.parseDouble(rad));
        newDot.areaCheck();
        areaDots.add(newDot);
    }

    public ArrayList<DotMaker> getAreaDots() {
        return areaDots;
    }
}
