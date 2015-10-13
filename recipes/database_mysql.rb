=begin

include_recipe "mysql::server"

# Setup sonar user
grants_path = "/opt/sonar/extras/database/mysql/create_database.sql"

template "/opt/sonar/extras/database/mysql/create_database.sql" do
  path grants_path
  source "create_mysql_database.sql.erb"
  owner "root"
  group "root"
  mode "0600"
  action :create
end

execute "mysql-install-application-privileges" do
  command "/usr/bin/mysql -u root #{node[:mysql][:server_root_password].empty? ? '' : '-p' }#{node[:mysql][:server_root_password]} < #{grants_path}"
end

# Create database with mysql LWRP
#mysql_database "sonar" do
#  host "localhost"
#  username "root"
#  password node[:mysql][:server_root_password]
#  database "sonar"
#  action :create_db
#end

=end

# create connection info as an external ruby hash


mysql_connection_info = {
  :host     => '127.0.0.1',
  :username => 'root',
  :password => 'myp4ssw0rd'
}

mysql_service 'default' do
  port '3306'
  version '5.6'
  initial_root_password 'myp4ssw0rd'
  action [:create, :start]
end

package 'ruby-dev' do
  action :install
end

package 'make' do
  action :install
end



mysql2_chef_gem 'default' do
  action :install
end

mysql_database 'sonar' do
  connection(
    :host     => '127.0.0.1',
    :username => 'root',
    :password => 'myp4ssw0rd'
  )
  action :create
end

mysql_database_user node['sonar']['jdbc_username'] do
  connection mysql_connection_info
  password   node['sonar']['jdbc_password']
  database_name 'sonar'
  host '%' #some applications need this parameter set to all. But, you can change to 127.0.0.1, if desirable.
  privileges [:all]
  action     :grant
end
