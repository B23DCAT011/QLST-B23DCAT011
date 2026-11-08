package model;

import java.util.ArrayList;
import java.util.Date;

/**
 * Lớp thực thể Cart1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class Cart1 {
    private int id;
    private Customer1 customer;
    private Date createdDate;
    private String status;
    private ArrayList<CartItem1> items;

    public Cart1() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Customer1 getCustomer() {
        return customer;
    }

    public void setCustomer(Customer1 customer) {
        this.customer = customer;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public ArrayList<CartItem1> getItems() {
        return items;
    }

    public void setItems(ArrayList<CartItem1> items) {
        this.items = items;
    }
}
