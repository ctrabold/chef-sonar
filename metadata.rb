maintainer       "Christian Trabold"
maintainer_email "info@christian-trabold.de"
license          "Apache 2.0"
description      "Installs/Configures sonar"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.4"
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

attribute "sonar/dir",
  :display_name => "Sonar directory",
  :description => "Path to sonar",
  :default => "/opt/sonar"

attribute "sonar/version",
  :display_name => "Sonar version",
  :description => "The version will be used to download the sources for the given version from 'http://dist.sonar.codehaus.org/sonar-#version#.zip'",
  :default => "2.11"

attribute "sonar/checksum",
  :display_name => "MD5 Checksum",
  :description => "MD5 Checksum of download file"

attribute "sonar/os_kernel",
  :display_name => "System architecture",
  :description => "Choose which CPU your running sonar on. This modifies the start-script to your architecture.",
  :default => "linux-x86-32"
