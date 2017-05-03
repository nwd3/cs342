/**
 * This stateless session bean serves as a RESTful resource handler for the CPDB.
 * It uses a container-managed entity manager.
 *
 * @author kvlinden
 * @version Spring, 2017
 */
import jdk.nashorn.internal.objects.annotations.Constructor;
import models.Person;
import javax.persistence.EntityManager;
import javax.persistence.GeneratedValue;
import javax.persistence.PersistenceContext;
import javax.persistence.SequenceGenerator;
import javax.ws.rs.*;
import javax.ejb.*;
import javax.ws.rs.core.MediaType;
import java.util.InputMismatchException;
import java.util.List;

@Stateless
@Path("cpdb")
public class CPDBResource {

    /**
     * JPA creates and maintains a managed entity manager with an integrated JTA that we can inject here.
     *     E.g., http://wiki.eclipse.org/EclipseLink/Examples/REST/GettingStarted
     */
    @PersistenceContext
    private EntityManager em;

    /**
     * GET a default message.
     *
     * @return a static hello-world message
     */
    @GET
    @Path("hello")
    @Produces("text/plain")
    public String getClichedMessage() {
        return "Hello, JPA!";
    }

    /**
     * GET an individual person record.
     *
     * @param id the ID of the person to retrieve
     * @return a person record
     */
    @GET
    @Path("person/{id}")
    @Produces(MediaType.APPLICATION_JSON)

    public Person getPerson(@PathParam("id") long id) {
        return em.find(Person.class, id);
    }

    /**
     * GET all people using the criteria query API.
     * This could be refactored to use a JPQL query, but this entitymanager-based approach
     * is consistent with the other handlers.
     *
     * @return a list of all person records
     */
    @GET
    @Path("people")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Person> getPeople() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(Person.class)).getResultList();
    }
//what is the given person entity
    @Path("/person/{x}")
    @PUT
    @Consumes("application/json")
    @Produces("application/json")
    public String modify(@PathParam("x") long x, Person PersonIn){
     //  try {
        if(em.find(Person.class,x)==null){
            return "Person Not Found Try Again.";
        }
        else {
            Person Person1 = em.find(Person.class, x);
            long d = Person1.getId();
            Person1 = PersonIn;
            Person1.setId(x);
            em.merge(Person1);
            return "Person modified";
        }

    }
  //post method
    @POST
    @Path("/people")
    @Consumes("application/json")
    @Produces("application/json")
    //@Produces("application/json")
    public void AddPerson(Person inPerson){
       // inPerson.setId();
        em.persist(inPerson);
    }

    //delete part
    @DELETE
    @Path("/person/{x}")
    @Consumes("text/plain")
    @Produces("text/plain")
    public void DeletePerson(@PathParam("x") long id){
        Person p =em.find(Person.class, id);
        em.remove(p);
    }
}