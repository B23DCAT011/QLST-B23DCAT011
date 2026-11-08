package model;

import java.util.ArrayList;

/**
 * Lớp thực thể Counter1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class Counter1 {
    private int id;
    private String name;
    private String location;
    private String description;
    private ArrayList<Salesperson1> salespersons;
    private ArrayList<Invoice1> invoices;

    public Counter1() {
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

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public ArrayList<Salesperson1> getSalespersons() {
        return salespersons;
    }

    public void setSalespersons(ArrayList<Salesperson1> salespersons) {
        this.salespersons = salespersons;
    }

    public ArrayList<Invoice1> getInvoices() {
        return invoices;
    }

    public void setInvoices(ArrayList<Invoice1> invoices) {
        this.invoices = invoices;
    }
}
