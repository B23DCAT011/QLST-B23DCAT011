package model;

import java.util.ArrayList;
import java.util.Date;

/**
 * Lớp thực thể OnlineOrder1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class OnlineOrder1 {
    private int id;
    private Customer1 customer;
    private Date orderDate;
    private String deliveryAddress;
    private String receiverPhone;
    private float totalAmount;
    private String status;
    private WarehouseStaff1 approver;
    private Date approvalDate;
    private String reason;
    private ArrayList<OrderDetail1> details;
    private StockIssueNote1 issueNote;

    public OnlineOrder1() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Customer1 getCustomer() {
        return customer;
    }

    public void setCustomer(Customer1 customer) {
        this.customer = customer;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

    public String getReceiverPhone() {
        return receiverPhone;
    }

    public void setReceiverPhone(String receiverPhone) {
        this.receiverPhone = receiverPhone;
    }

    public float getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(float totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public WarehouseStaff1 getApprover() {
        return approver;
    }

    public void setApprover(WarehouseStaff1 approver) {
        this.approver = approver;
    }

    public Date getApprovalDate() {
        return approvalDate;
    }

    public void setApprovalDate(Date approvalDate) {
        this.approvalDate = approvalDate;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public ArrayList<OrderDetail1> getDetails() {
        return details;
    }

    public void setDetails(ArrayList<OrderDetail1> details) {
        this.details = details;
    }

    public StockIssueNote1 getIssueNote() {
        return issueNote;
    }

    public void setIssueNote(StockIssueNote1 issueNote) {
        this.issueNote = issueNote;
    }
}
