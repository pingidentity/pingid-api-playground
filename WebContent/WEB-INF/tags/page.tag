<%@tag description="Default Developer Page Template" pageEncoding="UTF-8"%>
<%@attribute name="jumbotron"  fragment="true"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="assets/ping/img/favicon.ico">

    <title>PingID API Playground</title>

    <!-- Bootstrap -->
    <link href="assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/ping/css/ping-default.css" rel="stylesheet">

    <script src="assets/bootstrap/js/ie-emulation-modes-warning.js"></script>

  </head>

  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <a class="navbar-brand" href="#">
            <img alt="Ping Identity" src="assets/ping/img/PIC-240x240.png" width="30px"/>
          </a>
        </div>

        <div id="navbar-left" class="">
          <ul class="nav navbar-nav navbar-left">
            <li class="active"><a href="#">PingID API Playground</a></li>
          </ul>
          <ul id="navbar-right" class="nav navbar-nav navbar-right">
            <li><a href="https://developer.pingidentity.com/en/api/pingid-api.html" target="_blank">API Documentation <span class="glyphicon glyphicon-new-window" aria-hidden="true"></span></a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>

    <div class="jumbotron">
      <div class="container">
  	      	<jsp:invoke fragment="jumbotron"/>
      </div>
    </div>
    
    <div class="container">

	<jsp:doBody/>

    </div><!-- /.container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="assets/bootstrap/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>
