package model;

/**
 * Lớp thực thể FullName1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class FullName1 {
    private int id;
    private String familyName;
    private String middleName;
    private String givenName;

    public FullName1() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFamilyName() {
        return familyName;
    }

    public void setFamilyName(String familyName) {
        this.familyName = familyName;
    }

    public String getMiddleName() {
        return middleName;
    }

    public void setMiddleName(String middleName) {
        this.middleName = middleName;
    }

    public String getGivenName() {
        return givenName;
    }

    public void setGivenName(String givenName) {
        this.givenName = givenName;
    }
}
