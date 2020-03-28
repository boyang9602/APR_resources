import org.junit.runner.JUnitCore;
import org.junit.runner.Request;
import org.junit.runner.Result;

public class TestRunner {
    public static void main(String... args) throws ClassNotFoundException {
        int retCode = 0;
        String resultMessage = "SUCCESS";
        for(String cm :  args) {
            String[] classAndMethod = cm.split("::");
            Request request = Request.method(Class.forName(classAndMethod[0]), classAndMethod[1]);
            Result result = new JUnitCore().run(request);
            if (!result.wasSuccessful()) {
                //retCode = 1;
                resultMessage = "FAILURE";
            } else {
	        resultMessage = "SUCCESS";
	    }
            System.out.println(resultMessage);
        }
        System.exit(retCode);
    }
}
