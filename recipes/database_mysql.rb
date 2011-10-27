include_recipe "mysql::server"

# Setup sonar user
grants_path = "/opt/sonar/extras/database/mysql/create_database.sql"

template grants_path do
  source "create_mysql_database.sql.erb"
  owner "root"
  group "root"
  mode "0600"
  action :create
  notifies :restart, resources(:service => "sonar")
end

execute "mysql-install-application-privileges" do
  command "/usr/bin/mysql -u root #{node[:mysql][:server_root_password].empty? ? '' : '-p' }#{node[:mysql][:server_root_password]} < #{grants_path}"
end
