package edu.cornell.mannlib.vitro.webapp.kafka;

import edu.cornell.mannlib.vitro.webapp.config.ConfigurationPropertiesSetup;
import edu.cornell.mannlib.vitro.webapp.modelaccess.ModelAccess;
import edu.cornell.mannlib.vitro.webapp.rdfservice.RDFService;
import edu.cornell.mannlib.vitro.webapp.rdfservice.RDFServiceException;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.ServletRequestEvent;

public class ChangeListener4KafkaSetup implements ServletContextListener {

    private static final Log log = LogFactory
            .getLog(ConfigurationPropertiesSetup.class);
    // The current RDFService change listener
    private static ChangeListener4Kafka changeListener = null;

    /**
     * Register a change listener with the RDFService
     *
     * @param ctx
     */
    private synchronized void registerChangeListener(ServletContext ctx) {
        // Check that no change listener has already been created
        if (changeListener == null) {
            // Get the RDF Service
            RDFService rdfService = ModelAccess.on(ctx).getRDFService();
            try {
                // Create a change listener
                changeListener = new ChangeListener4Kafka();

                // Register the change listener
                rdfService.registerListener(new ChangeListener4Kafka());
            } catch (RDFServiceException e) {
            }
        }
    }

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext ctx = sce.getServletContext();

        registerChangeListener(ctx);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

    }
}
