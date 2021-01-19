package edu.cornell.mannlib.vitro.webapp.kafka;

import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class HttpConn {

    private String USER_AGENT = "Mozilla/5.0";
    private String GET_URL = "http://localhost:8500/";
    private String POST_URL = "http://localhost:8500/";

    public void sendGET() throws IOException {
        URL obj = new URL(GET_URL);
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();
        con.setRequestMethod("GET");
        con.setRequestProperty("User-Agent", USER_AGENT);
        int responseCode = con.getResponseCode();
        System.out.println("GET Response Code :: " + responseCode);
        if (responseCode == HttpURLConnection.HTTP_OK) { // success
            BufferedReader in = new BufferedReader(new InputStreamReader(
                    con.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            // print result
            System.out.println(response.toString());
        } else {
            System.out.println("GET request not worked");
        }

    }

    public void sendPost(String serializedModel) throws Exception {

        ArrayList<NameValuePair> postParameters;
        HttpPost post = new HttpPost("http://localhost:9000/kafka/publish");

        //Set the API media type in http content-type header (application/xml, application/x-www-form-urlencoded)
        post.addHeader("content-type", "application/x-www-form-urlencoded");

        postParameters = new ArrayList<NameValuePair>();
        postParameters.add(new BasicNameValuePair("message", serializedModel));
        post.setEntity(new UrlEncodedFormEntity(postParameters, "UTF-8"));

//        StringEntity entity = new StringEntity(serializedModel);
//        post.setEntity(entity);

        try (CloseableHttpClient httpClient = HttpClients.createDefault();
             CloseableHttpResponse response = httpClient.execute(post)) {

//            System.out.println(EntityUtils.toString(response.getEntity()));
            //verify error code first
            int statusCode = response.getStatusLine().getStatusCode();
            System.out.println("Status code: "+statusCode);
        }

    }
}
