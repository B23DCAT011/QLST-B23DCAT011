package model;

import java.util.ArrayList;
import java.util.Date;

/**
 * Lớp thực thể SupplyContract1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class SupplyContract1 {
    private int id;
    private Supplier1 supplier;
    private Date signDate;
    private Date effectiveDate;
    private Date expiryDate;
    private String paymentTerm;
    private String status;
    private String terminationReason;
    private ArrayList<SuppliedItem1> suppliedItems;
    private ArrayList<StockReceiptNote1> receiptNotes;
    private ArrayList<StockIssueNote1> returnNotes;

    public SupplyContract1() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Supplier1 getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier1 supplier) {
        this.supplier = supplier;
    }

    public Date getSignDate() {
        return signDate;
    }

    public void setSignDate(Date signDate) {
        this.signDate = signDate;
    }

    public Date getEffectiveDate() {
        return effectiveDate;
    }

    public void setEffectiveDate(Date effectiveDate) {
        this.effectiveDate = effectiveDate;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

    public String getPaymentTerm() {
        return paymentTerm;
    }

    public void setPaymentTerm(String paymentTerm) {
        this.paymentTerm = paymentTerm;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getTerminationReason() {
        return terminationReason;
    }

    public void setTerminationReason(String terminationReason) {
        this.terminationReason = terminationReason;
    }

    public ArrayList<SuppliedItem1> getSuppliedItems() {
        return suppliedItems;
    }

    public void setSuppliedItems(ArrayList<SuppliedItem1> suppliedItems) {
        this.suppliedItems = suppliedItems;
    }

    public ArrayList<StockReceiptNote1> getReceiptNotes() {
        return receiptNotes;
    }

    public void setReceiptNotes(ArrayList<StockReceiptNote1> receiptNotes) {
        this.receiptNotes = receiptNotes;
    }

    public ArrayList<StockIssueNote1> getReturnNotes() {
        return returnNotes;
    }

    public void setReturnNotes(ArrayList<StockIssueNote1> returnNotes) {
        this.returnNotes = returnNotes;
    }
}
