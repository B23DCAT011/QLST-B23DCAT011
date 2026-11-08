package dao;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.UnitOfMeasure1;

/**
 * Truy xuất dữ liệu đơn vị tính (bảng tblUnitOfMeasure1).
 */
public class UnitOfMeasureDAO1 extends DAO1 {

    public UnitOfMeasureDAO1() {
        super();
    }

    /**
     * Lấy toàn bộ đơn vị tính để đổ vào combo Đơn vị tính của form sửa.
     * @return danh sách đơn vị tính
     */
    public ArrayList<UnitOfMeasure1> getAllUnits() {
        ArrayList<UnitOfMeasure1> kq = new ArrayList<UnitOfMeasure1>();
        String sql = "{call getAllUnits()}"; // su dung stored procedure
        try {
            CallableStatement cs = con.prepareCall(sql);
            ResultSet rs = cs.executeQuery();
            while (rs.next()) {
                UnitOfMeasure1 u = new UnitOfMeasure1();
                u.setId(rs.getInt("id"));
                u.setName(rs.getString("name"));
                kq.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return kq;
    }
}
