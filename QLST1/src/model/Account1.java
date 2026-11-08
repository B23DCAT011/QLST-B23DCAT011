package model;

/**
 * Lớp thực thể Account1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class Account1 {
    private int id;
    private String username;
    private String password;
    private String status;

    public Account1() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
