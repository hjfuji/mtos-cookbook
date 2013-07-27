package "supervisor" do
  action :install
end

template "supervisord.conf" do
  path "/etc/supervisord.conf"
  source "supervisord.conf.erb"
  owner "root"
  group "root"
  mode 0644
#  notifies :reload, 'service[supervisord]'
end
