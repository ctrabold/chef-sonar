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