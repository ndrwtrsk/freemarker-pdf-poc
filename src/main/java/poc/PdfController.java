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
import java.io.*;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URISyntaxException;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

/**
 * Created by andrzejtorski on 24.10.16.
 */
@RestController
@RequestMapping("pdf")
public class PdfController {

    private final Configuration configuration;
    private final Gson gson;

    public PdfController() {
        configuration = new Configuration();
        configuration.setClassForTemplateLoading(getClass(), "/templates/");
        configuration.setDefaultEncoding("UTF-8");
        configuration.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
        gson = new Gson();
    }

    @RequestMapping("/")
    public String index(){
        return "Hello";
    }

    @RequestMapping("/freemarkerHtml")
    public void freemarkHtmlNodePdf(HttpServletResponse response) throws IOException, TemplateException, URISyntaxException {
        Map model = new HashMap();
        model.put("randomData", generateRandomValues());
        Template template = configuration.getTemplate("test.ftl");
        RestTemplate restTemplate = new RestTemplate();
        URI url = new URI("http://localhost:3000/generate-pdf-from-html");
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

    @RequestMapping("/nodeHtmlPdf")
    public void nodeHtmlPdf(HttpServletResponse response) throws URISyntaxException {
        RestTemplate restTemplate = new RestTemplate();
        URI uri = new URI("http://localhost:3000/generate-pdf-from-data");
        ResourceReader reader = new StreamResourceReader(response);
        RequestCallback cb = clientHttpRequest -> {
            Writer writer = new OutputStreamWriter(clientHttpRequest.getBody());
            writer.write(generateRandomValues());
            writer.flush();
            clientHttpRequest.getHeaders().setContentType(MediaType.TEXT_PLAIN);
        };
        restTemplate.execute(uri, HttpMethod.POST, cb, new StreamResponseExtractor(reader));
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

    /**
     * Send dot template and data to node js and get back pdf response and forward it.
     */
    @RequestMapping("/send-data-and-template")
    public void testNewPrudentialReq(HttpServletResponse response) throws IOException, URISyntaxException {
        InputStream dotTemplateStream = getClass().getResourceAsStream("/dot-templates/test.dot");
        StringWriter writer = new StringWriter();
        org.apache.commons.io.IOUtils.copy(dotTemplateStream, writer, Charset.defaultCharset());
        String html = writer.toString();
        String data = generateRandomValues();
        Map model = new HashMap();
        model.put("html", html);
        model.put("data", data);
        RestTemplate restTemplate = new RestTemplate();
        URI url = new URI("http://localhost:3000/generate-pdf-from-data-and-dot-template");
        RequestCallback cb = clientHttpRequest -> {
            Writer nodeWriter = new OutputStreamWriter(clientHttpRequest.getBody());
            nodeWriter.write(gson.toJson(model));
            nodeWriter.flush();
            clientHttpRequest.getHeaders().setContentType(MediaType.APPLICATION_JSON);
        };
        ResourceReader reader = new StreamResourceReader(response);
        restTemplate.execute(url, HttpMethod.POST, cb, new StreamResponseExtractor(reader));
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

    private String generateRandomValues() {
        Random random = new Random();
        List<Integer> list = IntStream.range(0, random.nextInt(30 + 1))
                .boxed()
                .map(val -> random.nextInt(30 + 1))
                .collect(Collectors.toList());
        return gson.toJson(list);
    }
}
