package dao;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;

import model.Brand1;
import model.Category1;
import model.Item1;
import model.UnitOfMeasure1;

/**
 * Truy xuất dữ liệu mặt hàng (bảng tblItem1), dùng cho cả hai module.
 */
public class ItemDAO1 extends DAO1 {

    public ItemDAO1() {
        super();
    }

    /**
     * Tìm các mặt hàng có tên chứa từ khoá.
     * @param name từ khoá tên mặt hàng
     * @param onlyActive false: nhân viên kho xem cả mặt hàng ngừng kinh doanh;
     *                   true: khách hàng chỉ xem mặt hàng đang kinh doanh
     * @return danh sách mặt hàng (rỗng nếu không tìm thấy)
     */
    public ArrayList<Item1> getItemsByName(String name, boolean onlyActive) {
        ArrayList<Item1> kq = new ArrayList<Item1>();
        String sql = "{call getItemsByName(?,?)}"; // su dung stored procedure
        try {
            CallableStatement cs = con.prepareCall(sql);
            cs.setString(1, name);
            cs.setBoolean(2, onlyActive);
            ResultSet rs = cs.executeQuery();
            while (rs.next()) {
                kq.add(wrapItem(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return kq;
    }

    /**
     * Lấy thông tin chi tiết của một mặt hàng (kèm loại, hãng, đơn vị tính).
     * @param idItem id của mặt hàng
     * @return mặt hàng, null nếu không có
     */
    public Item1 getItemDetail(int idItem) {
        Item1 kq = null;
        String sql = "{call getItemDetail(?)}"; // su dung stored procedure
        try {
            CallableStatement cs = con.prepareCall(sql);
            cs.setInt(1, idItem);
            ResultSet rs = cs.executeQuery();
            if (rs.next()) {
                kq = wrapItem(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return kq;
    }

    /**
     * Kiểm tra tên mặt hàng có trùng với một mặt hàng khác không (ngoại lệ 10.3).
     * @param name tên mặt hàng mới
     * @param idItem id của mặt hàng đang sửa (không so với chính nó)
     * @return true nếu trùng
     */
    public boolean checkDuplicateName(String name, int idItem) {
        boolean kq = false;
        String sql = "{call checkDuplicateName(?,?)}"; // su dung stored procedure
        try {
            CallableStatement cs = con.prepareCall(sql);
            cs.setString(1, name);
            cs.setInt(2, idItem);
            ResultSet rs = cs.executeQuery();
            if (rs.next()) {
                kq = rs.getInt("total") > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return kq;
    }

    /**
     * Lưu thông tin mặt hàng đã sửa. Trường hasSerial chỉ hiển thị nên không cập nhật.
     * @param item mặt hàng với các giá trị mới
     * @return true nếu lưu thành công
     */
    public boolean updateItem(Item1 item) {
        boolean kq = false;
        String sql = "UPDATE tblItem1 SET name = ?, sellingPrice = ?, warrantyPeriod = ?, counterSaleMode = ?, "
                + "minShelfQuantity = ?, description = ?, image = ?, tblCategory1id = ?, tblBrand1id = ?, "
                + "tblUnitOfMeasure1id = ? WHERE id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, item.getName());
            ps.setFloat(2, item.getSellingPrice());
            ps.setInt(3, item.getWarrantyPeriod());
            ps.setString(4, item.getCounterSaleMode());
            if (item.getMinShelfQuantity() > 0) {
                ps.setInt(5, item.getMinShelfQuantity());
            } else {
                ps.setNull(5, Types.INTEGER);
            }
            ps.setString(6, item.getDescription());
            ps.setString(7, item.getImage());
            ps.setInt(8, item.getCategory().getId());
            ps.setInt(9, item.getBrand().getId());
            ps.setInt(10, item.getUnit().getId());
            ps.setInt(11, item.getId());
            kq = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            kq = false;
        }
        return kq;
    }

    /**
     * Lấy các mặt hàng đang kinh doanh cùng loại với từ khoá khách hàng đã nhập (ngoại lệ 4.1),
     * ví dụ "tủ đông mini" -> các mặt hàng thuộc loại Tủ đông; tối đa 5 dòng.
     * @param keyword từ khoá khách hàng đã nhập
     * @return danh sách mặt hàng gợi ý (rỗng nếu không có)
     */
    public ArrayList<Item1> getSuggestedItems(String keyword) {
        ArrayList<Item1> kq = new ArrayList<Item1>();
        String sql = "{call getSuggestedItems(?)}"; // su dung stored procedure
        try {
            CallableStatement cs = con.prepareCall(sql);
            cs.setString(1, keyword);
            ResultSet rs = cs.executeQuery();
            while (rs.next()) {
                kq.add(wrapItem(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return kq;
    }

    /**
     * Đóng gói một dòng kết quả thành đối tượng Item1 (kèm Category1, Brand1, UnitOfMeasure1).
     */
    private Item1 wrapItem(ResultSet rs) throws Exception {
        Item1 it = new Item1();
        it.setId(rs.getInt("id"));
        it.setName(rs.getString("name"));
        it.setSellingPrice(rs.getFloat("sellingPrice"));
        it.setWarrantyPeriod(rs.getInt("warrantyPeriod"));
        it.setHasSerial(rs.getBoolean("hasSerial"));
        it.setCounterSaleMode(rs.getString("counterSaleMode"));
        it.setMinShelfQuantity(rs.getInt("minShelfQuantity"));
        it.setDescription(rs.getString("description"));
        it.setImage(rs.getString("image"));
        it.setStatus(rs.getString("status"));
        // loai mat hang
        Category1 c = new Category1();
        c.setId(rs.getInt("tblCategory1id"));
        c.setName(rs.getString("categoryName"));
        it.setCategory(c);
        // hang san xuat
        Brand1 b = new Brand1();
        b.setId(rs.getInt("tblBrand1id"));
        b.setName(rs.getString("brandName"));
        it.setBrand(b);
        // don vi tinh
        UnitOfMeasure1 u = new UnitOfMeasure1();
        u.setId(rs.getInt("tblUnitOfMeasure1id"));
        u.setName(rs.getString("unitName"));
        it.setUnit(u);
        return it;
    }
}
