package model;

import java.util.ArrayList;

/**
 * Lớp thực thể Shipper1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class Shipper1 extends Employee1 {
    private String licensePlate;
    private ArrayList<StockIssueNote1> issueNotes;

    public Shipper1() {
        super();
    }

    public String getLicensePlate() {
        return licensePlate;
    }

    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }

    public ArrayList<StockIssueNote1> getIssueNotes() {
        return issueNotes;
    }

    public void setIssueNotes(ArrayList<StockIssueNote1> issueNotes) {
        this.issueNotes = issueNotes;
    }
}
