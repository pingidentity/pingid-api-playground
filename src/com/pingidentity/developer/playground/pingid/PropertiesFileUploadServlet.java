package com.pingidentity.developer.playground.pingid;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;
import org.apache.commons.io.IOUtils;


public class PropertiesFileUploadServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if (ServletFileUpload.isMultipartContent(request)) {

			try {
				ServletFileUpload propertiesFile = new ServletFileUpload();
				FileItemIterator fii = propertiesFile.getItemIterator(request);

				while(fii.hasNext()) {
					FileItemStream item = fii.next();
					String name = item.getFieldName();
					InputStream is = item.openStream();
					
					if (item.isFormField()) {
						return;
						
					} else {

						if (is != null) {
							
							Properties props = new Properties();
							props.load(is);
							
							// Set the appropriate pingid.properties values to session
							HttpSession session = request.getSession(false);
							session.setAttribute("pingid_org_alias", props.getProperty("org_alias"));
							session.setAttribute("pingid_token", props.getProperty("token"));
							session.setAttribute("pingid_use_base64_key", props.getProperty("use_base64_key"));
							
							// Set the results of the action to the request attributes
							request.setAttribute("status", "OK");
							request.setAttribute("statusMessage", "Successfully imported pingid.properties");
							
							RequestDispatcher requestDispatcher;
							requestDispatcher = request.getRequestDispatcher("/index.jsp");
							requestDispatcher.forward(request, response);
						}
						return;					
					}
				}
			} catch (FileUploadException ex) {

				throw new ServletException(ex.getMessage());
			}

		} else {
            return;					
		}
	}

}
