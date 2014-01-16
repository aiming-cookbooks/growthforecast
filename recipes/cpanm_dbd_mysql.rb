#
# Cookbook Name:: growthforecast
# Recipe:: default
#
# Copyright 2013, Aiming, Inc.

include_recipe "yum"
include_recipe "yum-remi"
include_recipe "mysql::client"
include_recipe "mysql::server"
include_recipe "perlbrew::default"

root_db_pass = node['mysql']['server_root_password']

execute "Empty root password" do
  user  "root"
  group "root"
  action :nothing

  command <<-EOF
    mysql -u root -p#{root_db_pass} -e \
      "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('');"
  EOF

  notifies :run, "perlbrew_cpanm[Install DBD::MySQL]"
end

perlbrew_cpanm 'Install DBD::MySQL' do
  perlbrew node['growthforecast']['system']['perlbrew_ver']
  modules ['DBD::mysql']
  action  :nothing

  notifies :run, "execute[Recovery MySQL password]"
end

execute "Recovery MySQL password" do
  command <<-EOF
    mysql -u root -e \
      "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('#{root_db_pass}');"
  EOF
  action  :nothing

  notifies  :install, "perlbrew_cpanm[Install growthforecast]"
end
