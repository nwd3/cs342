package dndbModels;

import javax.persistence.*;
import java.util.Collection;

/**
 * Created by nwd3 on 5/11/2017.
 */
@Entity
public class Employees {
    private long employeeNumber;
    private String firstname;
    private String lastname;
    private String emailAddress;
    private Collection<Orders> ordersesByEmployeeNumber;

    @Id
    @Column(name = "EMPLOYEE_NUMBER")
    public long getEmployeeNumber() {
        return employeeNumber;
    }

    public void setEmployeeNumber(long employeeNumber) {
        this.employeeNumber = employeeNumber;
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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Employees employees = (Employees) o;

        if (employeeNumber != employees.employeeNumber) return false;
        if (firstname != null ? !firstname.equals(employees.firstname) : employees.firstname != null) return false;
        if (lastname != null ? !lastname.equals(employees.lastname) : employees.lastname != null) return false;
        if (emailAddress != null ? !emailAddress.equals(employees.emailAddress) : employees.emailAddress != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (employeeNumber ^ (employeeNumber >>> 32));
        result = 31 * result + (firstname != null ? firstname.hashCode() : 0);
        result = 31 * result + (lastname != null ? lastname.hashCode() : 0);
        result = 31 * result + (emailAddress != null ? emailAddress.hashCode() : 0);
        return result;
    }

//    @OneToMany(mappedBy = "employeesByEmployeeNumber")
//    public Collection<Orders> getOrdersesByEmployeeNumber() {
//        return ordersesByEmployeeNumber;
//    }
//
//    public void setOrdersesByEmployeeNumber(Collection<Orders> ordersesByEmployeeNumber) {
//        this.ordersesByEmployeeNumber = ordersesByEmployeeNumber;
//    }
}
