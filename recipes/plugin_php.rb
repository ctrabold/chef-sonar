#
# Cookbook Name:: sonar
# Recipe:: default
#
# Copyright 2012, Fabien Udriot
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

include_recipe "php"

# INSTALL PHP MODULE FROM PACKAGE
package "php5-mysql"
package "php5-xdebug"
package "make"

# UPGRADE PEAR
php_pear "PEAR" do
  action :upgrade
end

# REGISTER NEW PEAR CHANNELS
['pear.phpqatools.org', 'pear.symfony-project.com', 'pear.phpunit.de', 'pear.phpmd.org', 'pear.pdepend.org', 'components.ez.no', 'pear.typo3.org'].each do |channel|
  php_pear_channel channel do
    #action [:discover, :update]
    action :discover
  end
end

# INSTALL PACKAGE
php_pear "phpqatools" do
  channel "pear.phpqatools.org"
  options "--alldeps"
  action :install
end

php_pear "PHP_CodeSniffer" do
  channel "pear.php.net"
  options "--alldeps"
  action :install
end

php_pear "PHPUnit" do
  channel "pear.phpunit.de"
  options "--alldeps"
  action :install
end

php_pear "PHP_PMD" do
  channel "pear.phpmd.org"
  options "--alldeps"
  action :install
end

php_pear "PHPCS_TYPO3_SniffPool" do
  channel "pear.typo3.org"
  options "--alldeps"
  action :install
end

php_pear "PHPCS_TYPO3v4_Standard" do
  channel "pear.typo3.org"
  options "--alldeps"
  action :install
end

bash "install-plugin-php" do
    code <<-EOH
(cd #{node['sonar']['dir']}/sonar/extensions/plugins; wget #{node['sonar']['plugin_php']['url']})
EOH
    notifies :restart, resources(:service => "sonar")
end

#service "sonar" do
#  action :restart
#end
