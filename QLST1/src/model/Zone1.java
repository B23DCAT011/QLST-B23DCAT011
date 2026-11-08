package model;

import java.util.ArrayList;

/**
 * Lớp thực thể Zone1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class Zone1 {
    private int id;
    private String name;
    private String zoneType;
    private String storageCondition;
    private String status;
    private String description;
    private ArrayList<StorageLocation1> locations;
    private ArrayList<WarehouseStaff1> staffs;
    private ArrayList<StocktakingSheet1> stocktakingSheets;

    public Zone1() {
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

    public String getZoneType() {
        return zoneType;
    }

    public void setZoneType(String zoneType) {
        this.zoneType = zoneType;
    }

    public String getStorageCondition() {
        return storageCondition;
    }

    public void setStorageCondition(String storageCondition) {
        this.storageCondition = storageCondition;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public ArrayList<StorageLocation1> getLocations() {
        return locations;
    }

    public void setLocations(ArrayList<StorageLocation1> locations) {
        this.locations = locations;
    }

    public ArrayList<WarehouseStaff1> getStaffs() {
        return staffs;
    }

    public void setStaffs(ArrayList<WarehouseStaff1> staffs) {
        this.staffs = staffs;
    }

    public ArrayList<StocktakingSheet1> getStocktakingSheets() {
        return stocktakingSheets;
    }

    public void setStocktakingSheets(ArrayList<StocktakingSheet1> stocktakingSheets) {
        this.stocktakingSheets = stocktakingSheets;
    }
}
