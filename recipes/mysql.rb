#
# Cookbook Name:: sonar
# Recipe:: mysql
#
# Copyright 2011, Srinivasan Raguraman
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

# Database settings
# @see conf/sonar.properties for examples for different databases
override['sonar']['jdbc_url']             = "jdbc:mysql://localhost:3306/sonar?useUnicode=true&characterEncoding=utf8"
override['sonar']['jdbc_driverClassName'] = "com.mysql.jdbc.Driver"
override['sonar']['jdbc_validationQuery'] = "select 1"

include "default"
include "database_mysql"
