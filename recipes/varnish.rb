#
# Cookbook Name:: mturkgrind 
# Recipe:: varnish
# Author: Jeff LaPlante
#

# Default Matterhorn Cookbook
include_recipe cookbook_name
include_recipe 'build-essential'  # Installs compiler, make, and other 'build essentials'
include_recipe 'varnish'

varnish_log 'default_ncsa' do
  file_name '/var/log/varnish/varnishncsa.log'
  pid '/var/run/varnishncsa.pid'
  instance_name node['varnish']['instance']
  log_format 'varnishncsa'
  ncsa_format_string '%h|%l|%u|%t|\"%r\"|%s|%b|\"%{Referer}i\"|\"%{User-agent}i\"'
  logrotate true 
end