#
# Cookbook Name:: sonar
# Recipe:: default
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

include_recipe 'apt'
include_recipe 'ark'
include_recipe 'java'
include_recipe "maven"
include_recipe "chef-sonar::database_mysql"
include_recipe 'runit::default'

package "unzip"

remote_file "/opt/sonar-#{node['sonar']['version']}.zip" do
  #source "http://downloads.sonarsource.com/sonarqube/sonarqube-#{node['sonar']['version']}.zip"
  source "https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-#{node['sonar']['version']}.zip"
  mode "0644"
#  checksum "#{node['sonar']['checksum']}"
  not_if {File.exists?("/opt/sonar-#{node['sonar']['version']}.zip")}
end

execute "unzip /opt/sonar-#{node['sonar']['version']}.zip -d /opt/" do
  not_if {File.directory?("/opt/sonar-#{node['sonar']['version']}/")}
end

link "/opt/sonar" do
  to "/opt/sonarqube-#{node['sonar']['version']}"
end


template "sonar.properties" do
  path "/opt/sonar/conf/sonar.properties"
  source "sonar.properties.erb"
  owner "root"
  group "root"
  mode 0644
  # notifies :restart, resources(:service => "sonar")
end

cookbook_file '/etc/init.d/sonar-init' do
  source 'sonar-init'
  owner 'root'
  group 'root'
  mode '0644'
end

execute 'Transform_Sonar_Service_to_executable' do
  command 'chmod +x /etc/init.d/sonar-init'
  user 'root'
  action :run
end


service "sonar" do
  stop_command "sh /opt/sonar/bin/#{node['sonar']['os_kernel']}/sonar.sh stop"
  start_command "sh /opt/sonar/bin/#{node['sonar']['os_kernel']}/sonar.sh start"
  status_command "sh /opt/sonar/bin/#{node['sonar']['os_kernel']}/sonar.sh status"
  restart_command "sh /opt/sonar/bin/#{node['sonar']['os_kernel']}/sonar.sh restart"
  action :start
end

runit_service "bootsonar"

include_recipe "chef-sonar::proxy_nginx"
