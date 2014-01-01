#
# Cookbook Name:: growthforecast
# Recipe:: default
#
# Copyright 2013, Aiming, Inc.
#

user_name = node.default['growthforecast']['user']['name']

user user_name do
  supports :manage_home => true
  home     "/home/#{user_name}"
  action   :create
end

include_recipe "growthforecast::#{node['platform_family']}"
