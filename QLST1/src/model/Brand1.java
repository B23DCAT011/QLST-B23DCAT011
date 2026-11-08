package model;

import java.util.ArrayList;

/**
 * Lớp thực thể Brand1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class Brand1 {
    private int id;
    private String name;
    private String country;
    private String description;
    private ArrayList<Item1> items;

    public Brand1() {
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

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public ArrayList<Item1> getItems() {
        return items;
    }

    public void setItems(ArrayList<Item1> items) {
        this.items = items;
    }
}
