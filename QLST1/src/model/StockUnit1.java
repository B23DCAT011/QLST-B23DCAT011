package model;

/**
 * Lớp thực thể StockUnit1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class StockUnit1 {
    private int id;
    private String internalCode;
    private String serialNumber;
    private String status;
    private Batch1 batch;
    private StorageLocation1 location;
    private InvoiceDetail1 invoiceDetail;

    public StockUnit1() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getInternalCode() {
        return internalCode;
    }

    public void setInternalCode(String internalCode) {
        this.internalCode = internalCode;
    }

    public String getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Batch1 getBatch() {
        return batch;
    }

    public void setBatch(Batch1 batch) {
        this.batch = batch;
    }

    public StorageLocation1 getLocation() {
        return location;
    }

    public void setLocation(StorageLocation1 location) {
        this.location = location;
    }

    public InvoiceDetail1 getInvoiceDetail() {
        return invoiceDetail;
    }

    public void setInvoiceDetail(InvoiceDetail1 invoiceDetail) {
        this.invoiceDetail = invoiceDetail;
    }
}
