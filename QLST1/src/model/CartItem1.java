package model;

/**
 * Lớp thực thể CartItem1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class CartItem1 {
    private int id;
    private Item1 item;
    private int quantity;
    private float unitPrice;

    public CartItem1() {
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
}
