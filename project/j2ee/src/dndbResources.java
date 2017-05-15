import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.Order;
import javax.ejb.*;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import dndbModels.*;
import java.awt.*;
import static jdk.nashorn.internal.runtime.PropertyDescriptor.GET;

/*
 *
 * Created by nwd3 on 5/10/2017.
 *
 * Notes ON Project 5 Extensions Java ee part:
 *
 *
 * Note orders and partorder has my many to one and one to many relationship generated by system.  These can
 * be useful to see the different orders and part orders per creation.Also:
 * I created the many to many relationship as defined in Part.java useful to see how many orders per part
 * for management of what parts are assigned to what orders and the value of each order can be comparteed to the part
 *
 *
 *
 * The get, put, and post methods are valuable as outlined for the following reasons
 *
 * Get: Discussion of importance Methods Implemented Below
 The get methods in general would be valuable to developers by allowing them to access the data from the database in the following implementations
 but making the result easier and cleaner to see.
 * Note:Get employees/id
 *  Very valuable if you want to be able to easily access the properties of an employee based on their id.
 A developer would be able to 
        add to how the information is displayed to be able to make it more user friendly.
 * Note: Get orders/id
 *      Very valuable if you want to be able to easily access the properties of an order based on their id.
 A developer would be able to 
        add to how the information is displayed to be able to make it more user friendly.
 *Note: Get part/id
        This would be valuable to be able to get the desired part when I need to know information about that specific part.
        A developer would be able to 
        add to how the information is displayed to be able to make it more user friendly.
 *Note: Get customer/id
        This would be extremely valuable to access the properties of a specific customer.  A developer would be able to 
        add to how the information is displayed to be able to make it more user friendly.
        
 *  Put: Method's importance discussed here implemented below
 A developer would be able to add to this framework and create a system where it would be easier to input the information you 
 wanted to modify in the corresponding entity.
 *  Note Put/ employee/x
 *      very valuable for modifying a given person with the inputted information.  If I am updating an employee's information this
 *  would be very valuable
 *  Note Put /customer/x
 *      This is very useful to be able to modify a customer say if they changed their address with the necessary fields
 *  Note Put /orders/x
 *      This is also valuable ecspecially because I would update the orders fields a lot because I am attempting to update
 *  when the order has acutally shipped.
 *  Note Put /part/x
 *      This could be useful ecspecially because I would do a lot of upkeep on the quanity of parts available so this
 *  would help with that
 *
 *
 *  Post: Method's importance discussed here implemented below
 A developer would use these post methods to create a more user friendly platform where a new employee, customer,and order could be
 created and stored in the databse.
 *  Note Post/employee/id
 *      This is very useful this allows the user to input a valid employee object  to update the database
 *  Note Post /customer/id
 *   This is very useful because all I have to do is add a new customer by inserting the attributes into the cstomer.
 *  Note Post /order/id
 *      This is also useful to quickly add an order based on the attributes I add
 *
 
 *  Delete Importance Methods discussed here implemented below
 *A developer would be able to use the delete methods implemented below to allow for a more user friendly application to delete the employee, order, or customer.
 The groundwork is laid for this to happen.
 Note delete/employees/id
 *      Also very useful to quickly delete an employee if he or she is not working with us.
 *  Note delete/orders/id
 *      Not so useful becuase we propably would never want to delete our order just modify them.
 *  Note delete/part/id
 *      Useful if we no longer use a part anymore.
 *  Note delete/customer/id
 *      Not so useful becuase we propably would never want to delete our customers just modify them.
 *
 */


/**
*Class: dndbResoruces
* The Java class will be hosted at the URI path "/dndb"
* The Java class will host the get,put,post,and delete methods for the dndbResources class
*
* @author Nathanael Dick
* @version Spring, 2017
************************************************************************/
@Stateless
@Path("dndb")
public class dndbResources {
    @PersistenceContext
    private EntityManager em;

 /*These Java method will process HTTP GET requests
  *informative method to connect to the database
  ************************************************/
    @GET
    @Path("hello")
    @Produces("text/plain")
    public String getClichedMessage() {
        return "Hello, dndb Database!";
    }

    /*get all the employee ids
    *at /employee{param}
    ************************************************/
    @GET
    @Path("employee/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    //get the orders based off the id of the order
    public Employees getEmployee(@PathParam("id") long id) {
        return em.find(Employees.class, id);
    }

    /*gets the orders based off the order id
     *at orders/{param}
     ************************************************/
    @GET
    @Path("orders/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Orders getOrders(@PathParam("id") long id) {
        return em.find(Orders.class, id);
    }

    //gets the parts based off the id
    @GET
    @Path("part/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Part getPart(@PathParam("id") long id) {
        return em.find(Part.class, id);
    }

//gets the customer based off the id
    @GET
    @Path("customer/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Customer getCustomer(@PathParam("id") long id) {
        return em.find(Customer.class, id);
    }

    //puts the employee based off the id
    @Path("/employee/{x}")
    @PUT
    @Consumes("application/json")
    @Produces("application/json")
    public Employees modifyEmployee(@PathParam("x") long x, Employees EmployeesIn){
        Employees emp1 = em.find(Employees.class, x);
        long d = emp1.getEmployeeNumber();
        emp1 = EmployeesIn;
        emp1.setEmployeeNumber(x);
        em.merge(emp1);
        return emp1;
    }
    //puts the order based on the id
    @Path("/order/{x}")
    @PUT
    @Consumes("application/json")
    @Produces("application/json")
    public Orders modifyOrder(@PathParam("x") long x, Orders orderIn){
        Orders o = em.find(Orders.class, x);
        long d = o.getOrderNum();
        o = orderIn;
        o.setOrderNum(x);
        em.merge(o);
        return o;
    }

    //puts the customer based on the id
    @Path("/customer/{x}")
    @PUT
    @Consumes("application/json")
    @Produces("application/json")
    public Customer modifyCustomer(@PathParam("x") long x, Customer custIn){
        Customer o = em.find(Customer.class, x);
        long d = o.getCustNum();
        o = custIn;
        o.setCustNum(x);
        em.merge(o);
        return o;
    }

    /*
    *uses /part/{param}
    *puts the part based on the id
    */
    @Path("/part/{x}")
    @PUT
    @Consumes("application/json")
    @Produces("application/json")
    public Part modifyPart(@PathParam("x") long x, Part partIn){
        Part o = em.find(Part.class, x);
        long d = o.getId();
        o = partIn;
        o.setId(x);
        em.merge(o);
        return o;
    }

    //post methods
    //posts based on the imputted employee object
    @POST
    @Path("/Employee")
    @Consumes("application/json")
    @Produces("application/json")
    public Employees AddEmp(Employees empin){
        em.persist(empin);
        return empin;
    }
    //post based on the order object
    @POST
    @Path("/orders")
    @Consumes("application/json")
    @Produces("application/json")
    public Orders AddOrder(Order orderin){
        em.persist(orderin);
        return orderin;
    }

    /*
    *uses/part
    *post part based on the object inputted   
    */
    @POST
    @Path("/part")
    @Consumes("application/json")
    @Produces("application/json")
    public Part AddPerson(Part partin){
        em.persist(partin);
        return partin;
    }
        
   /*uses:/customer
    post method the customer based on the inputted object
    */
    @POST
    @Path("/customer")
    @Consumes("application/json")
    @Produces("application/json")
    public Customer AddCustomer(Customer custIn){
        em.persist(custIn);
        return custIn;
    }
    //delete parts

    //deletes the employee based on the id
    @DELETE
    @Path("/employee/{x}")
    @Consumes("text/plain")
    @Produces("text/plain")
    public String deleteEmployee(@PathParam("x") long id){
        if(em.find(Employees.class,id)==null){
            return "employee Not Found Try Again.";
        }else {
            Employees p = em.find(Employees.class, id);
            em.remove(p);
            return "you have deleted the employee";
        }
    }
    //deletes the order based on the id
    @DELETE
    @Path("/order/{x}")
    @Consumes("text/plain")
    @Produces("text/plain")
    public String deleteOrder(@PathParam("x") long id){
        if(em.find(Orders.class,id)==null){
            return "Order Not Found Try Again.";
        }else {
            Orders p = em.find(Orders.class, id);
            em.remove(p);
            return "you have deleted the order";
        }
    }
        //deletes the part based on the id
    @DELETE
    @Path("/part/{x}")
    @Consumes("text/plain")
    @Produces("text/plain")
    public String deletePart(@PathParam("x") long id){
        if(em.find(Part.class,id)==null){
            return "Part Not Found Try Again.";
        }else {
            Part p = em.find(Part.class, id);
            em.remove(p);
            return "you have deleted the part";
        }
    }

    //deletes the customer based on the id
    @DELETE
    @Path("/customer/{x}")
    @Consumes("text/plain")
    @Produces("text/plain")
    public String deleteCustomer(@PathParam("x") long id){
        if(em.find(Customer.class,id)==null){
            return "Customer Not Found Try Again.";
        }else {
            Customer p = em.find(Customer.class, id);
            em.remove(p);
            return "you have deleted the customer";
        }
    }
}
