package model;

import java.util.ArrayList;

/**
 * Lớp thực thể WarehouseStaff1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class WarehouseStaff1 extends Employee1 {
    private Zone1 zone;
    private ArrayList<StockReceiptNote1> receiptNotes;
    private ArrayList<OnlineOrder1> approvedOrders;
    private ArrayList<Invoice1> confirmedInvoices;
    private ArrayList<StockIssueNote1> issueNotes;
    private ArrayList<StockTransferNote1> transferNotes;
    private ArrayList<StocktakingSheet1> stocktakingSheets;

    public WarehouseStaff1() {
        super();
    }

    public Zone1 getZone() {
        return zone;
    }

    public void setZone(Zone1 zone) {
        this.zone = zone;
    }

    public ArrayList<StockReceiptNote1> getReceiptNotes() {
        return receiptNotes;
    }

    public void setReceiptNotes(ArrayList<StockReceiptNote1> receiptNotes) {
        this.receiptNotes = receiptNotes;
    }

    public ArrayList<OnlineOrder1> getApprovedOrders() {
        return approvedOrders;
    }

    public void setApprovedOrders(ArrayList<OnlineOrder1> approvedOrders) {
        this.approvedOrders = approvedOrders;
    }

    public ArrayList<Invoice1> getConfirmedInvoices() {
        return confirmedInvoices;
    }

    public void setConfirmedInvoices(ArrayList<Invoice1> confirmedInvoices) {
        this.confirmedInvoices = confirmedInvoices;
    }

    public ArrayList<StockIssueNote1> getIssueNotes() {
        return issueNotes;
    }

    public void setIssueNotes(ArrayList<StockIssueNote1> issueNotes) {
        this.issueNotes = issueNotes;
    }

    public ArrayList<StockTransferNote1> getTransferNotes() {
        return transferNotes;
    }

    public void setTransferNotes(ArrayList<StockTransferNote1> transferNotes) {
        this.transferNotes = transferNotes;
    }

    public ArrayList<StocktakingSheet1> getStocktakingSheets() {
        return stocktakingSheets;
    }

    public void setStocktakingSheets(ArrayList<StocktakingSheet1> stocktakingSheets) {
        this.stocktakingSheets = stocktakingSheets;
    }
}
