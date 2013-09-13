#
# Cookbook Name:: growthforecast
# Recipe:: default
#
# Copyright 2013, Aiming, Inc.
#
# All rights reserved - Do Not Redistribute
#

include_recipe "build-essential"

%w[pkgconfig glib2-devel gettext libxml2-devel pango-devel cairo-devel].each do |package_name|
  package package_name do
    action :install
  end
end

# Setup mysql database
execute "Setup mysql database" do
  user  "root"
  group "root"

  root_db_pass = node['mysql']['server_root_password']

  command <<-EOF
    mysqladmin -h localhost -u root -p#{root_db_pass} create growthforecast;
  EOF

  not_if "mysql -h localhost -u root -p#{root_db_pass} growthforecast -e ''"
end

# Create growthforecast user to mysql.
execute "Create growthforecast user to mysql" do
  root_db_pass = node['mysql']['server_root_password']
  db_user = node['growthforecast']['database']['user_name']
  db_pass = node['growthforecast']['database']['password']

  command <<-EOF
    mysql -u root -p#{root_db_pass} -e \
      "GRANT CREATE, ALTER, DELETE, INSERT, UPDATE, SELECT ON \ 
         growthforecast.* TO '#{db_user}'@'localhost' IDENTIFIED BY '#{db_pass}'"
  EOF

  not_if "mysql -u #{db_user} -p#{db_pass} growthforecast -e"
end

# Setup upstart script of growthforecast
template "/etc/init/growthforecast.conf" do
  source "growthforecast.service.conf.erb"
  owner  "root"
  group  "root"
  mode   0644

  notifies :start, "service[growthforecast]" 
end

# Service setting of growthforecast
service "growthforecast" do
  supports :restart => true, :reload => true, :status => true
  action   :nothing
  provider Chef::Provider::Service::Upstart
end 

include_recipe "growthforecast::cpanm_install"
