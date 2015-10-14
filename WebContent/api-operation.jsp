<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>

<t:page>
	<jsp:attribute name="jumbotron">
	<div class="select-operation">
		<div class="col-md-8">
			<h1>API Operation:</h1>
			<p>${operation}</p>
			<h1>Endpoint:</h1>
			<p>${operationEndpoint}</p>
		</div>
		<div class="col-md-4">
			<h1>Options:</h1>
			<p><a href="index.jsp" class="btn btn-default btn-block" role="button">Back to Home</a></p>
		</div>
	</div>
	</jsp:attribute>
	<jsp:body>
	<div class="alert alert-${status}"><p>${statusDescription}</p></div>
  	<div id="results" class="panel panel-default">
    	<div class="panel-heading">API Request</div>
    	<div class="panel-body">
				<pre><span class="text-info">${requestTokenHeaderJSON}</span><br>.<br><span class="text-danger">${requestTokenPayloadJSON}</span><br>.<br><span class="text-muted">${requestTokenSignatureJSON}</span></pre>
			</div>
    	<div class="panel-body">
				<pre><span class="text-info">${requestTokenHeader}</span><br>.<br><span class="text-danger">${requestTokenPayload}</span><br>.<br><span class="text-muted">${requestTokenSignature}</span></pre>
			</div>
  	</div>
  	<div id="results" class="panel panel-default">
    	<div class="panel-heading">API Response</div>
    	<div class="panel-body">
				<pre><span class="text-info">${responseTokenHeader}</span><br>.<br><span class="text-danger">${responseTokenPayload}</span><br>.<br><span class="text-muted">${responseTokenSignature}</span></pre>
			</div>
    	<div class="panel-body">
				<pre><span class="text-info">${responseTokenHeaderJSON}</span><br>.<br><span class="text-danger">${responseTokenPayloadJSON}</span><br>.<br><span class="text-muted">${responseTokenSignatureJSON}</span></pre>
			</div>
  	</div>
  </jsp:body>
</t:page>