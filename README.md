#pingid-api-playground

### Overview

Java application to test the PingID API operations. This sample application can help a developer understand the flows and the tokens involved with using the PingID API.


### System Requirements / Dependencies

Requires:
 - PingOne account with PingID service enabled (visit [Ping Identity Developer Site] to get a developer account)

Libraries & Dependencies:
 - JOSE4J (https://bitbucket.org/b_c/jose4j/wiki/Home)
 - Simple JSON (https://github.com/fangyidong/json-simple)
 - Apache Commons logging
 - Apache Commons IO tools
 - Apache Commons File Upload tools
 - JSON IO (https://github.com/jdereg/json-io)
 - SLF4J (http://www.slf4j.org/)

 
### Installation
 
1. Import the project into Eclipse or other Java IDE
2. Add the appropriate libraries (see Libraries & Dependencies)
3. Export as a WAR file and copy to a Java web application server (i.e. Tomcat)


### Usage

1. Launch the application (i.e. https://localhost:8080/pingid-api-playground)
2. Upload your PingID properties file
3. Execute API operations


### Disclaimer

This software is open sourced by Ping Identity but not supported commercially as such. Any questions/issues should go to the Github issues tracker or discuss on the [Ping Identity developer communities] . See also the DISCLAIMER file in this directory.

[Ping Identity developer communities]: https://community.pingidentity.com/collaborate
[Ping Identity Developer Site]: https://developer.pingidentity.com/connect
