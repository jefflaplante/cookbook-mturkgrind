#
# Cookbook Name:: mturkgrind 
# Recipe:: redis
# Author: Jeff LaPlante
#

# Default Matterhorn Cookbook
include_recipe cookbook_name
include_recipe 'redis::install_from_package'
include_recipe 'redis'

# Override redis template with our own
begin
  r = resources(:template => "#{node[:redis][:conf_dir]}/redis.conf")
  r.cookbook cookbook_name 
  r.source "redis.conf.erb"
rescue Chef::Exceptions::ResourceNotFound
  Chef::Log.warn "could not find template to override!"
end
