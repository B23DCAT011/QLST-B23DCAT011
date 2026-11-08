package model;

import java.util.ArrayList;
import java.util.Date;

/**
 * Lớp thực thể Batch1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class Batch1 {
    private int id;
    private StockReceiptDetail1 receiptDetail;
    private Date receiptDate;
    private float actualImportPrice;
    private int quantity;
    private int defectQuantity;
    private ArrayList<StockUnit1> stockUnits;

    public Batch1() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public StockReceiptDetail1 getReceiptDetail() {
        return receiptDetail;
    }

    public void setReceiptDetail(StockReceiptDetail1 receiptDetail) {
        this.receiptDetail = receiptDetail;
    }

    public Date getReceiptDate() {
        return receiptDate;
    }

    public void setReceiptDate(Date receiptDate) {
        this.receiptDate = receiptDate;
    }

    public float getActualImportPrice() {
        return actualImportPrice;
    }

    public void setActualImportPrice(float actualImportPrice) {
        this.actualImportPrice = actualImportPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getDefectQuantity() {
        return defectQuantity;
    }

    public void setDefectQuantity(int defectQuantity) {
        this.defectQuantity = defectQuantity;
    }

    public ArrayList<StockUnit1> getStockUnits() {
        return stockUnits;
    }

    public void setStockUnits(ArrayList<StockUnit1> stockUnits) {
        this.stockUnits = stockUnits;
    }
}
