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

case node[:platform]
when "debian","ubuntu"
  # update apt data to allow installation of java
  include_recipe "apt"
end

include_recipe "java"

package "unzip"

sonar_install_path = "/opt/sonar-#{node['sonar']['version']}"
zip_file_path = "#{sonar_install_path}.zip"

remote_file zip_file_path do
  source "#{node['sonar']['mirror']}/sonar-#{node['sonar']['version']}.zip"
  mode "0644"
  checksum "#{node['sonar']['checksum']}"
  not_if { ::File.exists?(zip_file_path) }
end

execute "unzip #{zip_file_path} -d /opt/" do
  not_if { ::File.directory?("#{sonar_install_path}/") }
end

link "/opt/sonar" do
  to sonar_install_path
end

link "/etc/init.d/sonar" do
  to "#{node['sonar']['dir']}/bin/#{node['sonar']['os_kernel']}/sonar.sh"
end

service "sonar" do
  supports :start => true, :stop => true, :status => true, :restart => true
  action :enable
end

template "sonar.properties" do
  path "#{node['sonar']['dir']}/conf/sonar.properties"
  source "sonar.properties.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
    :options => node['sonar']['options']
  )
  notifies :restart, resources(:service => "sonar")
end

template "wrapper.conf" do
  path "#{node['sonar']['dir']}/conf/wrapper.conf"
  source "wrapper.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources(:service => "sonar")
end

# wait here until sonar is up and running (listening on the given host/port)
