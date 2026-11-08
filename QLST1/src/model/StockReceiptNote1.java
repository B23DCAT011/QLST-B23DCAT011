package model;

import java.util.ArrayList;
import java.util.Date;

/**
 * Lớp thực thể StockReceiptNote1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class StockReceiptNote1 {
    private int id;
    private SupplyContract1 contract;
    private WarehouseStaff1 staff;
    private Date receiptDate;
    private float totalAmount;
    private String note;
    private ArrayList<StockReceiptDetail1> details;

    public StockReceiptNote1() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public SupplyContract1 getContract() {
        return contract;
    }

    public void setContract(SupplyContract1 contract) {
        this.contract = contract;
    }

    public WarehouseStaff1 getStaff() {
        return staff;
    }

    public void setStaff(WarehouseStaff1 staff) {
        this.staff = staff;
    }

    public Date getReceiptDate() {
        return receiptDate;
    }

    public void setReceiptDate(Date receiptDate) {
        this.receiptDate = receiptDate;
    }

    public float getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(float totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public ArrayList<StockReceiptDetail1> getDetails() {
        return details;
    }

    public void setDetails(ArrayList<StockReceiptDetail1> details) {
        this.details = details;
    }
}
