package model;

import java.util.ArrayList;

/**
 * Lớp thực thể UnitOfMeasure1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class UnitOfMeasure1 {
    private int id;
    private String name;
    private ArrayList<Item1> items;

    public UnitOfMeasure1() {
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

    public ArrayList<Item1> getItems() {
        return items;
    }

    public void setItems(ArrayList<Item1> items) {
        this.items = items;
    }
}
