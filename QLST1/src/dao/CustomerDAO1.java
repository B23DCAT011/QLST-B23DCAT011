package dao;

import java.sql.CallableStatement;
import java.sql.ResultSet;

import model.Address1;
import model.Customer1;
import model.FullName1;

/**
 * Truy xuất dữ liệu khách hàng (bảng tblCustomer1 nối tblMember1, tblAddress1).
 */
public class CustomerDAO1 extends DAO1 {

    public CustomerDAO1() {
        super();
    }

    /**
     * Lấy thông tin liên hệ của khách hàng để điền sẵn địa chỉ giao hàng, số điện thoại nhận hàng.
     * @param idCustomer id của khách hàng
     * @return khách hàng (kèm họ tên, địa chỉ), null nếu không có
     */
    public Customer1 getCustomerInfo(int idCustomer) {
        Customer1 kq = null;
        String sql = "{call getCustomerInfo(?)}"; // su dung stored procedure
        try {
            CallableStatement cs = con.prepareCall(sql);
            cs.setInt(1, idCustomer);
            ResultSet rs = cs.executeQuery();
            if (rs.next()) {
                kq = new Customer1();
                kq.setId(rs.getInt("id"));
                kq.setDateOfBirth(rs.getDate("dateOfBirth"));
                kq.setGender(rs.getString("gender"));
                kq.setEmail(rs.getString("email"));
                kq.setPhone(rs.getString("phone"));
                kq.setNote(rs.getString("note"));
                kq.setRegisterDate(rs.getDate("registerDate"));
                kq.setLoyaltyPoints(rs.getInt("loyaltyPoints"));
                // ho ten
                FullName1 fn = new FullName1();
                fn.setFamilyName(rs.getString("familyName"));
                fn.setMiddleName(rs.getString("middleName"));
                fn.setGivenName(rs.getString("givenName"));
                kq.setFullName(fn);
                // dia chi
                Address1 ad = new Address1();
                ad.setId(rs.getInt("idAddress"));
                ad.setHouseNumber(rs.getString("houseNumber"));
                ad.setStreet(rs.getString("street"));
                ad.setWard(rs.getString("ward"));
                ad.setDistrict(rs.getString("district"));
                ad.setProvince(rs.getString("province"));
                kq.setAddress(ad);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return kq;
    }
}
