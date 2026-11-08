package model;

/**
 * Lớp thực thể StockIssueDetail1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class StockIssueDetail1 {
    private int id;
    private StockUnit1 stockUnit;
    private StorageLocation1 pickLocation;
    private float refundPrice;

    public StockIssueDetail1() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public StockUnit1 getStockUnit() {
        return stockUnit;
    }

    public void setStockUnit(StockUnit1 stockUnit) {
        this.stockUnit = stockUnit;
    }

    public StorageLocation1 getPickLocation() {
        return pickLocation;
    }

    public void setPickLocation(StorageLocation1 pickLocation) {
        this.pickLocation = pickLocation;
    }

    public float getRefundPrice() {
        return refundPrice;
    }

    public void setRefundPrice(float refundPrice) {
        this.refundPrice = refundPrice;
    }
}
