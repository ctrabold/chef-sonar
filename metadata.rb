maintainer       "Christian Trabold"
maintainer_email "info@christian-trabold.de"
license          "Apache 2.0"
description      "Installs/Configures sonar"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"
recipe           "sonar", "Includes the recipe to download and configure a sonar server"
recipe           "sonar::database_mysql", "Includes the recipe to install MySql-Server and create a database for sonar"
recipe           "sonar::proxy_apache", "Includes the recipe to install Apache-Webserver and proxy modules to access sonar. Creates a host for sonar."
recipe           "sonar::proxy_nginx", "Includes the recipe to install Nginx-Webserver and configures proxy to access sonar. Creates a host for sonar."

%w{ debian ubuntu }.each do |os|
  supports os
end

%w{ java }.each do |cb|
  depends cb
end

attribute "sonar/version",
  :display_name => "Sonar version",
  :description => "The version will be used to download the sources for the given version from 'http://dist.sonar.codehaus.org/sonar-#version#.zip'",
  :default => "2.7"
