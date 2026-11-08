package model;

import java.util.ArrayList;
import java.util.Date;

/**
 * Lớp thực thể StocktakingSheet1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class StocktakingSheet1 {
    private int id;
    private Zone1 zone;
    private Date startDate;
    private Date closeDate;
    private WarehouseStaff1 staff;
    private String status;
    private float totalDifference;
    private String note;
    private ArrayList<StocktakingDetail1> details;

    public StocktakingSheet1() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Zone1 getZone() {
        return zone;
    }

    public void setZone(Zone1 zone) {
        this.zone = zone;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getCloseDate() {
        return closeDate;
    }

    public void setCloseDate(Date closeDate) {
        this.closeDate = closeDate;
    }

    public WarehouseStaff1 getStaff() {
        return staff;
    }

    public void setStaff(WarehouseStaff1 staff) {
        this.staff = staff;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public float getTotalDifference() {
        return totalDifference;
    }

    public void setTotalDifference(float totalDifference) {
        this.totalDifference = totalDifference;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public ArrayList<StocktakingDetail1> getDetails() {
        return details;
    }

    public void setDetails(ArrayList<StocktakingDetail1> details) {
        this.details = details;
    }
}
