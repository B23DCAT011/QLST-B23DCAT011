package dao;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Brand1;

/**
 * Truy xuất dữ liệu hãng sản xuất (bảng tblBrand1).
 */
public class BrandDAO1 extends DAO1 {

    public BrandDAO1() {
        super();
    }

    /**
     * Lấy toàn bộ hãng sản xuất để đổ vào combo Hãng sản xuất của form sửa.
     * @return danh sách hãng sản xuất
     */
    public ArrayList<Brand1> getAllBrands() {
        ArrayList<Brand1> kq = new ArrayList<Brand1>();
        String sql = "{call getAllBrands()}"; // su dung stored procedure
        try {
            CallableStatement cs = con.prepareCall(sql);
            ResultSet rs = cs.executeQuery();
            while (rs.next()) {
                Brand1 b = new Brand1();
                b.setId(rs.getInt("id"));
                b.setName(rs.getString("name"));
                b.setCountry(rs.getString("country"));
                b.setDescription(rs.getString("description"));
                kq.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return kq;
    }
}
