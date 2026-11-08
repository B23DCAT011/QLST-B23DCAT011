package model;

import java.util.ArrayList;

/**
 * Lớp thực thể Item1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class Item1 {
    private int id;
    private String name;
    private Category1 category;
    private Brand1 brand;
    private UnitOfMeasure1 unit;
    private float sellingPrice;
    private int warrantyPeriod;
    private boolean hasSerial;
    private String counterSaleMode;
    private int minShelfQuantity;
    private String description;
    private String image;
    private String status;
    private ArrayList<StocktakingDetail1> stocktakingDetails;

    public Item1() {
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

    public Category1 getCategory() {
        return category;
    }

    public void setCategory(Category1 category) {
        this.category = category;
    }

    public Brand1 getBrand() {
        return brand;
    }

    public void setBrand(Brand1 brand) {
        this.brand = brand;
    }

    public UnitOfMeasure1 getUnit() {
        return unit;
    }

    public void setUnit(UnitOfMeasure1 unit) {
        this.unit = unit;
    }

    public float getSellingPrice() {
        return sellingPrice;
    }

    public void setSellingPrice(float sellingPrice) {
        this.sellingPrice = sellingPrice;
    }

    public int getWarrantyPeriod() {
        return warrantyPeriod;
    }

    public void setWarrantyPeriod(int warrantyPeriod) {
        this.warrantyPeriod = warrantyPeriod;
    }

    public boolean isHasSerial() {
        return hasSerial;
    }

    public void setHasSerial(boolean hasSerial) {
        this.hasSerial = hasSerial;
    }

    public String getCounterSaleMode() {
        return counterSaleMode;
    }

    public void setCounterSaleMode(String counterSaleMode) {
        this.counterSaleMode = counterSaleMode;
    }

    public int getMinShelfQuantity() {
        return minShelfQuantity;
    }

    public void setMinShelfQuantity(int minShelfQuantity) {
        this.minShelfQuantity = minShelfQuantity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public ArrayList<StocktakingDetail1> getStocktakingDetails() {
        return stocktakingDetails;
    }

    public void setStocktakingDetails(ArrayList<StocktakingDetail1> stocktakingDetails) {
        this.stocktakingDetails = stocktakingDetails;
    }
}
