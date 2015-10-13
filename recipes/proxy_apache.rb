#
# Cookbook Name:: sonar
# Recipe:: proxy_apache
#
# Copyright 2011, Christian Trabold
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

=begin

TODO ct 2011-06-15 Enable AJP13 settings in config file

If you want to use this AJP13 protocol you must to activate the mod_proxy_ajp module and then edit the sonar.properties configuration file and uncomment the sonar.ajp13.port property :

# Apache mod_jk connector. Supported only in standalone mode.
# Uncomment to activate AJP13 connector.
# sonar.ajp13.port: 8009

Once this done, edit the HTTPd configuration file for the www.somecompany.com virtual host and make the following changes :

  ProxyPass / ajp://sonarhost:sonarajpport/
  ProxyPassReverse / ajp://sonarhost:sonarajpport/

Apache configuration is going to vary based on your own application's requirements and the way you intend to expose Sonar to the outside world. If you need more details about Apache HTTPd, mod_proxy and mod_proxy_ajp, please see http://httpd.apache.org.

=end

include_recipe "apache2"

template "sonar_server.conf" do
  path "#{node[:nginx][:dir]}/sites-enabled/"
  source "apache_site.erb"
  owner "root"
  group "root"
  mode 0644
end

if node['sonar']['enable_mod_proxy_ajp'] == true
  include_recipe "apache2::mod_proxy_ajp"
else 
  include_recipe "apache2::mod_proxy"
end

apache_site "sonar_server.conf" do
  enable :true
end