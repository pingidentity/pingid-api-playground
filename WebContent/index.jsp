<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>

<t:page>
	<jsp:attribute name="jumbotron">
	<div class="select-operation">
		<div class="col-md-8">
			<h1>PingID User:</h1>
			<table class="table">
				<tr>
					<td class="col-md-2">Username:</td>
					<td class="col-md-4">${username}</td>
					<td class="col-md-2">Status:</td>
					<td class="col-md-4">${user.status}</td>
				<tr>
				<tr>
					<td>Full Name:</td>
					<td>${user.firstName} ${user.lastName}</td>
					<td>Bypass:</td>
					<td>${user.isBypassed("web")}</td>
				<tr>
				<tr>
					<td>Email:</td>
					<td>${user.email}</td>
					<td>Role:</td>
					<td>${user.role}</td>
				<tr>
				<tr>
					<td>Last Login:</td>
					<td>${user.lastAuthentication}</td>
					<td>Device Details:</td>
					<td><a href="device-details.jsp" class="btn btn-default btn-block btn-xs" role="button" ${pingid_org_alias != null ? "" : "disabled=\"disabled\""}>Show...</a></td>
				<tr>
			</table>
			<form class="form-inline" action="api-handler" method="POST">
				<div class="form-group">
					<label for="select-pingid-user">Select a PingID User:</label>
					<input
						type="text" name="username" class="form-control" id="select-pingid-user"
						placeholder="joe" value="${username}">
						<input type="hidden" name="operation" value="GetUserDetails">
					<button type="submit" class="btn btn-default" ${pingid_org_alias != null ? "" : "disabled=\"disabled\""}>Get User Details...</button>
				</div>
			</form>
		</div>
		<div class="col-md-4">
					<h1>PingID Organization:</h1>
					<p>${pingid_org_alias}</p>
					<p>&nbsp;</p>
					<form action="handle-upload-props" method="POST"
						enctype="multipart/form-data">
						<div class="form-group" id="upload-pingid-props">
							<label for="upload-pingid-props-file">Upload PingID
								settings file</label> <input type="file" name="pingid.properties"
								id="upload-pingid-props-file">
							<p class="help-block">Upload your pingid.properties file</p>
							<button type="submit" class="btn btn-default btn-block">Upload</button>
						</div>
					</form>
		</div>
	</div>
	</jsp:attribute>
	<jsp:body>
        <div id="authentication-api" class="panel panel-default">
        	<div class="panel-heading">Authentication API</div>
        	<div class="panel-body">
		        <div id="authenticate_online" class="panel panel-default">
   			     	<div class="panel-heading"><a data-toggle="collapse" href="#collapse_authonline">AuthenticateOnline</a></div>
        			<div id="collapse_authonline" class="panel-body panel-collapse collapse">
								<form action="api-handler" method="POST">
									<div class="form-group">
										<label for="select-pingid-user">User Name:</label>
										<input type="text" name="username" class="form-control"
											id="select-pingid-user" value="${username}">
										<label for="select-auth-type">Auth Type:</label>
										<select name="authType" class="form-control"
											id="select-auth-type">
											<option>CONFIRM</option>
											<option>FINGERPRINT_PERMISSIVE</option>
											<option>FINGERPRINT_RESTRICTIVE</option>
											<option>FINGERPRINT_HARD_RESTRICTIVE</option>
										</select>
										<label for="sp-name">Application Name:</label>
										<input type="text" name="applicationName" class="form-control"
											id="sp-name" placeholder="My Application">
										<label for="sp-name">Application Icon (URL):</label>
										<input type="text" name="applicationIconUrl" class="form-control"
											id="sp-logo" placeholder="URL (PNG format)">
										<input type="hidden" name="operation" value="AuthenticateOnline">
										<br/>
										<button type="submit" class="btn btn-default" ${pingid_org_alias != null ? "" : "disabled=\"disabled\""}>Authenticate Online...</button>
									</div>
								</form>
        			</div>
        		</div>
		        <div id="user-edit" class="panel panel-default">
   			     	<div class="panel-heading"><a data-toggle="collapse" href="#collapse_authoffline">AuthenticateOffline</a></div>
        			<div id="collapse_authoffline" class="panel-body panel-collapse collapse">
								<form action="api-handler" method="POST">
									<div class="form-group">
										<label for="select-pingid-user">User Name:</label>
										<input type="text" name="username" class="form-control"
											id="select-pingid-user" value="${username}">
										<label for="select-session-id">Session ID:</label>
										<input type="text" name="sessionId" class="form-control"
											id="select-session-id" value="${lastSessionId}">
										<label for="select-otp">OTP:</label>
										<input type="text" name="otp" class="form-control"
											id="select-otp">
										<input type="hidden" name="operation" value="AuthenticateOffline">
										<br/>
										<button type="submit" class="btn btn-default" ${pingid_org_alias != null ? "" : "disabled=\"disabled\""}>Authenticate Offline...</button>
									</div>
								</form>
        			</div>
        		</div>
		    	</div>
        </div>
        <div id="user-management-api" class="panel panel-default">
        	<div class="panel-heading">User Management API</div>
        	<div class="panel-body">
		        <div id="user-add" class="panel panel-default">
   			     	<div class="panel-heading"><a data-toggle="collapse" href="#collapse_add">AddUser</a></div>
        			<div id="collapse_add" class="panel-body panel-collapse collapse">
								<form action="api-handler" method="POST">
									<div class="form-group">
										<label for="select-pingid-user">User Name:</label>
										<input type="text" name="username" class="form-control"
											id="select-pingid-user" placeholder="sarah">
										<label for="select-pingid-user-fname">First Name:</label>
										<input type="text" name="fname" class="form-control"
											id="select-pingid-user-fname" placeholder="Sarah">
										<label for="select-pingid-user-lname">Last Name:</label>
										<input type="text" name="lname" class="form-control"
											id="select-pingid-user-lname" placeholder="Davies">
										<label for="select-pingid-user-email">Email Address:</label>
										<input type="text" name="email" class="form-control"
											id="select-pingid-user-email" placeholder="sarah@pingdevelopers.com">
										<label for="add-user-activate">Activate User:</label>
										<input type="checkbox" name="activate" class="form-control"
											id="add-user-activate" value="activate">
										<input type="hidden" name="operation" value="AddUser">
										<br/>
										<button type="submit" class="btn btn-default" ${pingid_org_alias != null ? "" : "disabled=\"disabled\""}>Add User...</button>
									</div>
								</form>
        			</div>
        		</div>
		        <div id="user-edit" class="panel panel-default">
   			     	<div class="panel-heading"><a data-toggle="collapse" href="#collapse_edit">EditUser</a></div>
        			<div id="collapse_edit" class="panel-body panel-collapse collapse">
								<form action="api-handler" method="POST">
									<div class="form-group">
										<label for="select-pingid-user">User Name:</label>
										<input type="text" name="username" class="form-control"
											id="select-pingid-user"  value="${username}">
										<label for="select-pingid-user-fname">First Name:</label>
										<input type="text" name="fname" class="form-control"
											id="select-pingid-user-fname" value="${user.firstName}">
										<label for="select-pingid-user-lname">Last Name:</label>
										<input type="text" name="lname" class="form-control"
											id="select-pingid-user-lname" value="${user.lastName}">
										<label for="select-pingid-user-email">Email Address:</label>
										<input type="text" name="email" class="form-control"
											id="select-pingid-user-email" value="${user.email}">
										<label for="add-user-activate">Activate User:</label>
										<input type="checkbox" name="activate" class="form-control"
											id="edit-user-activate" value="activate">
										<input type="hidden" name="operation" value="EditUser">
										<br/>
										<button type="submit" class="btn btn-default" ${pingid_org_alias != null ? "" : "disabled=\"disabled\""}>Edit User...</button>
									</div>
								</form>
        			</div>
        		</div>
		        <div id="user-delete" class="panel panel-default">
   			     	<div class="panel-heading"><a data-toggle="collapse" href="#collapse_delete">DeleteUser</a></div>
        			<div id="collapse_delete" class="panel-body panel-collapse collapse">
								<form class="form-inline" action="api-handler" method="POST">
									<div class="form-group">
										<label for="select-pingid-user">Select a PingID User:</label>
										<input type="text" name="username" class="form-control"
											id="select-pingid-user" value="${username}">
										<input type="hidden" name="operation" value="DeleteUser">
										<button type="submit" class="btn btn-default" ${pingid_org_alias != null ? "" : "disabled=\"disabled\""}>Delete User...</button>
									</div>
								</form>
        			</div>
        		</div>
		        <div id="user-suspend" class="panel panel-default">
   			     	<div class="panel-heading"><a data-toggle="collapse" href="#collapse_suspend">SuspendUser</a></div>
        			<div id="collapse_suspend" class="panel-body panel-collapse collapse">
								<form class="form-inline" action="api-handler" method="POST">
									<div class="form-group">
										<label for="select-pingid-user">Select a PingID User:</label>
										<input type="text" name="username" class="form-control"
											id="select-pingid-user" value="${username}">
										<input type="hidden" name="operation" value="SuspendUser">
										<button type="submit" class="btn btn-default" ${pingid_org_alias != null ? "" : "disabled=\"disabled\""}>Suspend User...</button>
									</div>
								</form>
        			</div>
        		</div>
		        <div id="user-activate" class="panel panel-default">
   			     	<div class="panel-heading"><a data-toggle="collapse" href="#collapse_activate">ActivateUser</a></div>
        			<div id="collapse_activate" class="panel-body panel-collapse collapse">
								<form class="form-inline" action="api-handler" method="POST">
									<div class="form-group">
										<label for="select-pingid-user">Select a PingID User:</label>
										<input type="text" name="username" class="form-control"
											id="select-pingid-user" value="${username}">
										<input type="hidden" name="operation" value="ActivateUser">
										<button type="submit" class="btn btn-default" ${pingid_org_alias != null ? "" : "disabled=\"disabled\""}>Activate User...</button>
									</div>
								</form>
        			</div>
        		</div>
		        <div id="user-bypass" class="panel panel-default">
   			     	<div class="panel-heading"><a data-toggle="collapse" href="#collapse_toggleuserbypass">ToggleUserBypass</a></div>
        			<div id="collapse_toggleuserbypass" class="panel-body panel-collapse collapse">
								<form action="api-handler" method="POST">
									<div class="form-group">
										<label for="select-pingid-user">Select a PingID User:</label>
										<input type="text" name="username" class="form-control"
											id="select-pingid-user" value="${username}">
										<label for="select-bypass-length">How many minutes (1440 = 1day / 0 to reset bypass):</label>
										<input type="text" name="bypassUntil" class="form-control"
											id="select-pingid-user" placeholder="30">
										<br/>
										<input type="hidden" name="operation" value="ToggleUserBypass">
										<button type="submit" class="btn btn-default" ${pingid_org_alias != null ? "" : "disabled=\"disabled\""}>Toggle User Bypass...</button>
									</div>
								</form>
        			</div>
        		</div>
		        <div id="get-activation-code" class="panel panel-default">
   			     	<div class="panel-heading"><a data-toggle="collapse" href="#collapse_getactivationcode">GetActivationCode</a></div>
        			<div id="collapse_getactivationcode" class="panel-body panel-collapse collapse">
								<form class="form-inline" action="api-handler" method="POST">
									<div class="form-group">
										<label for="select-pingid-user">Select a PingID User:</label>
										<input type="text" name="username" class="form-control"
											id="select-pingid-user" value="${username}">
										<input type="hidden" name="operation" value="GetActivationCode">
										<button type="submit" class="btn btn-default" ${pingid_org_alias != null ? "" : "disabled=\"disabled\""}>GetActivationCode...</button>
									</div>
								</form>
        			</div>
        		</div>
		        <div id="get-pairing-status" class="panel panel-default">
   			     	<div class="panel-heading"><a data-toggle="collapse" href="#collapse_getpairingstatus">GetPairingStatus</a></div>
        			<div id="collapse_getpairingstatus" class="panel-body panel-collapse collapse">
								<form class="form-inline" action="api-handler" method="POST">
									<div class="form-group">
										<label for="activation-code">Activation Code:</label>
										<input type="text" name="activationCode" class="form-control"
											id="activation-code" value="${lastActivationCode}">
										<input type="hidden" name="operation" value="GetPairingStatus">
										<button type="submit" class="btn btn-default" ${pingid_org_alias != null ? "" : "disabled=\"disabled\""}>Get Pairing Status...</button>
									</div>
								</form>
        			</div>
        		</div>
		        <div id="start-offline-pairing" class="panel panel-default">
   			     	<div class="panel-heading"><a data-toggle="collapse" href="#collapse_startofflinepairing">StartOfflinePairing</a></div>
        			<div id="collapse_startofflinepairing" class="panel-body panel-collapse collapse">
								<form action="api-handler" method="POST">
									<div class="form-group">
										<label for="select-pingid-user">Select a PingID User:</label>
										<input type="text" name="username" class="form-control"
											id="select-pingid-user" value="${username}">
										<label for="select-method">Enter Method:</label>
										<select name="type" class="form-control"
											id="select-method">
											<option>SMS</option>
											<option>VOICE</option>
											<option>EMAIL</option>
										</select>
										<label for="pairing-data">Pairing Data:</label>
										<input type="text" name="pairingData" class="form-control"
											id="select-method" placeholder="email address or phone number">
										<br/>
										<input type="hidden" name="operation" value="StartOfflinePairing">
										<button type="submit" class="btn btn-default" ${pingid_org_alias != null ? "" : "disabled=\"disabled\""}>Start Offline Pairing...</button>
									</div>
								</form>
        			</div>
        		</div>
		        <div id="finalize-offline-pairing" class="panel panel-default">
   			     	<div class="panel-heading"><a data-toggle="collapse" href="#collapse_finalizeofflinepairing">FinalizeOfflinePairing</a></div>
        			<div id="collapse_finalizeofflinepairing" class="panel-body panel-collapse collapse">
								<form action="api-handler" method="POST">
									<div class="form-group">
										<label for="session-id">Session ID:</label>
										<input type="text" name="sessionId" class="form-control"
											id="session-id" value="${lastSessionId}">
										<label for="enter-otp">Enter OTP:</label>
										<input type="text" name="otp" class="form-control"
											id="enter-otp">
										<br/>
										<input type="hidden" name="operation" value="FinalizeOfflinePairing">
										<button type="submit" class="btn btn-default" ${pingid_org_alias != null ? "" : "disabled=\"disabled\""}>Finalize Offline Pairing...</button>
									</div>
								</form>
        			</div>
        		</div>
		        <div id="pair-yubikey" class="panel panel-default">
   			     	<div class="panel-heading"><a data-toggle="collapse" href="#collapse_pairyubikey">PairYubiKey</a></div>
        			<div id="collapse_pairyubikey" class="panel-body panel-collapse collapse">
								<form action="api-handler" method="POST">
									<div class="form-group">
										<label for="select-pingid-user">Select a PingID User:</label>
										<input type="text" name="username" class="form-control"
											id="select-pingid-user" value="${username}">
										<label for="enter-otp">Enter YubiKey OTP:</label>
										<input type="text" name="otp" class="form-control"
											id="enter-otp">
										<br/>
										<input type="hidden" name="operation" value="PairYubiKey">
										<button type="submit" class="btn btn-default" ${pingid_org_alias != null ? "" : "disabled=\"disabled\""}>Pair YubiKey...</button>
									</div>
								</form>
        			</div>
        		</div>
		        <div id="unpair-device" class="panel panel-default">
   			     	<div class="panel-heading"><a data-toggle="collapse" href="#collapse_unpairdevice">UnpairDevice</a></div>
        			<div id="collapse_unpairdevice" class="panel-body panel-collapse collapse">
								<form class="form-inline" action="api-handler" method="POST">
									<div class="form-group">
										<label for="select-pingid-user">Select a PingID User:</label>
										<input type="text" name="username" class="form-control"
											id="select-pingid-user" value="${username}">
										<input type="hidden" name="operation" value="UnpairDevice">
										<button type="submit" class="btn btn-default" ${pingid_org_alias != null ? "" : "disabled=\"disabled\""}>Unpair Device...</button>
									</div>
								</form>
        			</div>
        		</div>
	       	</div>
        </div>
        
    </jsp:body>
</t:page>