package model;

/**
 * Lớp thực thể StockReceiptDetail1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class StockReceiptDetail1 {
    private int id;
    private SuppliedItem1 suppliedItem;
    private int receivedQuantity;
    private int defectQuantity;
    private float unitPrice;
    private String priceDifferenceReason;
    private float amount;

    public StockReceiptDetail1() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public SuppliedItem1 getSuppliedItem() {
        return suppliedItem;
    }

    public void setSuppliedItem(SuppliedItem1 suppliedItem) {
        this.suppliedItem = suppliedItem;
    }

    public int getReceivedQuantity() {
        return receivedQuantity;
    }

    public void setReceivedQuantity(int receivedQuantity) {
        this.receivedQuantity = receivedQuantity;
    }

    public int getDefectQuantity() {
        return defectQuantity;
    }

    public void setDefectQuantity(int defectQuantity) {
        this.defectQuantity = defectQuantity;
    }

    public float getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(float unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getPriceDifferenceReason() {
        return priceDifferenceReason;
    }

    public void setPriceDifferenceReason(String priceDifferenceReason) {
        this.priceDifferenceReason = priceDifferenceReason;
    }

    public float getAmount() {
        return amount;
    }

    public void setAmount(float amount) {
        this.amount = amount;
    }
}
