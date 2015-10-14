package com.pingidentity.developer.playground.pingid;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.jose4j.base64url.Base64;

import com.cedarsoftware.util.io.JsonWriter;
import com.pingidentity.developer.pingid.Application;
import com.pingidentity.developer.pingid.OfflinePairingMethod;
import com.pingidentity.developer.pingid.User;
import com.pingidentity.developer.pingid.Operation;

public class APIHandlerServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String requestedOperation = request.getParameter("operation");
		String targetUsername = request.getParameter("username");
		HttpSession session = request.getSession(false);
		
		Operation operation = new Operation((String)session.getAttribute("pingid_org_alias"), (String)session.getAttribute("pingid_token"), (String)session.getAttribute("pingid_use_base64_key"));;
		operation.setTargetUser(targetUsername);

		switch (requestedOperation) {
		
		case "AuthenticateOnline":
			Application app = new Application(request.getParameter("applicationName"));
			app.setLogoUrl(request.getParameter("applicationIconUrl"));
			app.setSpAlias("web");
			operation.AuthenticateOnline(app, request.getParameter("authType"));
			request.setAttribute("lastSessionId", operation.getLastSessionId());
			break;
			
		case "AuthenticateOffline":
			operation.AuthenticateOffline(request.getParameter("sessionId"), request.getParameter("otp"));
			break;

		case "AddUser":
			Boolean activate = false;
			
			User addUser = new User(targetUsername);
			addUser.setEmail(request.getParameter("email"));
			addUser.setFirstName(request.getParameter("fname"));
			addUser.setLastName(request.getParameter("lname"));
			if(request.getParameter("activate") != null) {
				activate = true;
			}

			operation.setTargetUser(addUser);
			operation.AddUser(activate);

			if(request.getParameter("activate") != null) {
				request.setAttribute("lastActivationCode", operation.getLastActivationCode());
			}
			break;

		case "GetUserDetails":
			operation.GetUserDetails();
			break;
			
		case "EditUser":
			User editUser = new User(targetUsername);
			editUser.setEmail(request.getParameter("email"));
			editUser.setFirstName(request.getParameter("fname"));
			editUser.setLastName(request.getParameter("lname"));
			if(request.getParameter("activate") != null) {
				activate = true;
			}

			operation.setTargetUser(editUser);
			operation.EditUser(false);

			if(request.getParameter("activate") != null) {
				request.setAttribute("lastActivationCode", operation.getLastActivationCode());
			}
			break;
			
		case "DeleteUser":
			operation.DeleteUser();
			break;
			
		case "SuspendUser":
			operation.SuspendUser();
			break;
			
		case "ActivateUser":
			operation.ActivateUser();
			break;
			
		case "ToggleUserBypass":
			int addMinutes = 0;
			
			try {
				addMinutes = Integer.parseInt(request.getParameter("bypassUntil"));
			} catch(Exception ex) { }

			Long bypassUntil = 0L;
			if (addMinutes != 0) { bypassUntil = System.currentTimeMillis() + (addMinutes * 60 * 1000); }
			operation.ToggleUserBypass(bypassUntil);
			break;

		case "GetActivationCode":
			operation.GetActivationCode();
			request.setAttribute("lastActivationCode", operation.getLastActivationCode());
			break;
			
		case "GetPairingStatus":
			operation.GetPairingStatus(request.getParameter("activationCode"));
			break;

		case "StartOfflinePairing":
			User offlinePairingUser = operation.getUser();

			OfflinePairingMethod method = OfflinePairingMethod.valueOf(request.getParameter("type"));
			
			if ((method == OfflinePairingMethod.SMS) || (method == OfflinePairingMethod.VOICE)) {
				offlinePairingUser.setPhoneNumber(request.getParameter("pairingData"));
			} else {
				offlinePairingUser.setEmail(request.getParameter("pairingData"));
			}
			operation.setTargetUser(offlinePairingUser);
			operation.StartOfflinePairing(method);
			request.setAttribute("lastSessionId", operation.getLastSessionId());
			break;
			
		case "FinalizeOfflinePairing":
			operation.FinalizeOfflinePairing(request.getParameter("sessionId"), request.getParameter("otp"));
			break;
			
		case "PairYubiKey":
			operation.PairYubiKey(request.getParameter("otp"));
			break;
			
		case "UnpairDevice":
			operation.UnpairDevice();
			break;
			
		default:
			request.setAttribute("status", "danger");
			request.setAttribute("statusDescription", "Operation Not Implemented");
			RequestDispatcher requestDispatcher;
			requestDispatcher = request.getRequestDispatcher("/api-operation.jsp");
			requestDispatcher.forward(request, response);
			return;
		}

		request.setAttribute("operation", operation.getName());
		request.setAttribute("operationEndpoint", operation.getEndpoint());

		if (operation.getWasSuccessful()) {

			request.setAttribute("status", "success");
			request.setAttribute("statusDescription", "Operation Successful");
			
			User modifiedUser = operation.getUser();
			session.setAttribute("username", modifiedUser.getUserName());
			session.setAttribute("user", modifiedUser);
			request.setAttribute("firstName", modifiedUser.getFirstName());
			request.setAttribute("lastName", modifiedUser.getLastName());
			request.setAttribute("email", modifiedUser.getEmail());
			request.setAttribute("role", modifiedUser.getRole().getValue());
			
			session.setAttribute("deviceDetails", modifiedUser.getDeviceDetails());
		} else {
			
			request.setAttribute("status", "danger");
			request.setAttribute("statusDescription", "Operation Failed");
		}

		formatTokensForHTML(request, operation.getRequestToken(), operation.getResponseToken());

		RequestDispatcher requestDispatcher;
		requestDispatcher = request.getRequestDispatcher("/api-operation.jsp");
		requestDispatcher.forward(request, response);
	}
	
	public void formatTokensForHTML(HttpServletRequest request, String requestToken, String responseToken) {

		if (requestToken == null) { requestToken = ".."; };
		if (responseToken == null) { responseToken = ".."; };
		
		String[] requestTokenComponents = requestToken.split("\\.");
		String[] responseTokenComponents = responseToken.split("\\.");
		
		request.setAttribute("requestTokenHeader", requestTokenComponents[0]);
		request.setAttribute("requestTokenHeaderJSON", JsonWriter.formatJson(new String(Base64.decode(requestTokenComponents[0]))));

		request.setAttribute("requestTokenPayload", requestTokenComponents[1]);
		request.setAttribute("requestTokenPayloadJSON", JsonWriter.formatJson(new String(Base64.decode(requestTokenComponents[1]))));

		request.setAttribute("requestTokenSignature", requestTokenComponents[2]);
		request.setAttribute("requestTokenSignatureJSON", "HMAC-SHA256 Signature");
		

		request.setAttribute("responseTokenHeader", responseTokenComponents[0]);
		request.setAttribute("responseTokenHeaderJSON", JsonWriter.formatJson(new String(Base64.decode(responseTokenComponents[0]))));

		request.setAttribute("responseTokenPayload", responseTokenComponents[1]);
		request.setAttribute("responseTokenPayloadJSON", JsonWriter.formatJson(new String(Base64.decode(responseTokenComponents[1]))));

		request.setAttribute("responseTokenSignature", responseTokenComponents[2]);
		request.setAttribute("responseTokenSignatureJSON", "HMAC-SHA256 Signature");
	}
}
