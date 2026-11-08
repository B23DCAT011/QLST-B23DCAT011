package model;

/**
 * Lớp thực thể StockTransferDetail1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class StockTransferDetail1 {
    private int id;
    private StockUnit1 stockUnit;
    private StorageLocation1 fromLocation;
    private StorageLocation1 toLocation;
    private String defectDescription;

    public StockTransferDetail1() {
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

    public StorageLocation1 getFromLocation() {
        return fromLocation;
    }

    public void setFromLocation(StorageLocation1 fromLocation) {
        this.fromLocation = fromLocation;
    }

    public StorageLocation1 getToLocation() {
        return toLocation;
    }

    public void setToLocation(StorageLocation1 toLocation) {
        this.toLocation = toLocation;
    }

    public String getDefectDescription() {
        return defectDescription;
    }

    public void setDefectDescription(String defectDescription) {
        this.defectDescription = defectDescription;
    }
}
