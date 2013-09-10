require 'minitest/spec'

describe_recipe 'sonar::database_mysql' do
  it "is currently running as a daemon" do
    service(node['mysql']['service_name']).must_be_running
  end

  it "added sonar database" do
    result = assert_sh("mysql -u #{node['sonar']['jdbc_username']} -p#{node['sonar']['jdbc_password']} -e 'show databases;' sonar")
    assert_includes result, "sonar"
  end

  # TODO: Add test to make sure that all the appropriate users have been added to the database.
  # it "added sonar user access to sonar database"
  # end
end
