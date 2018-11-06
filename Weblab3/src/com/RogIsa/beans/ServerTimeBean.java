package com.RogIsa.beans;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.io.Serializable;

public class ServerTimeBean implements Serializable{
    private String time;
    
    public String getTime() {
        return time = LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd-MM-uuuu hh:mm:ss a"));
    }

    public void setTime(String time) {
        this.time = time;
    }
}
