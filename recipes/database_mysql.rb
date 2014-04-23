include_recipe "database::mysql"

mysql_connection_info = {
  :host     => 'localhost',
  :username => 'root',
  :password => node['mysql']['server_root_password']
}

mysql_database "sonar" do
  connection mysql_connection_info
  collation "utf8_general_ci"
  encoding "utf8"
end

mysql_database_user "sonar" do
  connection      mysql_connection_info
  password        node['sonar']['jdbc_password']
  action          :create
  notifies        :grant, "mysql_database_user[sonar]"
end

mysql_database_user "sonar-grant" do
  connection      mysql_connection_info
  database_name   "sonar"
  action          :nothing # should be notified with :grant
  notifies        :query, "mysql_database[flush privileges]"
end

mysql_database 'flush privileges' do
  connection mysql_connection_info
  sql        'flush privileges'
  action     :nothing # should be notified with #query
end