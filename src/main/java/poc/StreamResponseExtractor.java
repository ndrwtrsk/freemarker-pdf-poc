package poc;

import org.springframework.http.ResponseEntity;
import org.springframework.http.client.ClientHttpResponse;
import org.springframework.web.client.ResponseExtractor;

import java.io.IOException;

/**
 * Created by andrzejtorski on 25.10.16.
 */
public class StreamResponseExtractor implements ResponseExtractor<ResponseEntity> {

    private ResourceReader reader;

    public StreamResponseExtractor(ResourceReader reader) {
        this.reader = reader;
    }

    @Override
    public ResponseEntity extractData(ClientHttpResponse clientHttpResponse)
            throws IOException {
        reader.read(clientHttpResponse.getBody());
        return null;
    }
}
