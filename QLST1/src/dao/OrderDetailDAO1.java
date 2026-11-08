package dao;

import java.sql.PreparedStatement;
import java.util.ArrayList;

import model.OrderDetail1;

/**
 * Truy xuất dữ liệu dòng chi tiết đơn hàng (bảng tblOrderDetail1).
 */
public class OrderDetailDAO1 extends DAO1 {

    public OrderDetailDAO1() {
        super();
    }

    /**
     * Lưu các dòng chi tiết của đơn hàng. Được gọi trong giao dịch của OnlineOrderDAO1.saveOrder()
     * nên không tự commit.
     * @param idOrder id của đơn hàng vừa thêm
     * @param listDetail các dòng chi tiết (mặt hàng, số lượng, đơn giá)
     * @return true nếu lưu đủ tất cả các dòng
     */
    public boolean saveOrderDetails(int idOrder, ArrayList<OrderDetail1> listDetail) {
        if ((listDetail == null) || (listDetail.size() == 0)) return false;
        boolean kq = false;
        String sqlThem = "INSERT INTO tblOrderDetail1(quantity, unitPrice, tblOnlineOrder1id, tblItem1id) VALUES(?,?,?,?)";
        try {
            for (OrderDetail1 od : listDetail) {
                PreparedStatement ps = con.prepareStatement(sqlThem);
                ps.setInt(1, od.getQuantity());
                ps.setFloat(2, od.getUnitPrice());
                ps.setInt(3, idOrder);
                ps.setInt(4, od.getItem().getId());
                ps.executeUpdate();
            }
            kq = true;
        } catch (Exception e) {
            e.printStackTrace();
            kq = false;
        }
        return kq;
    }
}
