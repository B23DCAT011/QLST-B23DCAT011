package model;

/**
 * Lớp thực thể SupplierStatistics1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class SupplierStatistics1 extends Supplier1 {
    private int contractCount;
    private int receivedQuantity;
    private float receivedValue;

    public SupplierStatistics1() {
        super();
    }

    public int getContractCount() {
        return contractCount;
    }

    public void setContractCount(int contractCount) {
        this.contractCount = contractCount;
    }

    public int getReceivedQuantity() {
        return receivedQuantity;
    }

    public void setReceivedQuantity(int receivedQuantity) {
        this.receivedQuantity = receivedQuantity;
    }

    public float getReceivedValue() {
        return receivedValue;
    }

    public void setReceivedValue(float receivedValue) {
        this.receivedValue = receivedValue;
    }
}
