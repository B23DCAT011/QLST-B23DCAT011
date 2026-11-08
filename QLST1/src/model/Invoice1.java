package model;

import java.util.ArrayList;
import java.util.Date;

/**
 * Lớp thực thể Invoice1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class Invoice1 {
    private int id;
    private Date issueDate;
    private String salesChannel;
    private OnlineOrder1 order;
    private Customer1 customer;
    private Salesperson1 salesperson;
    private Counter1 counter;
    private WarehouseStaff1 confirmingStaff;
    private String buyerName;
    private String buyerPhone;
    private float totalAmount;
    private String paymentMethod;
    private ArrayList<InvoiceDetail1> details;
    private StockIssueNote1 issueNote;

    public Invoice1() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }

    public String getSalesChannel() {
        return salesChannel;
    }

    public void setSalesChannel(String salesChannel) {
        this.salesChannel = salesChannel;
    }

    public OnlineOrder1 getOrder() {
        return order;
    }

    public void setOrder(OnlineOrder1 order) {
        this.order = order;
    }

    public Customer1 getCustomer() {
        return customer;
    }

    public void setCustomer(Customer1 customer) {
        this.customer = customer;
    }

    public Salesperson1 getSalesperson() {
        return salesperson;
    }

    public void setSalesperson(Salesperson1 salesperson) {
        this.salesperson = salesperson;
    }

    public Counter1 getCounter() {
        return counter;
    }

    public void setCounter(Counter1 counter) {
        this.counter = counter;
    }

    public WarehouseStaff1 getConfirmingStaff() {
        return confirmingStaff;
    }

    public void setConfirmingStaff(WarehouseStaff1 confirmingStaff) {
        this.confirmingStaff = confirmingStaff;
    }

    public String getBuyerName() {
        return buyerName;
    }

    public void setBuyerName(String buyerName) {
        this.buyerName = buyerName;
    }

    public String getBuyerPhone() {
        return buyerPhone;
    }

    public void setBuyerPhone(String buyerPhone) {
        this.buyerPhone = buyerPhone;
    }

    public float getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(float totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public ArrayList<InvoiceDetail1> getDetails() {
        return details;
    }

    public void setDetails(ArrayList<InvoiceDetail1> details) {
        this.details = details;
    }

    public StockIssueNote1 getIssueNote() {
        return issueNote;
    }

    public void setIssueNote(StockIssueNote1 issueNote) {
        this.issueNote = issueNote;
    }
}
