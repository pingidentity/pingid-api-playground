package com.pingidentity.developer.playground.pingid;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pingidentity.developer.pingid.Operation;

public class StatusPollingServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		String orgAlias = (String) session.getAttribute("pingid_org_alias");
		String token = (String) session.getAttribute("pingid_token");
		String base64Key = (String) session.getAttribute("pingid_use_base64_key");

		response.setHeader("Content-Type", "text/plain");
		response.setHeader("success", "yes");
		String activationCode = request.getParameter("activationCode");
		Operation operation = new Operation(orgAlias, token, base64Key);
		operation.GetPairingStatus(activationCode);
		Map<String, Object> values = operation.getReturnValues();
		String returnValue = "NOT_CLAIMED";
		if (values != null && values.containsKey("pairingStatus")) {
			returnValue = values.get("pairingStatus").toString();
		}
		PrintWriter writer = response.getWriter();
		writer.write(returnValue);
		writer.close();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

}
