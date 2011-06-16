#
# Cookbook Name:: sonar
# Recipe:: proxy_nginx
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

include_recipe "nginx"

template "sonar_server.conf" do
  path "#{node[:nginx][:dir]}/sites-available/sonar_server.conf"
  source "nginx_site.erb"
  owner "root"
  group "root"
  mode 0644
end

nginx_site "sonar_server.conf" do
  enable :true
end