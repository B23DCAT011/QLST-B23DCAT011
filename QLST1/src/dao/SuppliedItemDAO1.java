package dao;

import java.sql.CallableStatement;
import java.sql.ResultSet;

/**
 * Truy xuất dữ liệu mặt hàng cung cấp (bảng tblSuppliedItem1).
 */
public class SuppliedItemDAO1 extends DAO1 {

    public SuppliedItemDAO1() {
        super();
    }

    /**
     * Lấy giá nhập thoả thuận cao nhất của mặt hàng, chỉ xét các dòng đang cung cấp thuộc hợp đồng
     * còn hiệu lực (chuẩn bị ngoại lệ 10.5 - cảnh báo bán dưới giá vốn).
     * @param idItem id của mặt hàng
     * @return giá nhập thoả thuận cao nhất, 0 nếu không có hợp đồng nào còn hiệu lực
     */
    public float getMaxAgreedPrice(int idItem) {
        float kq = 0;
        String sql = "{call getMaxAgreedPrice(?)}"; // su dung stored procedure
        try {
            CallableStatement cs = con.prepareCall(sql);
            cs.setInt(1, idItem);
            ResultSet rs = cs.executeQuery();
            if (rs.next()) {
                kq = rs.getFloat("maxAgreedPrice");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return kq;
    }
}
