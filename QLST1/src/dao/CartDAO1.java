package dao;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Cart1;
import model.CartItem1;
import model.Customer1;
import model.Item1;

/**
 * Truy xuất dữ liệu giỏ hàng (bảng tblCart1).
 */
public class CartDAO1 extends DAO1 {

    public CartDAO1() {
        super();
    }

    /**
     * Lấy giỏ hàng đang dùng của khách hàng, kèm các dòng của giỏ.
     * Khách hàng chưa có giỏ đang dùng thì trả về giỏ rỗng có id = 0
     * (giỏ được tạo trong CSDL khi thêm mặt hàng đầu tiên - CartItemDAO1.addCartItem()).
     * @param idCustomer id của khách hàng
     * @return giỏ hàng đang dùng
     */
    public Cart1 getActiveCart(int idCustomer) {
        Cart1 kq = new Cart1();
        Customer1 cus = new Customer1();
        cus.setId(idCustomer);
        kq.setCustomer(cus);
        kq.setStatus("đang dùng");
        kq.setItems(new ArrayList<CartItem1>());
        String sql = "{call getActiveCart(?)}"; // su dung stored procedure
        try {
            CallableStatement cs = con.prepareCall(sql);
            cs.setInt(1, idCustomer);
            ResultSet rs = cs.executeQuery();
            while (rs.next()) {
                kq.setId(rs.getInt("idCart"));
                kq.setCreatedDate(rs.getDate("createdDate"));
                kq.setStatus(rs.getString("status"));
                if (rs.getInt("idCartItem") > 0) {
                    CartItem1 ci = new CartItem1();
                    ci.setId(rs.getInt("idCartItem"));
                    ci.setQuantity(rs.getInt("quantity"));
                    ci.setUnitPrice(rs.getFloat("unitPrice"));
                    // mat hang
                    Item1 it = new Item1();
                    it.setId(rs.getInt("idItem"));
                    it.setName(rs.getString("itemName"));
                    it.setSellingPrice(rs.getFloat("sellingPrice"));
                    ci.setItem(it);
                    kq.getItems().add(ci);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return kq;
    }

    /**
     * Xoá các mặt hàng đã đặt khỏi giỏ hàng; giỏ không còn dòng nào thì chuyển sang trạng thái
     * "đã đặt hàng". Được gọi trong giao dịch của OnlineOrderDAO1.saveOrder() nên không tự commit.
     * @param idCart id của giỏ hàng
     * @param listCartItem các dòng giỏ hàng đã được chọn để đặt
     * @return true nếu xoá thành công
     */
    public boolean clearCart(int idCart, ArrayList<CartItem1> listCartItem) {
        if ((listCartItem == null) || (listCartItem.size() == 0)) return false;
        boolean kq = false;
        String sqlXoa = "DELETE FROM tblCartItem1 WHERE id = ? AND tblCart1id = ?";
        String sqlTrangthai = "UPDATE tblCart1 SET status = 'đã đặt hàng' WHERE id = ? "
                + "AND NOT EXISTS (SELECT 1 FROM tblCartItem1 WHERE tblCart1id = ?)";
        try {
            for (CartItem1 ci : listCartItem) {
                PreparedStatement psXoa = con.prepareStatement(sqlXoa);
                psXoa.setInt(1, ci.getId());
                psXoa.setInt(2, idCart);
                if (psXoa.executeUpdate() == 0) return false;
            }
            PreparedStatement psTT = con.prepareStatement(sqlTrangthai);
            psTT.setInt(1, idCart);
            psTT.setInt(2, idCart);
            psTT.executeUpdate();
            kq = true;
        } catch (Exception e) {
            e.printStackTrace();
            kq = false;
        }
        return kq;
    }
}
