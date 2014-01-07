#
# Cookbook Name:: growthforecast
# Recipe:: default
#
# Copyright 2013, Aiming, Inc.

include_recipe "perlbrew::default"
include_recipe "growthforecast::cpanm_dbd_mysql"

perlbrew_cpanm 'Install growthforecast' do
  perlbrew node['growthforecast']['system']['perlbrew_ver']
  modules ['GrowthForecast']
  notifies :create, "template[/etc/init/growthforecast.conf]"

  action  :nothing
end

# Setup upstart script of growthforecast
template "/etc/init/growthforecast.conf" do
  source "growthforecast.service.conf.erb"
  owner  "root"
  group  "root"
  mode   0644

  notifies :run, "execute[initctl start growthforecast]" 
  action   :nothing
end

# Service setting of growthforecast
execute "initctl start growthforecast" do
  command <<-EOF
    sudo initctl reload-configuration &&
    sudo initctl start growthforecast
  EOF

  action :nothing

  only_if { `initctl status growthforecast | grep running`.empty? }
end
