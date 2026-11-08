package model;

import java.util.ArrayList;
import java.util.Date;

/**
 * Lớp thực thể Customer1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class Customer1 extends Member1 {
    private Date registerDate;
    private int loyaltyPoints;
    private ArrayList<Cart1> carts;
    private ArrayList<OnlineOrder1> orders;
    private ArrayList<Invoice1> invoices;

    public Customer1() {
        super();
    }

    public Date getRegisterDate() {
        return registerDate;
    }

    public void setRegisterDate(Date registerDate) {
        this.registerDate = registerDate;
    }

    public int getLoyaltyPoints() {
        return loyaltyPoints;
    }

    public void setLoyaltyPoints(int loyaltyPoints) {
        this.loyaltyPoints = loyaltyPoints;
    }

    public ArrayList<Cart1> getCarts() {
        return carts;
    }

    public void setCarts(ArrayList<Cart1> carts) {
        this.carts = carts;
    }

    public ArrayList<OnlineOrder1> getOrders() {
        return orders;
    }

    public void setOrders(ArrayList<OnlineOrder1> orders) {
        this.orders = orders;
    }

    public ArrayList<Invoice1> getInvoices() {
        return invoices;
    }

    public void setInvoices(ArrayList<Invoice1> invoices) {
        this.invoices = invoices;
    }
}
