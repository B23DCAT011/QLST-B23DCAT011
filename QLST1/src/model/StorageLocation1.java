package model;

import java.util.ArrayList;

/**
 * Lớp thực thể StorageLocation1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class StorageLocation1 {
    private int id;
    private String row;
    private String rack;
    private int level;
    private int capacity;
    private float maxLoad;
    private String status;
    private ArrayList<StockUnit1> stockUnits;
    private ArrayList<StockIssueDetail1> issueDetails;
    private ArrayList<StockTransferDetail1> transferOutDetails;
    private ArrayList<StockTransferDetail1> transferInDetails;
    private ArrayList<StocktakingDetail1> stocktakingDetails;

    public StorageLocation1() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRow() {
        return row;
    }

    public void setRow(String row) {
        this.row = row;
    }

    public String getRack() {
        return rack;
    }

    public void setRack(String rack) {
        this.rack = rack;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public float getMaxLoad() {
        return maxLoad;
    }

    public void setMaxLoad(float maxLoad) {
        this.maxLoad = maxLoad;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public ArrayList<StockUnit1> getStockUnits() {
        return stockUnits;
    }

    public void setStockUnits(ArrayList<StockUnit1> stockUnits) {
        this.stockUnits = stockUnits;
    }

    public ArrayList<StockIssueDetail1> getIssueDetails() {
        return issueDetails;
    }

    public void setIssueDetails(ArrayList<StockIssueDetail1> issueDetails) {
        this.issueDetails = issueDetails;
    }

    public ArrayList<StockTransferDetail1> getTransferOutDetails() {
        return transferOutDetails;
    }

    public void setTransferOutDetails(ArrayList<StockTransferDetail1> transferOutDetails) {
        this.transferOutDetails = transferOutDetails;
    }

    public ArrayList<StockTransferDetail1> getTransferInDetails() {
        return transferInDetails;
    }

    public void setTransferInDetails(ArrayList<StockTransferDetail1> transferInDetails) {
        this.transferInDetails = transferInDetails;
    }

    public ArrayList<StocktakingDetail1> getStocktakingDetails() {
        return stocktakingDetails;
    }

    public void setStocktakingDetails(ArrayList<StocktakingDetail1> stocktakingDetails) {
        this.stocktakingDetails = stocktakingDetails;
    }
}
