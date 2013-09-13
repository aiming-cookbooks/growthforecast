#
# Cookbook Name:: growthforecast
# Recipe:: default
#
# Copyright 2013, Aiming, Inc.
#
# All rights reserved - Do Not Redistribute
#

user_name = node.default['growthforecast']['user']['name']

user user_name do
  supports :manage_home => true
end

include_recipe "growthforecast::#{node['platform_family']}"
