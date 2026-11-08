package dao;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import model.Brand1;
import model.Cart1;
import model.CartItem1;
import model.Item1;

/**
 * Truy xuất dữ liệu dòng giỏ hàng (bảng tblCartItem1).
 */
public class CartItemDAO1 extends DAO1 {

    public CartItemDAO1() {
        super();
    }

    /**
     * Thêm mặt hàng vào giỏ hàng. Giỏ chưa có trong CSDL (id = 0) thì tạo giỏ trước;
     * mặt hàng đã có trong giỏ thì cộng dồn số lượng (ngoại lệ 8.1), chưa có thì thêm dòng mới
     * với đơn giá bằng giá bán tại thời điểm thêm.
     * @param cart giỏ hàng đang dùng (id được gán lại nếu giỏ vừa được tạo)
     * @param item mặt hàng được chọn
     * @param quantity số lượng khách hàng nhập
     * @return true nếu thêm thành công
     */
    public boolean addCartItem(Cart1 cart, Item1 item, int quantity) {
        boolean kq = false;
        String sqlTaoGio = "INSERT INTO tblCart1(createdDate, status, tblCustomer1id) VALUES(CURDATE(), 'đang dùng', ?)";
        String sqlCongDon = "UPDATE tblCartItem1 SET quantity = quantity + ? WHERE tblCart1id = ? AND tblItem1id = ?";
        String sqlThem = "INSERT INTO tblCartItem1(quantity, unitPrice, tblCart1id, tblItem1id) VALUES(?,?,?,?)";
        try {
            con.setAutoCommit(false);
            // tao gio hang neu khach hang chua co gio dang dung
            if (cart.getId() == 0) {
                PreparedStatement psGio = con.prepareStatement(sqlTaoGio, Statement.RETURN_GENERATED_KEYS);
                psGio.setInt(1, cart.getCustomer().getId());
                psGio.executeUpdate();
                ResultSet key = psGio.getGeneratedKeys();
                if (key.next()) {
                    cart.setId(key.getInt(1));
                }
            }
            // cong don neu mat hang da co trong gio
            PreparedStatement psCong = con.prepareStatement(sqlCongDon);
            psCong.setInt(1, quantity);
            psCong.setInt(2, cart.getId());
            psCong.setInt(3, item.getId());
            if (psCong.executeUpdate() == 0) {
                // them dong moi
                PreparedStatement psThem = con.prepareStatement(sqlThem);
                psThem.setInt(1, quantity);
                psThem.setFloat(2, item.getSellingPrice());
                psThem.setInt(3, cart.getId());
                psThem.setInt(4, item.getId());
                psThem.executeUpdate();
            }
            con.commit();
            kq = true;
        } catch (Exception e) {
            try {
                con.rollback();
            } catch (Exception ee) {
                ee.printStackTrace();
            }
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

    /**
     * Lấy các dòng của giỏ hàng (kèm mặt hàng).
     * @param idCart id của giỏ hàng
     * @return danh sách dòng giỏ hàng (rỗng nếu giỏ chưa có dòng nào)
     */
    public ArrayList<CartItem1> getCartItems(int idCart) {
        ArrayList<CartItem1> kq = new ArrayList<CartItem1>();
        String sql = "{call getCartItems(?)}"; // su dung stored procedure
        try {
            CallableStatement cs = con.prepareCall(sql);
            cs.setInt(1, idCart);
            ResultSet rs = cs.executeQuery();
            while (rs.next()) {
                CartItem1 ci = new CartItem1();
                ci.setId(rs.getInt("id"));
                ci.setQuantity(rs.getInt("quantity"));
                ci.setUnitPrice(rs.getFloat("unitPrice"));
                // mat hang
                Item1 it = new Item1();
                it.setId(rs.getInt("idItem"));
                it.setName(rs.getString("itemName"));
                it.setSellingPrice(rs.getFloat("sellingPrice"));
                Brand1 b = new Brand1();
                b.setName(rs.getString("brandName"));
                it.setBrand(b);
                ci.setItem(it);
                kq.add(ci);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return kq;
    }

    /**
     * Cập nhật số lượng của một dòng giỏ hàng (ngoại lệ 11.1).
     * @param cartItem dòng giỏ hàng với số lượng mới
     * @return true nếu cập nhật thành công
     */
    public boolean updateCartItem(CartItem1 cartItem) {
        boolean kq = false;
        String sql = "UPDATE tblCartItem1 SET quantity = ? WHERE id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, cartItem.getQuantity());
            ps.setInt(2, cartItem.getId());
            kq = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            kq = false;
        }
        return kq;
    }

    /**
     * Xoá một dòng khỏi giỏ hàng (ngoại lệ 11.2).
     * @param idCartItem id của dòng giỏ hàng
     * @return true nếu xoá thành công
     */
    public boolean deleteCartItem(int idCartItem) {
        boolean kq = false;
        String sql = "DELETE FROM tblCartItem1 WHERE id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, idCartItem);
            kq = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            kq = false;
        }
        return kq;
    }
}
