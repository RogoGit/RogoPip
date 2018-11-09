package org.rogisa.beans;

import java.io.Serializable;

public class DotMaker implements Serializable {
    private double kx;
    private double ky;
    private double rad;
    private String color;
    private String res;

    public DotMaker(double kx, double ky, double rad, String res) {
        this.kx = kx;
        this.ky = ky;
        this.rad = rad;
        this.res = res;
    }

    public DotMaker() {

    }

    public String getColor() {
        return color;
    }

    public double getKx() {
        return kx;
    }

    public double getKy() {
        return ky;
    }

    public double getRad() {
        return rad;
    }

    public String getRes() {
        return res;
    }
}
