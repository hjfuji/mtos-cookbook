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

%w{httpd mysql mysql-server php php-mbstring nginx}.each do |pkg|
  package pkg do
    action :install
  end
end
