package poc;

import com.google.gson.Gson;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateExceptionHandler;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RequestCallback;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

/**
 * Created by andrzejtorski on 24.10.16.
 */
@RestController
@RequestMapping("pdf")
public class PdfController {

    private final Configuration configuration;

    public PdfController() {
        configuration = new Configuration();
        configuration.setClassForTemplateLoading(getClass(), "/templates/");
        configuration.setDefaultEncoding("UTF-8");
        configuration.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
    }

    @RequestMapping("/")
    public String index(){
        return "Hello";
    }


    @RequestMapping("/random")
    public void random(HttpServletResponse response) throws IOException, TemplateException, URISyntaxException {
        Map model = new HashMap();
        model.put("randomData", getRandomValues());
        Template template = configuration.getTemplate("test.ftlh");
        RestTemplate restTemplate = new RestTemplate();
        URI url = new URI("http://localhost:3000/generatehtml");
        ResourceReader reader = new StreamResourceReader(response);
        RequestCallback cb = clientHttpRequest -> {
            Writer writer = new OutputStreamWriter(clientHttpRequest.getBody());
            clientHttpRequest.getHeaders().setContentType(MediaType.TEXT_HTML);
            try {
                template.process(model, writer);
            } catch (TemplateException e) {
                System.err.println("Something went terribly wrong.");
                e.printStackTrace();
            }
        };
        restTemplate.execute(url, HttpMethod.POST, cb, new StreamResponseExtractor(reader));
    }

    @RequestMapping("/resp")
    public void getResp() throws MalformedURLException, URISyntaxException {
        RestTemplate template = new RestTemplate();
        Map model = new HashMap();
        model.put("hi", "I am sad");
        model.put("sad", "I am hi");
        URI url = new URI("http://localhost:3000/generatehtml");
        String response = template.postForObject(url, model, String.class);
        System.out.println(response);
    }

    public static String getRandomValues(){
        List<Object[]> randomValues = IntStream.rangeClosed(0, (int) Math.floor(Math.random() * 30))
                .boxed()
                .map(intValue -> {
                    Object[] values = new Object[2];
                    values[0] = "Mushrooms_" + intValue;
                    values[1] = Math.floor(Math.random() * 100) + 1;
                    return values;
                }).collect(Collectors.toList());
        Gson gson = new Gson();
        return gson.toJson(randomValues);
    }

}
