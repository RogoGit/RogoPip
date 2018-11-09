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

    public String getRes() {
        return res;
    }

    public void setRes(String res) {
        this.res = res;
    }

    public void areaCheck() {

        boolean ifHit =  (this.kx <= 0 && this.ky <= 0 && -this.kx <= this.rad/2 && -this.ky <= this.rad) ||
                        (this.kx <= 0 && this.ky >= 0 && (this.kx * this.kx + this.ky * this.ky) <= (this.rad * this.rad)/4) ||
                        (this.kx >= 0 && this.ky <= 0 && this.ky>=(-this.kx-this.rad)); // FIX IT!!!

        if (ifHit) {
            this.color = "green";
            this.res = "Попадает";
        } else {
            this.color = "red";
            this.res = "Не попадает";
        }

    }

}
