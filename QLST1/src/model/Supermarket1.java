package model;

/**
 * Lớp thực thể Supermarket1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class Supermarket1 {
    private int id;
    private String name;
    private String phone;
    private String description;
    private Address1 address;
    private Warehouse1 warehouse;
    private SalesFloor1 salesFloor;

    public Supermarket1() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Address1 getAddress() {
        return address;
    }

    public void setAddress(Address1 address) {
        this.address = address;
    }

    public Warehouse1 getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(Warehouse1 warehouse) {
        this.warehouse = warehouse;
    }

    public SalesFloor1 getSalesFloor() {
        return salesFloor;
    }

    public void setSalesFloor(SalesFloor1 salesFloor) {
        this.salesFloor = salesFloor;
    }
}
