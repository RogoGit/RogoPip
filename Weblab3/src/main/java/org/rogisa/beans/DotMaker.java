package org.rogisa.beans;

import java.io.Serializable;

public class DotMaker implements Serializable {
    private double kx;
    private double ky;
    private double rad;
    private String color;
    private boolean res;

    public DotMaker(double kx, double ky, double rad, String color, boolean res) {
        this.kx = kx;
        this.ky = ky;
        this.rad = rad;
        this.color = color;
        this.res = res;
    }

    public DotMaker() {

    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public double getKx() {
        return kx;
    }

    public void setKx(double kx) {
        this.kx = kx;
    }

    public double getKy() {
        return ky;
    }

    public void setKy(double ky) {
        this.ky = ky;
    }

    public double getRad() {
        return rad;
    }

    public void setRad(double rad) {
        this.rad = rad;
    }

    public boolean isRes() {
        return res;
    }

    public void setRes(boolean res) {
        this.res = res;
    }

    public void areaCheck() {
        updateRes();

        updateColor();
    }

    private void updateColor() {
        if (res) {
            color = "green";
        } else {
            color = "red";
        }
    }

    private void updateRes() {
        res = (this.kx <= 0 && this.ky <= 0 && Math.abs(this.kx) <= this.rad / 2 && Math.abs(this.ky) <= this.rad) ||
                (this.kx <= 0 && this.ky >= 0 && (this.kx * this.kx + this.ky * this.ky) <= (this.rad * this.rad)) ||
                (this.kx >= 0 && this.ky <= 0 && this.ky >= (2 * this.kx - this.rad / 2));
    }

}
