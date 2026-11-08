package dao;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Category1;

/**
 * Truy xuất dữ liệu loại mặt hàng (bảng tblCategory1).
 */
public class CategoryDAO1 extends DAO1 {

    public CategoryDAO1() {
        super();
    }

    /**
     * Lấy toàn bộ loại mặt hàng để đổ vào combo Loại mặt hàng của form sửa.
     * @return danh sách loại mặt hàng
     */
    public ArrayList<Category1> getAllCategories() {
        ArrayList<Category1> kq = new ArrayList<Category1>();
        String sql = "{call getAllCategories()}"; // su dung stored procedure
        try {
            CallableStatement cs = con.prepareCall(sql);
            ResultSet rs = cs.executeQuery();
            while (rs.next()) {
                Category1 c = new Category1();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setDescription(rs.getString("description"));
                kq.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return kq;
    }
}
