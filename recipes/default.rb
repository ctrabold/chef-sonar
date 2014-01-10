#
# Cookbook Name:: sonar
# Recipe:: default
#
# Copyright 2011, Christian Trabold
# Copyright 2014, Ilja Bobkevic
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

include_recipe "java"

if node['sonar']['install_package']
  package 'sonar'
else
  include_recipe 'sonar::_source'
end

service 'sonar' do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end

template "sonar.properties" do
  path "/opt/sonar/conf/sonar.properties"
  source "sonar.properties.erb"
  owner "root"
  group "root"
  mode 0444
  variables(
    :options => node['sonar']['options']
  )
  notifies :restart, resources(:service => "sonar")
end

template "wrapper.conf" do
  path "/opt/sonar/conf/wrapper.conf"
  source "wrapper.conf.erb"
  owner "root"
  group "root"
  mode 0444
  notifies :restart, resources(:service => "sonar")
end

execute 'symlink-sonar-logs-directory' do
  command "ln -s #{File.join(node['sonar']['dir'], 'logs')} /var/log/sonar"
  not_if { File.exists?('/var/log/sonar') }
end

execute 'symlink-sonar-conf-directory' do
  command "ln -s #{File.join(node['sonar']['dir'], 'conf')} /etc/sonar"
  not_if { File.exists?('/etc/sonar') }
end
