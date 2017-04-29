import javax.ws.rs.*;
import javax.ws.rs.POST;
import javax.ws.rs.core.Response;


@Path("/hello")
public class HelloWorld {
    @Path("/Get")
    @GET
    @Produces("text/plain")
    public String getClichedMessage() {
        // Return some cliched textual content
        return "Getting";
    }

    @Path("/Put")
    @PUT
    @Produces("text/plain")
    @Consumes("text/plain")
    public String adv(int in) {
        return "Putting:" + in;
    }

    @Path("/Post")
    @POST
    @Produces("text/plain")
    @Consumes("text/plain")
    public String afd( String in) {
        // Return some cliched textual content
        return "Posting: " + in;
    }

    @Path("/Delete/{x}")
    @DELETE
    @Produces("text/plain")
    public String ReturnX(@PathParam("x") int x) {
        return "Deleting: " + x;
    }
}
