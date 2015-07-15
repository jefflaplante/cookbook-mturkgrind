#
# Cookbook Name:: mturkgrind 
# Recipe:: mysql
# Author: Jeff LaPlante
#

# Default Matterhorn Cookbook
include_recipe cookbook_name

mysql_service 'mtg' do
  port '3306'
  version '5.6'
  initial_root_password 'WouldntYouLikeToKnow'
  provider Chef::Provider::MysqlServiceUpstart
  action [:create, :start]
end
