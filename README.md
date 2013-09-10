# DESCRIPTION:

This cookbook basically translates the install instructions from http://docs.codehaus.org/display/SONAR/Install+Sonar#InstallSonar-Server into chef DSL.

# REQUIREMENTS:

* `java` + `jdk`
* A database cookbook like `mysql` if you like to run sonar in production.
The built in derby database is not recommended for production.

# ATTRIBUTES:

See `attributes/default.rb` for details.

# USAGE:

The cookbook installs sonar with derby database (default).
Inlcude a `proxy_*` recipe to your `run_list` to access sonar over a proxy server.

# RUNNING TESTS:

You'll need the following installed:
* VirtualBox - https://www.virtualbox.org (tested with 4.2.16)
* Vagrant - http://www.vagrantup.com (tested with 1.2.4)
* The following gems:
  * `gem install test-kitchen --pre` (tested with 1.0.0.beta.2)
  * `gem install berkshelf` (tested with 2.0.10)
  * `gem install kitchen-vagrant` (tested with 0.11.0)
* The following Vagrant plugins:
  * `vagrant plugin install vagrant-berkshelf` (tested with 1.3.3)
  * `vagrant plugin install vagrant-omnibus` (tested with 1.1.0)
  * `vagrant plugin install vagrant-vbguest` (tested with 0.8.0)

Running the tests:
* `kitchen list` will list test suites on various platforms.
* `kitchen test` will run ALL the tests.
* `kitchen test TEST_NAME` (e.g. `kitchen test default-centos-64`) will run only that given test.

# Todos

* Implement `dir` attribute to make installation path more flexible
* Implement different Database backends like MySql
* Implement plugin recipes eg. http://docs.codehaus.org/display/SONAR/PHP+Plugin
  Download jars to plugin folder, restart Sonar
* Create database with mysql LWRP
<pre>
	mysql_database "sonar" do
	  host "localhost"
	  username "root"
	  password node[:mysql][:server_root_password]
	  database "sonar"
	  action :create_db
	end
</pre>
* Set allow / deny patterns with attributes for web access
<pre>
	default['sonar']['web_deny']               = []
	default['sonar']['web_allow']              = []
</pre>
