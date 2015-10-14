<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>

<t:page>
	<jsp:attribute name="jumbotron">
	<div class="select-operation">
		<div class="col-md-8">
			<h1>Device Details for:</h1>
			<p>${username}</p>
		</div>
		<div class="col-md-4">
			<h1>Options:</h1>
			<p><a href="index.jsp" class="btn btn-default btn-block" role="button">Back to Home</a></p>
		</div>
	</div>
	</jsp:attribute>
	<jsp:body>
  	<div id="results" class="panel panel-default">
    	<div class="panel-heading">Device Details</div>
    	<div class="panel-body">
			<table class="table">
				<tr>
					<td class="col-md-5">PingID Application Version:</td>
					<td class="col-md-7">${deviceDetails.appVersion}</td>
				<tr>
				<tr>
					<td>Available Claimed SMS:</td>
					<td>${deviceDetails.availableClaimedSms}</td>
				<tr>
				<tr>
					<td>Available Not Claimed SMS:</td>
					<td>${deviceDetails.availableNotClaimedSms}</td>
				<tr>
				<tr>
					<td>Country Code:</td>
					<td>${deviceDetails.countryCode}</td>
				<tr>
				<tr>
					<td>Phone Number:</td>
					<td>${deviceDetails.phoneNumber}</td>
				<tr>
				<tr>
					<td>Email:</td>
					<td>${deviceDetails.email}</td>
				<tr>
				<tr>
					<td>Enrollment Date:</td>
					<td>${deviceDetails.enrollment}</td>
				<tr>
				<tr>
					<td>Has Watch:</td>
					<td>${deviceDetails.hasWatch}</td>
				<tr>
				<tr>
					<td>Mobile OS Version:</td>
					<td>${deviceDetails.osVersion}</td>
				<tr>
				<tr>
					<td>Push Enabled:</td>
					<td>${deviceDetails.pushEnabled}</td>
				<tr>
				<tr>
					<td>Device Type:</td>
					<td>${deviceDetails.type}</td>
				<tr>
			</table>
			</div>
  	</div>
  </jsp:body>
</t:page>