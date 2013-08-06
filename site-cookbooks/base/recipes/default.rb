#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{yum-fastestmirror nano wget zip unzip}.each do |pkg|
  package pkg do
    action :install
  end
end

execute "yum-update" do
  user "root"
  command "yum -y update"
  action :run
end

group node['user'] do
  group_name node['user']
  action :create
end

user node['user'] do
  group node['user']
  password nil
  supports :manage_home => true
  action [ :create, :manage ]
end

%w{
  httpd mysql mysql-server php php-mbstring php-mysql nginx git gcc make
  zlib-devel gd-devel libxml2-devel expat expat-devel mcrypt php-mcrypt
  memcached memcached-devel ImageMagick ImageMagick-perl zip unzip
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

cookbook_file "/etc/sysconfig/clock" do
  owner "root"
  group "root"
  mode 00644
  not_if { File.exists?("/etc/sysconfig/clock") }
end

cookbook_file "/etc/selinux/config" do
  owner "root"
  group "root"
  mode 00644
end

bash "disable selinux" do
  user "root"
  group "root"
  code <<-EOC
    setenforce 0
  EOC
end

bash "set timezone" do
  user "root"
  group "root"
  code <<-EOC
    cp -p /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
    source /etc/sysconfig/clock
  EOC
end
