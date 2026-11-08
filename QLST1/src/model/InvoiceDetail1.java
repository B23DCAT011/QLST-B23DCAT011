package model;

import java.util.ArrayList;

/**
 * Lớp thực thể InvoiceDetail1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class InvoiceDetail1 {
    private int id;
    private Item1 item;
    private String receivingMode;
    private int quantity;
    private float unitPrice;
    private float amount;
    private ArrayList<StockUnit1> soldUnits;

    public InvoiceDetail1() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Item1 getItem() {
        return item;
    }

    public void setItem(Item1 item) {
        this.item = item;
    }

    public String getReceivingMode() {
        return receivingMode;
    }

    public void setReceivingMode(String receivingMode) {
        this.receivingMode = receivingMode;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public float getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(float unitPrice) {
        this.unitPrice = unitPrice;
    }

    public float getAmount() {
        return amount;
    }

    public void setAmount(float amount) {
        this.amount = amount;
    }

    public ArrayList<StockUnit1> getSoldUnits() {
        return soldUnits;
    }

    public void setSoldUnits(ArrayList<StockUnit1> soldUnits) {
        this.soldUnits = soldUnits;
    }
}
