<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
  	
  	<c:if test="${lastActivationCode ne null}">
  	<div id="qrcode" class="panel panel-default">
    	<div class="panel-heading">QR Code</div>
    	<div class="panel-body">
				<pre><span class="text-info">The activation code (a.k.a the pairing code) can be manually entered into either the mobile apps or the desktop app or it can be encoded in such a way as to produce a QR code. View the source of this page to see how to do that entirely in JavaScript. Note that this also includes a polling process to test if the user has used the QR code or entered in the pairing code manually.</span></pre>
		</div>
		<div class="panel-body">
			<pre><span class="text-danger">Activation Code: ${lastActivationCode}</span></pre>
		</div>
    	<div class="panel-body">
    	<div id="imgDiv" align="center"></div>
	   		<script>
	   			// Generate QR Code image url
				var stringToEncode = 'act_code=${lastActivationCode}';
				var encodedString = window.btoa(stringToEncode);
				var url = "https://zxing.org/w/chart?cht=qr&chs=350x350&chld=L&choe=UTF-8&chl=https%3A%2F%2Fidpxnyl3m.pingidentity.com%2Fpingid%2FQRRedirection%3F" + encodedString;

				// Add QR code image to imgDiv
				var dv = document.getElementById('imgDiv');
				while (dv.hasChildNodes()) { 
		    		dv.removeChild(dv.lastChild); 
				} 
				var img = document.createElement("IMG"); 
				img.src = url;
				dv.appendChild(img); 

				// Test if user paired device by polling GetPairingStatus in the StatusPolingServlet. If they have then switch the QR code image with success. This works if the QR code is used or by manually entering the pairing code.
				setInterval(function() {
       				 $.get("status?activationCode=${lastActivationCode}", function(data, status){
       					 if(data=="SUCCESS") {
           					 img.src='assets/ping/img/success.png';
						  }
       			    });
       			}, 2000); //2 seconds
			</script>
		</div>
  	</div>
  	</c:if>
  </jsp:body>
</t:page>