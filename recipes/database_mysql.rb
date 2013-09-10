#
# Cookbook Name:: sonar
# Recipe:: database_mysql
#
# Adds mysql database server for use by Sonar.
#

include_recipe "mysql::server"
include_recipe "database::mysql"

mysql_connection_info = {
  :host => 'localhost',
  :username => 'root',
  :password => node['mysql']['server_root_password']
}

mysql_database 'sonar' do
  connection ({:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']})
  action :create
end

node['sonar']['mysql']['access_ips'].each do |ip|
  mysql_database_user node['sonar']['jdbc_username'] do
    connection mysql_connection_info
    password node['sonar']['jdbc_password']
    database_name 'sonar'
    host ip
    privileges [ :all ]
    action :grant
  end
end
