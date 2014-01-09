#
# Cookbook Name:: sonar
# Recipe:: _source
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

package "unzip"

remote_file "/opt/sonar-#{node['sonar']['version']}.zip" do
  source "#{node['sonar']['mirror']}/sonar-#{node['sonar']['version']}.zip"
  mode "0644"
  checksum "#{node['sonar']['checksum']}"
  not_if { ::File.exists?("/opt/sonar-#{node['sonar']['version']}.zip") }
end

execute "unzip /opt/sonar-#{node['sonar']['version']}.zip -d /opt/" do
  not_if { ::File.directory?("/opt/sonar-#{node['sonar']['version']}/") }
end

link node['sonar']['dir'] do
  to "/opt/sonar-#{node['sonar']['version']}"
end

link File.join(node['sonar']['dir'], 'bin', node['sonar']['os_kernel'], 'sonar.sh') do
  to '/usr/bin/sonar'
end

cookbook_file 'sonar_initd' do
  path '/etc/init.d/sonar'
  mode 00755
  action :create
end
