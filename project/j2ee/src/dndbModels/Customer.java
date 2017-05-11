package dndbModels;

import javax.persistence.*;
import java.util.Collection;

/**
 * Created by nwd3 on 5/11/2017.
 */
@Entity
public class Customer {
    private long custNum;
    private String firstname;
    private String lastname;
    private String emailAddress;
    private String shippingAddress;
    private String gender;
    private String phoneNumber;
    private String street;
    private String city;
    private String state;
    private String zipcode;
    private Collection<Orders> ordersesByCustNum;

    @Id
    @Column(name = "CUST_NUM")
    public long getCustNum() {
        return custNum;
    }

    public void setCustNum(long custNum) {
        this.custNum = custNum;
    }

    @Basic
    @Column(name = "FIRSTNAME")
    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    @Basic
    @Column(name = "LASTNAME")
    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    @Basic
    @Column(name = "EMAIL_ADDRESS")
    public String getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }

    @Basic
    @Column(name = "SHIPPING_ADDRESS")
    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    @Basic
    @Column(name = "GENDER")
    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    @Basic
    @Column(name = "PHONE_NUMBER")
    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    @Basic
    @Column(name = "STREET")
    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    @Basic
    @Column(name = "CITY")
    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    @Basic
    @Column(name = "STATE")
    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    @Basic
    @Column(name = "ZIPCODE")
    public String getZipcode() {
        return zipcode;
    }

    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Customer customer = (Customer) o;

        if (custNum != customer.custNum) return false;
        if (firstname != null ? !firstname.equals(customer.firstname) : customer.firstname != null) return false;
        if (lastname != null ? !lastname.equals(customer.lastname) : customer.lastname != null) return false;
        if (emailAddress != null ? !emailAddress.equals(customer.emailAddress) : customer.emailAddress != null)
            return false;
        if (shippingAddress != null ? !shippingAddress.equals(customer.shippingAddress) : customer.shippingAddress != null)
            return false;
        if (gender != null ? !gender.equals(customer.gender) : customer.gender != null) return false;
        if (phoneNumber != null ? !phoneNumber.equals(customer.phoneNumber) : customer.phoneNumber != null)
            return false;
        if (street != null ? !street.equals(customer.street) : customer.street != null) return false;
        if (city != null ? !city.equals(customer.city) : customer.city != null) return false;
        if (state != null ? !state.equals(customer.state) : customer.state != null) return false;
        if (zipcode != null ? !zipcode.equals(customer.zipcode) : customer.zipcode != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (custNum ^ (custNum >>> 32));
        result = 31 * result + (firstname != null ? firstname.hashCode() : 0);
        result = 31 * result + (lastname != null ? lastname.hashCode() : 0);
        result = 31 * result + (emailAddress != null ? emailAddress.hashCode() : 0);
        result = 31 * result + (shippingAddress != null ? shippingAddress.hashCode() : 0);
        result = 31 * result + (gender != null ? gender.hashCode() : 0);
        result = 31 * result + (phoneNumber != null ? phoneNumber.hashCode() : 0);
        result = 31 * result + (street != null ? street.hashCode() : 0);
        result = 31 * result + (city != null ? city.hashCode() : 0);
        result = 31 * result + (state != null ? state.hashCode() : 0);
        result = 31 * result + (zipcode != null ? zipcode.hashCode() : 0);
        return result;
    }

//a relationship that should work but never got to display anythin see orders and partorder for actual ones that at one point
    //seemed to work
//    @OneToMany(mappedBy = "customerByCustNum")
//    public Collection<Orders> getOrdersesByCustNum() {
//        return ordersesByCustNum;
//    }
//
//    public void setOrdersesByCustNum(Collection<Orders> ordersesByCustNum) {
//        this.ordersesByCustNum = ordersesByCustNum;
//    }
}
