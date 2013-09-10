#
# Cookbook Name:: sonar
# Attributes:: default
#

# General settings
default['sonar']['dir']                    = "/opt/sonar"
default['sonar']['version']                = "2.11"
default['sonar']['checksum']               = "9d05e25ca79c33d673004444d89c8770"
default['sonar']['os_kernel']              = "linux-x86-32"
default['sonar']['mirror']                 = "http://dist.sonar.codehaus.org"

# Web settings
# The default listen port is 9000, the default context path is / and Sonar listens by default to all network interfaces : '0.0.0.0'.
# Once launched, the Sonar web server is available on http://localhost:9000. Parameters can be changed into the file conf/sonar.properties.
# Here is an example to listen to http://localhost:80/sonar:
default['sonar']['web_host']               = "0.0.0.0"
default['sonar']['web_port']               = "9000"
default['sonar']['web_domain']             = "sonar.example.com"
default['sonar']['web_context']            = "/"
default['sonar']['web_template']           = "default"

# Database settings
# @see conf/sonar.properties for examples for different databases
default['sonar']['jdbc_username']          = "sonar"
default['sonar']['jdbc_password']          = "sonar"
default['sonar']['jdbc_url']               = "jdbc:derby://localhost:1527/sonar;create=true"
default['sonar']['jdbc_driverClassName']   = "org.apache.derby.jdbc.ClientDriver"
default['sonar']['jdbc_validationQuery']   = "values(1)"

# Allow direct access to the Sonar database via these IPs. Default only allows access
# from localhost. If you use things that write directly to the Sonar DB from remote
# locations (e.g. the sonar-maven-plugin), you may want to allow additional specific
# IPs (or '%', which allows open remote access). Note that node['mysql']['bind_address']
# also controls who can actually connect to mysql.
default['sonar']['mysql']['access_ips'] = [ 'localhost' ]

# Wrapper settings eg. for performance improvements
# @see http://docs.codehaus.org/display/SONAR/Performances
default['sonar']['java_additional']        = "-server"
default['sonar']['java_initmemory']        = "256"
default['sonar']['java_maxmemory']         = "512"
default['sonar']['java_maxpermsize']       = "128m"
default['sonar']['java_command']           = "java"
default['sonar']['logfile_maxsize']        = "0"
default['sonar']['syslog_loglevel']        = "NONE"

default['sonar']['options']                = {}