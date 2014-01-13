# General settings
default['sonar']['name']                   = "sonarqube"
default['sonar']['version']                = "4.0"
default['sonar']['os_kernel']              = "#{node['os']}-#{node['kernel']['machine'].gsub('_', '-')}"
default['sonar']['install_dir']            = "/opt"
default['sonar']['home']                   = File.join(node['sonar']['install_dir'], node['sonar']['name'])
default['sonar']['conf_dir']               = File.join(node['sonar']['home'], 'conf')
default['sonar']['log_dir']                = File.join(node['sonar']['home'], 'logs')
default['sonar']['bin_dir']                = File.join(node['sonar']['home'], 'bin', node['sonar']['os_kernel'])
default['sonar']['zip_file']               = "#{node['sonar']['name']}-#{node['sonar']['version']}.zip"
default['sonar']['checksum']               = "01e036c265bac46105515eb8a753bc02208c9a22b198bc846acf2e752ea133e5"
default['sonar']['mirror']                 = "http://dist.sonar.codehaus.org"
default['sonar']['install_package']        = false

# Web settings
# The default listen port is 9000, the default context path is / and Sonar listens by default to all network interfaces : '0.0.0.0'.
# Once launched, the Sonar web server is available on http://localhost:9000. Parameters can be changed into the file conf/sonar.properties.
# Here is an example to listen to http://localhost:80/sonar:
default['sonar']['web_host']               = "0.0.0.0"
default['sonar']['web_port']               = "9000"
default['sonar']['web_domain']             = node['fqdn']
default['sonar']['web_context']            = "/"
default['sonar']['web_template']           = "default"

# Database settings
# @see conf/sonar.properties for examples for different databases
default['sonar']['jdbc_username']          = "sonar"
default['sonar']['jdbc_password']          = "sonar"
default['sonar']['jdbc_url']               = "jdbc:h2:tcp://localhost:9092/sonar"

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
