#
# Cookbook Name:: growthforecast
# Recipe:: default
#
# Copyright 2013, Aiming, Inc.
#

include_recipe "yum"
include_recipe "yum-remi"

execute "Comment out of exclude-line." do
  command <<-EOF
    sed -i "s/^exclude=kernel/#exclude=kernel/g" /etc/yum.conf
  EOF

  action :run
end

include_recipe "build-essential"
include_recipe "mysql::client"
include_recipe "mysql::server"
include_recipe "perlbrew::default"
include_recipe "perlbrew::profile"

include_recipe "growthforecast::cpanm_dbd_mysql"
include_recipe "growthforecast::cpanm_growthforecast"

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

  notifies :run, "execute[Empty root password]"

end

#include_recipe "growthforecast::cpanm_dbd_mysql"
#include_recipe "growthforecast::cpanm_growthforecast"
