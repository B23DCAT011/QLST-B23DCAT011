package model;

import java.util.ArrayList;

/**
 * Lớp thực thể Salesperson1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class Salesperson1 extends Employee1 {
    private Counter1 counter;
    private ArrayList<Invoice1> invoices;

    public Salesperson1() {
        super();
    }

    public Counter1 getCounter() {
        return counter;
    }

    public void setCounter(Counter1 counter) {
        this.counter = counter;
    }

    public ArrayList<Invoice1> getInvoices() {
        return invoices;
    }

    public void setInvoices(ArrayList<Invoice1> invoices) {
        this.invoices = invoices;
    }
}
