package model;

import java.util.ArrayList;
import java.util.Date;

/**
 * Lớp thực thể StockIssueNote1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class StockIssueNote1 {
    private int id;
    private String issueType;
    private Date issueDate;
    private OnlineOrder1 order;
    private Invoice1 invoice;
    private SupplyContract1 contract;
    private WarehouseStaff1 staff;
    private Shipper1 shipper;
    private String reason;
    private String status;
    private Date deliveryConfirmDate;
    private ArrayList<StockIssueDetail1> details;

    public StockIssueNote1() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getIssueType() {
        return issueType;
    }

    public void setIssueType(String issueType) {
        this.issueType = issueType;
    }

    public Date getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }

    public OnlineOrder1 getOrder() {
        return order;
    }

    public void setOrder(OnlineOrder1 order) {
        this.order = order;
    }

    public Invoice1 getInvoice() {
        return invoice;
    }

    public void setInvoice(Invoice1 invoice) {
        this.invoice = invoice;
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

    public Shipper1 getShipper() {
        return shipper;
    }

    public void setShipper(Shipper1 shipper) {
        this.shipper = shipper;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getDeliveryConfirmDate() {
        return deliveryConfirmDate;
    }

    public void setDeliveryConfirmDate(Date deliveryConfirmDate) {
        this.deliveryConfirmDate = deliveryConfirmDate;
    }

    public ArrayList<StockIssueDetail1> getDetails() {
        return details;
    }

    public void setDetails(ArrayList<StockIssueDetail1> details) {
        this.details = details;
    }
}
