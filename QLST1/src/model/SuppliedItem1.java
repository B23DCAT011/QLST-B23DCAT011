package model;

/**
 * Lớp thực thể SuppliedItem1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class SuppliedItem1 {
    private int id;
    private SupplyContract1 contract;
    private Item1 item;
    private String supplierItemCode;
    private float agreedPrice;
    private int minOrderQuantity;
    private int leadTime;
    private int supplierWarranty;
    private String status;

    public SuppliedItem1() {
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

    public Item1 getItem() {
        return item;
    }

    public void setItem(Item1 item) {
        this.item = item;
    }

    public String getSupplierItemCode() {
        return supplierItemCode;
    }

    public void setSupplierItemCode(String supplierItemCode) {
        this.supplierItemCode = supplierItemCode;
    }

    public float getAgreedPrice() {
        return agreedPrice;
    }

    public void setAgreedPrice(float agreedPrice) {
        this.agreedPrice = agreedPrice;
    }

    public int getMinOrderQuantity() {
        return minOrderQuantity;
    }

    public void setMinOrderQuantity(int minOrderQuantity) {
        this.minOrderQuantity = minOrderQuantity;
    }

    public int getLeadTime() {
        return leadTime;
    }

    public void setLeadTime(int leadTime) {
        this.leadTime = leadTime;
    }

    public int getSupplierWarranty() {
        return supplierWarranty;
    }

    public void setSupplierWarranty(int supplierWarranty) {
        this.supplierWarranty = supplierWarranty;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
