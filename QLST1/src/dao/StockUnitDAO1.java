package dao;

import java.sql.CallableStatement;
import java.sql.ResultSet;

/**
 * Truy xuất dữ liệu sản phẩm (bảng tblStockUnit1). Số lượng tồn, số lượng trên kệ và số lượng
 * có thể bán của mặt hàng không lưu trực tiếp mà đếm từ các sản phẩm, qua đường
 * tblStockUnit1 -> tblStockReceiptDetail1 (lô hàng) -> tblSuppliedItem1 -> tblItem1.
 */
public class StockUnitDAO1 extends DAO1 {

    public StockUnitDAO1() {
        super();
    }

    /**
     * Đếm số lượng tồn của mặt hàng: số sản phẩm đang ở trạng thái trong kho hoặc trên kệ bán.
     * @param idItem id của mặt hàng
     * @return số lượng tồn
     */
    public int getStockQuantity(int idItem) {
        int kq = 0;
        String sql = "{call getStockQuantity(?)}"; // su dung stored procedure
        try {
            CallableStatement cs = con.prepareCall(sql);
            cs.setInt(1, idItem);
            ResultSet rs = cs.executeQuery();
            if (rs.next()) {
                kq = rs.getInt("stockQuantity");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return kq;
    }

    /**
     * Đếm số sản phẩm của mặt hàng đang nằm trên kệ tự chọn (chuẩn bị ngoại lệ 10.6).
     * @param idItem id của mặt hàng
     * @return số sản phẩm trên kệ tự chọn
     */
    public int countUnitsOnShelf(int idItem) {
        int kq = 0;
        String sql = "{call countUnitsOnShelf(?)}"; // su dung stored procedure
        try {
            CallableStatement cs = con.prepareCall(sql);
            cs.setInt(1, idItem);
            ResultSet rs = cs.executeQuery();
            if (rs.next()) {
                kq = rs.getInt("unitsOnShelf");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return kq;
    }

    /**
     * Tính số lượng có thể bán của mặt hàng: số sản phẩm trong kho / trên kệ bán, trừ số lượng
     * của các đơn đã duyệt chưa xuất và các dòng hoá đơn giao từ kho có phiếu xuất chờ xuất.
     * @param idItem id của mặt hàng
     * @return số lượng có thể bán
     */
    public int getSellableQuantity(int idItem) {
        int kq = 0;
        String sql = "{call getSellableQuantity(?)}"; // su dung stored procedure
        try {
            CallableStatement cs = con.prepareCall(sql);
            cs.setInt(1, idItem);
            ResultSet rs = cs.executeQuery();
            if (rs.next()) {
                kq = rs.getInt("sellableQuantity");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return kq;
    }
}
