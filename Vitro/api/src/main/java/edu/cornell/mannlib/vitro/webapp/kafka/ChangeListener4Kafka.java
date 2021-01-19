/* $This file is distributed under the terms of the license in LICENSE$ */

package edu.cornell.mannlib.vitro.webapp.kafka;

import edu.cornell.mannlib.vitro.webapp.config.ConfigurationPropertiesSetup;
import edu.cornell.mannlib.vitro.webapp.modelaccess.ModelNames;
import edu.cornell.mannlib.vitro.webapp.rdfservice.ChangeListener;
import edu.cornell.mannlib.vitro.webapp.rdfservice.ModelChange;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.apache.jena.rdf.listeners.StatementListener;
import org.apache.jena.rdf.model.ModelChangedListener;

import java.io.*;
import java.net.Socket;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

/**
 * Listener for changes in the RDFService
 */
public class ChangeListener4Kafka extends StatementListener implements ModelChangedListener, ChangeListener {
    private static final Log log = LogFactory
            .getLog(ConfigurationPropertiesSetup.class);

    @Override
    public void notifyModelChange(ModelChange modelChange) {
       System.out.println("operation: "+modelChange.getOperation());
       System.out.println("changed graph: "+modelChange.getGraphURI());

       final int bufferSize = 1024;
       final char[] buffer = new char[bufferSize];
       final StringBuilder out = new StringBuilder();
       Reader in = new InputStreamReader(modelChange.getSerializedModel(), StandardCharsets.UTF_8);
       int charsRead = 0;
       while(true) {
           try {
               if (!((charsRead = in.read(buffer, 0, buffer.length)) > 0)) break;
           } catch (IOException e) {
               e.printStackTrace();
           }
           out.append(buffer, 0, charsRead);
       }
       System.out.println("serialized model: "+out.toString());

       try {
//           sendChangedDataTCP();
           sendChangedDataHTTP(out.toString());
       } catch (IOException e) {
           e.printStackTrace();
       } catch (Exception e) {
           e.printStackTrace();
       }
    }

    @Override
    public void notifyEvent(String graphURI, Object event) {

    }

    private void sendChangedDataTCP() throws IOException {

        Socket socket = new Socket("localhost", 5555);
        System.out.println("Connected!");

        // get the output stream from the socket.
        OutputStream outputStream = socket.getOutputStream();
        // create a data output stream from the output stream so we can send data through it
        DataOutputStream dataOutputStream = new DataOutputStream(outputStream);

        // write the message we want to send
        dataOutputStream.writeUTF("Some data has changed in VIVO");
        dataOutputStream.flush(); // send the message
        dataOutputStream.close(); // close the output stream when we're done.

        System.out.println("Closing socket.");
        socket.close();
    }

    private void sendChangedDataHTTP(String serializedModel) throws Exception {
        HttpConn httpConn = new HttpConn();

        httpConn.sendPost(serializedModel);
    }



    private boolean isABoxInferenceGraph(String graphURI) {
        return ModelNames.ABOX_INFERENCES.equals(graphURI);
    }

    private boolean isTBoxGraph(String graphURI) {
        return ( ModelNames.TBOX_ASSERTIONS.equals(graphURI)
                || ModelNames.TBOX_INFERENCES.equals(graphURI)
                || (graphURI != null && graphURI.contains("tbox")) );
    }
}
