package model;

import java.util.ArrayList;

/**
 * Lớp thực thể SalesFloor1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class SalesFloor1 {
    private int id;
    private String name;
    private float area;
    private String description;
    private ArrayList<Counter1> counters;
    private ArrayList<Zone1> zones;

    public SalesFloor1() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public float getArea() {
        return area;
    }

    public void setArea(float area) {
        this.area = area;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public ArrayList<Counter1> getCounters() {
        return counters;
    }

    public void setCounters(ArrayList<Counter1> counters) {
        this.counters = counters;
    }

    public ArrayList<Zone1> getZones() {
        return zones;
    }

    public void setZones(ArrayList<Zone1> zones) {
        this.zones = zones;
    }
}
