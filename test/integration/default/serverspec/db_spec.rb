require 'serverspec'

describe package('mysql-server'), :if => os[:family] == 'ubuntu' do
  it { should be_installed }
  it { should be_running }
end

describe port(3306) do 
	it { should be_listening}
end

describe service('mysql') do 
	it { should be enabled }
end

describe command("mysql -u root -pmyp4ssw0rd -h 127.0.0.1 --port 3306 -e 'use sonar'") do
  its(:stdout) { should eq 0 }
end
