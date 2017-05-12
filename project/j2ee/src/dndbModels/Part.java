package dndbModels;

import javax.persistence.*;
import java.util.Collection;

/**
 * Created by nwd3 on 5/11/2017.
 */
@Entity
public class Part {
    private long id;
    private String type;
    private Long quantity;
    private String partName;
    private String partDesc;
    private Double price;
    private Collection<Orders> ordersByPart;

    @Id
    @Column(name = "ID")
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Basic
    @Column(name = "TYPE")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
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
    @Column(name = "PART_NAME")
    public String getPartName() {
        return partName;
    }

    public void setPartName(String partName) {
        this.partName = partName;
    }

    @Basic
    @Column(name = "PART_DESC")
    public String getPartDesc() {
        return partDesc;
    }

    public void setPartDesc(String partDesc) {
        this.partDesc = partDesc;
    }

    @Basic
    @Column(name = "PRICE")
    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Part part = (Part) o;

        if (id != part.id) return false;
        if (type != null ? !type.equals(part.type) : part.type != null) return false;
        if (quantity != null ? !quantity.equals(part.quantity) : part.quantity != null) return false;
        if (partName != null ? !partName.equals(part.partName) : part.partName != null) return false;
        if (partDesc != null ? !partDesc.equals(part.partDesc) : part.partDesc != null) return false;
        if (price != null ? !price.equals(part.price) : part.price != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (type != null ? type.hashCode() : 0);
        result = 31 * result + (quantity != null ? quantity.hashCode() : 0);
        result = 31 * result + (partName != null ? partName.hashCode() : 0);
        result = 31 * result + (partDesc != null ? partDesc.hashCode() : 0);
        result = 31 * result + (price != null ? price.hashCode() : 0);
        return result;
    }
/*
* @ManyToMany
* this relationship uses a gets all the order with each part
* particulary useful when trying to understand what parts are being sold in the orders
*/
    @ManyToMany
    @JoinTable(name = "Partorder", schema="DNDB",
            joinColumns = @JoinColumn(name = "pon", referencedColumnName = "id",nullable = false),
            inverseJoinColumns = @JoinColumn(name = "order_num",referencedColumnName = "order_num",nullable = false))
    public Collection<Orders> getOrdersByPart(){
        return ordersByPart;
    }
    public void setOrdersByPart(Collection<Orders> ordersByPart){this.ordersByPart=ordersByPart;}

}
