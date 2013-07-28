directory "/var/lib/php/session" do
  owner node['user']
  group node['user']
  mode 00770
  action :create
end

template "php.ini" do
  path "/etc/php.ini"
  source "php.ini.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :reload, 'service[httpd]'
end
