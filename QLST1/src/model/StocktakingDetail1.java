package model;

/**
 * Lớp thực thể StocktakingDetail1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class StocktakingDetail1 {
    private int id;
    private StorageLocation1 location;
    private StockUnit1 stockUnit;
    private Item1 item;
    private String result;
    private String differenceReason;

    public StocktakingDetail1() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public StorageLocation1 getLocation() {
        return location;
    }

    public void setLocation(StorageLocation1 location) {
        this.location = location;
    }

    public StockUnit1 getStockUnit() {
        return stockUnit;
    }

    public void setStockUnit(StockUnit1 stockUnit) {
        this.stockUnit = stockUnit;
    }

    public Item1 getItem() {
        return item;
    }

    public void setItem(Item1 item) {
        this.item = item;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getDifferenceReason() {
        return differenceReason;
    }

    public void setDifferenceReason(String differenceReason) {
        this.differenceReason = differenceReason;
    }
}
