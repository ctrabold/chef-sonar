#
# Cookbook Name:: sonar
# Provider:: plugin
#
# Copyright 2014, Steffen Gebert / TYPO3 Association
#
# Based on jenkins cookbook:
# Copyright 2013, Opscode, Inc.
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

def whyrun_supported?
  true
end


action :install do
  unless plugin_exists?
    converge_by("Installing sonar plugin #{@new_resource.name} version #{@new_resource.version}") do
      do_install_plugin
    end
  else
    Chef::Log.debug "#{@new_resource.name} already exists"
  end
end

action :remove do
  if plugin_exists?
    converge_by("remove #{@new_resource.name}") do
      do_remove_plugin
    end
  else
    Chef::Log.debug "#{@new_resource.name} doesn't exist"
  end
end

private

def plugins_dir
  ::File.join(node['sonar']['dir'], 'extensions/plugins')
end

def plugin_file_name
  @new_resource.name + '-' + @new_resource.version + '.jar'
end

def plugin_file_path
  ::File.join(plugins_dir, plugin_file_name)
end

def plugin_exists?
  ::File.exists?(plugin_file_path)
end

def do_install_plugin
  plugin_url = @new_resource.url

  remote_file plugin_file_path do
    source plugin_url
    backup false
    action :create
    notifies :restart, 'service[sonar]'
  end

end

def do_remove_plugin
  file plugin_file_path do
    action :delete
    backup false
    notifies :restart, 'service[sonar]'
  end

  directory plugin_dir_path do
    action :delete
    recursive true
    notifies :restart, 'service[sonar]'
  end
end
