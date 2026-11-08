package model;

/**
 * Lớp thực thể RevenueStatistics1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class RevenueStatistics1 extends Invoice1 {
    private String period;
    private String salesChannel;
    private int invoiceCount;
    private float totalRevenue;

    public RevenueStatistics1() {
        super();
    }

    public String getPeriod() {
        return period;
    }

    public void setPeriod(String period) {
        this.period = period;
    }

    public String getSalesChannel() {
        return salesChannel;
    }

    public void setSalesChannel(String salesChannel) {
        this.salesChannel = salesChannel;
    }

    public int getInvoiceCount() {
        return invoiceCount;
    }

    public void setInvoiceCount(int invoiceCount) {
        this.invoiceCount = invoiceCount;
    }

    public float getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(float totalRevenue) {
        this.totalRevenue = totalRevenue;
    }
}
