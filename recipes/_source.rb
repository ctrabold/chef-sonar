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

zip_file_path = File.join(node['sonar']['install_dir'], node['sonar']['zip_file'])
sonar_dir     = File.join(node['sonar']['install_dir'], "#{node['sonar']['name']}-#{node['sonar']['version']}")

remote_file zip_file_path do
  source "#{node['sonar']['mirror']}/#{node['sonar']['zip_file']}"
  mode "0644"
  checksum "#{node['sonar']['checksum']}"
  not_if { ::File.exists?(zip_file_path) }
end

execute "unzip #{zip_file_path} -d #{node['sonar']['install_dir']}" do
  not_if { ::File.directory?(sonar_dir) }
end

link node['sonar']['home'] do
  to sonar_dir
end

link File.join(node['sonar']['bin_dir'], 'sonar.sh') do
  to '/usr/bin/sonar'
end

cookbook_file 'sonar_initd' do
  path '/etc/init.d/sonar'
  mode 00755
  action :create
end
