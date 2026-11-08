package model;

import java.util.ArrayList;
import java.util.Date;

/**
 * Lớp thực thể StockTransferNote1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class StockTransferNote1 {
    private int id;
    private Date transferDate;
    private WarehouseStaff1 staff;
    private String purpose;
    private String note;
    private ArrayList<StockTransferDetail1> details;

    public StockTransferNote1() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getTransferDate() {
        return transferDate;
    }

    public void setTransferDate(Date transferDate) {
        this.transferDate = transferDate;
    }

    public WarehouseStaff1 getStaff() {
        return staff;
    }

    public void setStaff(WarehouseStaff1 staff) {
        this.staff = staff;
    }

    public String getPurpose() {
        return purpose;
    }

    public void setPurpose(String purpose) {
        this.purpose = purpose;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public ArrayList<StockTransferDetail1> getDetails() {
        return details;
    }

    public void setDetails(ArrayList<StockTransferDetail1> details) {
        this.details = details;
    }
}
