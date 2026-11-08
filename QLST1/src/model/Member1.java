package model;

import java.util.Date;

/**
 * Lớp thực thể Member1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class Member1 {
    private int id;
    private FullName1 fullName;
    private Address1 address;
    private Account1 account;
    private Date dateOfBirth;
    private String gender;
    private String email;
    private String phone;
    private String note;

    public Member1() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public FullName1 getFullName() {
        return fullName;
    }

    public void setFullName(FullName1 fullName) {
        this.fullName = fullName;
    }

    public Address1 getAddress() {
        return address;
    }

    public void setAddress(Address1 address) {
        this.address = address;
    }

    public Account1 getAccount() {
        return account;
    }

    public void setAccount(Account1 account) {
        this.account = account;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
}
