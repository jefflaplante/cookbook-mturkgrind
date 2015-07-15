#
# Cookbook Name:: mturkgrind
# Recipe:: app 
# Author: Jeff LaPlante

# Default Matterhorn Cookbook
include_recipe cookbook_name

# chef community cookbooks
include_recipe 'build-essential' # Some gems need to build native extensions
include_recipe 'nginx'           # Install nginx from package (which is the default option)
include_recipe 'php-fpm'         # Install php-fpm from package

%w(php5-mysql php5-gd php5-redis).each do |p|
  package p
end

directory node.mtg.nginx.docroot do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

file "#{node.mtg.nginx.docroot}/health.json" do
  content '{ "alive": true }'
  mode '0644'
  owner 'www-data'
  group 'www-data'
end

file "#{node.mtg.nginx.docroot}/scryer.php" do
  content '<?php phpinfo(); ?>'
  mode '0644'
  owner 'www-data'
  group 'www-data'
end

template "#{node[:nginx][:dir]}/sites-available/#{node.mtg.app_id}" do
  source "nginx_site.erb"
  owner 'root'
  group 'root'
  mode 0644
  variables(
          :app => node.mtg.app_id,
          :port => node.mtg.nginx.port,
          :docroot => node.mtg.nginx.docroot,
          :socket => node.mtg.nginx.socket_path 
  )
  notifies :restart, resources(:service => 'nginx')
end

nginx_site node.mtg.app_id

# Install ioncube module
arch_string = 'x86-64'
remote_file "/var/tmp/ioncube_loaders_lin_#{arch_string}.tar.gz" do
  source "http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_#{arch_string}.tar.gz"
  mode "0644"
  action :create_if_missing
  notifies :run, "script[extract_ioncube_php]", :immediately
end

script "extract_ioncube_php" do
  interpreter "bash"
  user "root"
  cwd "/var/tmp"
  action :nothing
  code <<-EOH
  tar xvfz /var/tmp/ioncube_loaders_lin_#{arch_string}.tar.gz
  mv /var/tmp/ioncube /usr/local
  PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;")
  EOH
end

service 'php5-fpm' do
  action :nothing
end

file "/etc/php5/fpm/conf.d/00-ioncube.ini" do
  content "zend_extension = /usr/local/ioncube/ioncube_loader_lin_5.5.so"
  mode '0644'
  owner 'www-data'
  group 'www-data'
  notifies :restart, resources(:service => 'php5-fpm')
end

# Install forum code
