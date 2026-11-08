package model;

/**
 * Lớp thực thể ItemStatistics1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class ItemStatistics1 extends Item1 {
    private int soldQuantity;
    private float revenue;
    private int warehouseStock;
    private int shelfStock;
    private int defectQuantity;

    public ItemStatistics1() {
        super();
    }

    public int getSoldQuantity() {
        return soldQuantity;
    }

    public void setSoldQuantity(int soldQuantity) {
        this.soldQuantity = soldQuantity;
    }

    public float getRevenue() {
        return revenue;
    }

    public void setRevenue(float revenue) {
        this.revenue = revenue;
    }

    public int getWarehouseStock() {
        return warehouseStock;
    }

    public void setWarehouseStock(int warehouseStock) {
        this.warehouseStock = warehouseStock;
    }

    public int getShelfStock() {
        return shelfStock;
    }

    public void setShelfStock(int shelfStock) {
        this.shelfStock = shelfStock;
    }

    public int getDefectQuantity() {
        return defectQuantity;
    }

    public void setDefectQuantity(int defectQuantity) {
        this.defectQuantity = defectQuantity;
    }
}
