package dndbModels;

import javax.persistence.*;
import java.sql.Time;
import java.util.Collection;

/**
 * Created by nwd3 on 5/11/2017.
 */
@Entity
public class Orders {
    private long orderNum;
    private Time dateOrdered;
    private Time expShipDate;
    private Time actShipDate;
    private Long employeeNumber;
    private Long custNum;
    private Long quantity;
    private Long totalOrderValue;
    private Employees employeesByEmployeeNumber;
    private Customer customerByCustNum;
    private Collection<Partorder> partordersByOrderNum;

    @Id
    @Column(name = "ORDER_NUM")
    public long getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(long orderNum) {
        this.orderNum = orderNum;
    }

    @Basic
    @Column(name = "DATE_ORDERED")
    public Time getDateOrdered() {
        return dateOrdered;
    }

    public void setDateOrdered(Time dateOrdered) {
        this.dateOrdered = dateOrdered;
    }

    @Basic
    @Column(name = "EXP_SHIP_DATE")
    public Time getExpShipDate() {
        return expShipDate;
    }

    public void setExpShipDate(Time expShipDate) {
        this.expShipDate = expShipDate;
    }

    @Basic
    @Column(name = "ACT_SHIP_DATE")
    public Time getActShipDate() {
        return actShipDate;
    }

    public void setActShipDate(Time actShipDate) {
        this.actShipDate = actShipDate;
    }

    @Basic
    @Column(name = "EMPLOYEE_NUMBER")
    public Long getEmployeeNumber() {
        return employeeNumber;
    }

    public void setEmployeeNumber(Long employeeNumber) {
        this.employeeNumber = employeeNumber;
    }

    @Basic
    @Column(name = "CUST_NUM")
    public Long getCustNum() {
        return custNum;
    }

    public void setCustNum(Long custNum) {
        this.custNum = custNum;
    }

    @Basic
    @Column(name = "QUANTITY")
    public Long getQuantity() {
        return quantity;
    }

    public void setQuantity(Long quantity) {
        this.quantity = quantity;
    }

    @Basic
    @Column(name = "TOTAL_ORDER_VALUE")
    public Long getTotalOrderValue() {
        return totalOrderValue;
    }

    public void setTotalOrderValue(Long totalOrderValue) {
        this.totalOrderValue = totalOrderValue;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Orders orders = (Orders) o;

        if (orderNum != orders.orderNum) return false;
        if (dateOrdered != null ? !dateOrdered.equals(orders.dateOrdered) : orders.dateOrdered != null) return false;
        if (expShipDate != null ? !expShipDate.equals(orders.expShipDate) : orders.expShipDate != null) return false;
        if (actShipDate != null ? !actShipDate.equals(orders.actShipDate) : orders.actShipDate != null) return false;
        if (employeeNumber != null ? !employeeNumber.equals(orders.employeeNumber) : orders.employeeNumber != null)
            return false;
        if (custNum != null ? !custNum.equals(orders.custNum) : orders.custNum != null) return false;
        if (quantity != null ? !quantity.equals(orders.quantity) : orders.quantity != null) return false;
        if (totalOrderValue != null ? !totalOrderValue.equals(orders.totalOrderValue) : orders.totalOrderValue != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (orderNum ^ (orderNum >>> 32));
        result = 31 * result + (dateOrdered != null ? dateOrdered.hashCode() : 0);
        result = 31 * result + (expShipDate != null ? expShipDate.hashCode() : 0);
        result = 31 * result + (actShipDate != null ? actShipDate.hashCode() : 0);
        result = 31 * result + (employeeNumber != null ? employeeNumber.hashCode() : 0);
        result = 31 * result + (custNum != null ? custNum.hashCode() : 0);
        result = 31 * result + (quantity != null ? quantity.hashCode() : 0);
        result = 31 * result + (totalOrderValue != null ? totalOrderValue.hashCode() : 0);
        return result;
    }
    @ManyToOne
    @JoinColumn(name = "EMPLOYEE_NUMBER", referencedColumnName = "EMPLOYEE_NUMBER")
    public Employees getEmployeesByEmployeeNumber() {
        return employeesByEmployeeNumber;
    }

    public void setEmployeesByEmployeeNumber(Employees employeesByEmployeeNumber) {
        this.employeesByEmployeeNumber = employeesByEmployeeNumber;
    }

    @ManyToOne
    @JoinColumn(name = "CUST_NUM", referencedColumnName = "CUST_NUM")
    public Customer getCustomerByCustNum() {
        return customerByCustNum;
    }

    public void setCustomerByCustNum(Customer customerByCustNum) {
        this.customerByCustNum = customerByCustNum;
    }

    @OneToMany(mappedBy = "ordersByOrderNum")
    public Collection<Partorder> getPartordersByOrderNum() {
        return partordersByOrderNum;
    }

    public void setPartordersByOrderNum(Collection<Partorder> partordersByOrderNum) {
        this.partordersByOrderNum = partordersByOrderNum;
    }
}
