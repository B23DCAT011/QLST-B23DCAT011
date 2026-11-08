package model;

import java.util.Date;

/**
 * Lớp thực thể Employee1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class Employee1 extends Member1 {
    private String position;
    private Date hireDate;

    public Employee1() {
        super();
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public Date getHireDate() {
        return hireDate;
    }

    public void setHireDate(Date hireDate) {
        this.hireDate = hireDate;
    }
}
