package dndbModels;

import javax.persistence.*;

/**
 * Created by nwd3 on 5/11/2017.
 */
@Entity
public class Partorder {
    private long partordernum;
    private Long pon;
    private Long orderNum;
    private Long quantity;
    private Part partByPon;
    private Orders ordersByOrderNum;

    @Id
    @Column(name = "PARTORDERNUM")
    public long getPartordernum() {
        return partordernum;
    }

    public void setPartordernum(long partordernum) {
        this.partordernum = partordernum;
    }

    @Basic
    @Column(name = "PON")
    public Long getPon() {
        return pon;
    }

    public void setPon(Long pon) {
        this.pon = pon;
    }

    @Basic
    @Column(name = "ORDER_NUM")
    public Long getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(Long orderNum) {
        this.orderNum = orderNum;
    }

    @Basic
    @Column(name = "QUANTITY")
    public Long getQuantity() {
        return quantity;
    }

    public void setQuantity(Long quantity) {
        this.quantity = quantity;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Partorder partorder = (Partorder) o;

        if (partordernum != partorder.partordernum) return false;
        if (pon != null ? !pon.equals(partorder.pon) : partorder.pon != null) return false;
        if (orderNum != null ? !orderNum.equals(partorder.orderNum) : partorder.orderNum != null) return false;
        if (quantity != null ? !quantity.equals(partorder.quantity) : partorder.quantity != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (partordernum ^ (partordernum >>> 32));
        result = 31 * result + (pon != null ? pon.hashCode() : 0);
        result = 31 * result + (orderNum != null ? orderNum.hashCode() : 0);
        result = 31 * result + (quantity != null ? quantity.hashCode() : 0);
        return result;
    }
//
    @ManyToOne
    @JoinColumn(name = "PON", referencedColumnName = "ID")
    public Part getPartByPon() {
        return partByPon;
    }

    public void setPartByPon(Part partByPon) {
        this.partByPon = partByPon;
    }

    @ManyToOne
    @JoinColumn(name = "ORDER_NUM", referencedColumnName = "ORDER_NUM")
    public Orders getOrdersByOrderNum() {
        return ordersByOrderNum;
    }

    public void setOrdersByOrderNum(Orders ordersByOrderNum) {
        this.ordersByOrderNum = ordersByOrderNum;
    }
}