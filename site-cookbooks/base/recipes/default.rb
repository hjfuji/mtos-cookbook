#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{yum-fastestmirror nano wget}.each do |pkg|
  package pkg do
    action :install
  end
end

execute "yum-update" do
  user "root"
  command "yum -y update"
  action :run
end

%w{
  httpd mysql mysql-server php php-mbstring php-mysql nginx git gcc make
  zlib-devel gd-devel libxml2-devel expat expat-devel mcrypt php-mcrypt
  memcached memcached-devel ImageMagick ImageMagick-perl
}.each do |pkg|
  package pkg do
    action :install
  end
end

service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

template "httpd.conf" do
  path "/etc/httpd/conf/httpd.conf"
  source "httpd.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :reload, 'service[httpd]'
end

service "httpd" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

service "mysqld" do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end

service "memcached" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
