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

include_recipe "ark"
include_recipe "java"

ark "sonar" do
  prefix_home "/opt"
  prefix_root "/opt"
  version node['sonar']['version']
  url "#{node['sonar']['mirror']}/sonar-#{node['sonar']['version']}.zip"
  action :install
end

service "sonar" do
  stop_command "sh /opt/sonar/bin/#{node['sonar']['os_kernel']}/sonar.sh stop"
  start_command "sh /opt/sonar/bin/#{node['sonar']['os_kernel']}/sonar.sh start"
  status_command "sh /opt/sonar/bin/#{node['sonar']['os_kernel']}/sonar.sh status"
  restart_command "sh /opt/sonar/bin/#{node['sonar']['os_kernel']}/sonar.sh restart"
  action :start
end

template "sonar.properties" do
  path "/opt/sonar/conf/sonar.properties"
  source "sonar.properties.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
    :options => node['sonar']['options']
  )
  notifies :restart, 'service[sonar]', :immediately
  notifies :create, 'ruby_block[block_sonar_until_operational]', :immediately
end

template "wrapper.conf" do
  path "/opt/sonar/conf/wrapper.conf"
  source "wrapper.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, 'service[sonar]', :immediately
  notifies :create, 'ruby_block[block_sonar_until_operational]', :immediately
end

ruby_block 'block_sonar_until_operational' do
  block do
    Chef::Log.info "Waiting until Sonar is listening on port #{node['sonar']['web_port']}"
    until SonarHelper.service_listening?(node['sonar']['web_port'])
      sleep 1
      Chef::Log.debug('.')
    end

    Chef::Log.info 'Waiting until the Sonar API is responding'
    test_url = URI.parse("http://localhost:#{node['sonar']['web_port']}/api/server")
    until SonarHelper.endpoint_responding?(test_url)
      sleep 1
      Chef::Log.debug('.')
    end
  end
  action :nothing
end

log 'ensure_sonar_is_running' do
  notifies :start, 'service[sonar]', :immediately
  notifies :create, 'ruby_block[block_sonar_until_operational]', :immediately
end
