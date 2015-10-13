# General settings
include_attribute "java"

node.override['java']['accept_license_agreement'] = true
node.override['java']['oracle']['accept_oracle_download_terms'] = true
node.override['java']['jdk_version'] = '7'
node.override['java']['install_flavor'] = 'oracle'
default['sonar']['dir']       = "/opt/sonar"
default['sonar']['version']   = "5.1.2"
default['sonar']['checksum']  = "795d0dd0a56b4d10966178160b950e20"
default['sonar']['os_kernel'] = "linux-x86-64"

# Web settings
# The default listen port is 9000, the default context path is / and Sonar listens by default to all network interfaces : '0.0.0.0'.
# Once launched, the Sonar web server is available on http://localhost:9000. Parameters can be changed into the file conf/sonar.properties.
# Here is an example to listen to http://localhost:80/sonar:
default['sonar']['web_host']    = "127.0.0.1"
default['sonar']['web_port']    = "9000"
default['sonar']['web_domain']  = node['fqdn']
default['sonar']['web_context'] = "/"

# Database settings
default['sonar']['jdbc_username']        = "sonar"
default['sonar']['jdbc_password']        = "password-changemepls"
default['sonar']['jdbc_url']             = "jdbc:derby://localhost:1527/sonar;create=true"
default['sonar']['jdbc_driverClassName'] = "org.apache.derby.jdbc.ClientDriver"
default['sonar']['jdbc_validationQuery'] = "values(1)"
