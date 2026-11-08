package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import model.CartItem1;
import model.OnlineOrder1;

/**
 * Truy xuất dữ liệu đơn đặt hàng trực tuyến (bảng tblOnlineOrder1).
 */
public class OnlineOrderDAO1 extends DAO1 {

    public OnlineOrderDAO1() {
        super();
    }

    /**
     * Lưu đơn đặt hàng trực tuyến trong một giao dịch: thêm đơn ở trạng thái chờ duyệt, gán id sinh ra
     * cho đơn, lưu các dòng chi tiết (OrderDetailDAO1.saveOrderDetails()) và xoá các mặt hàng đã đặt
     * khỏi giỏ hàng (CartDAO1.clearCart()); có lỗi thì huỷ toàn bộ.
     * @param order đơn hàng đã đóng gói (ngày đặt, địa chỉ, số điện thoại, trạng thái, khách hàng, các dòng chi tiết)
     * @param idCart id của giỏ hàng
     * @param listCartItem các dòng giỏ hàng được chọn
     * @return true nếu lưu thành công
     */
    public boolean saveOrder(OnlineOrder1 order, int idCart, ArrayList<CartItem1> listCartItem) {
        if ((order.getDetails() == null) || (order.getDetails().size() == 0)) return false;
        boolean kq = false;
        String sqlThem = "INSERT INTO tblOnlineOrder1(orderDate, deliveryAddress, receiverPhone, status, tblCustomer1id) "
                + "VALUES(?,?,?,?,?)";
        try {
            con.setAutoCommit(false);
            PreparedStatement ps = con.prepareStatement(sqlThem, Statement.RETURN_GENERATED_KEYS);
            ps.setDate(1, new java.sql.Date(order.getOrderDate().getTime()));
            ps.setString(2, order.getDeliveryAddress());
            ps.setString(3, order.getReceiverPhone());
            ps.setString(4, order.getStatus());
            ps.setInt(5, order.getCustomer().getId());
            ps.executeUpdate();
            ResultSet key = ps.getGeneratedKeys();
            if (key.next()) {
                order.setId(key.getInt(1));
            }
            // luu cac dong chi tiet don hang
            boolean okChitiet = (new OrderDetailDAO1()).saveOrderDetails(order.getId(), order.getDetails());
            // xoa cac mat hang da dat khoi gio hang
            boolean okGio = okChitiet && (new CartDAO1()).clearCart(idCart, listCartItem);
            if (okChitiet && okGio) {
                con.commit();
                kq = true;
            } else {
                con.rollback();
                order.setId(0);
            }
        } catch (Exception e) {
            try {
                con.rollback();
            } catch (Exception ee) {
                ee.printStackTrace();
            }
            order.setId(0);
            e.printStackTrace();
            kq = false;
        } finally {
            try {
                con.setAutoCommit(true);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return kq;
    }
}
