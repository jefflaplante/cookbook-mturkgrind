#
# Cookbook Name:: mturkgrind 
# Recipe:: default
# Copyright 2015, Jeff LaPlante 

# Set the node project attribute to identify it
node.set[:project] = "mturkgrind"

# Add default account
user "app_user" do
  username node[:mtg][:app_user]
  action :create
  comment "Application account"
end

# Community cookbook essentials
include_recipe 'hostname'         # set the hostname to the node name
include_recipe 'apt'              # Updates apt repos
include_recipe 'chef-client'      # Runs chef client as a daemon
include_recipe 'git'              # Installs git
include_recipe 'ntp'              # Installs ntp
include_recipe 'logrotate'        # Installs logrotate
include_recipe 'postfix'          # Installs postfix
include_recipe 'motd-tail'        # MOTD

%w(htop vim curl rsync wget).each do |p|
  package p
end

