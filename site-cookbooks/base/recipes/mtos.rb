include_recipe 'database::mysql'

mysql_connection_info = {
  :host => node['mt']['dbhost'],
  :username => 'root',
  :password => node['mysql']['server_root_password']
}

mysql_database_user node['mt']['dbuser'] do
  connection mysql_connection_info
  password node['mt']['dbpass']
  action :create
end

mysql_database node['mt']['database'] do
  connection mysql_connection_info
  action :create
end

mysql_database_user node['mt']['dbuser'] do
  connection mysql_connection_info
  database_name node['mt']['database']
  privileges [:all]
  action :grant
end

template "my.cnf" do
  path "/etc/my.cnf"
  source "my.cnf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, 'service[mysqld]'
end

directory "/var/www/html" do
  owner node['user']
  group node['user']
  mode 00755
  action :create
end

git "/var/www/html/mt" do
  repository "git://github.com/movabletype/movabletype.git"
  reference "mt5.2.7"
  action :checkout
  user node['user']
  group node['user']
  not_if { File.exists?("/var/www/html/mt/mt.cgi") }
end

directory "/var/www/html/mt/pids" do
  owner node['user']
  group node['user']
  mode 00755
  action :create
end

template "default.conf" do
  path "/etc/nginx/conf.d/default.conf"
  source "nginx.default.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, 'service[nginx]'
end

template "mt-config.cgi" do
  path "/var/www/html/mt/mt-config.cgi"
  source "mt-config.cgi.erb"
  owner node['user']
  group node['user']
  mode 0644
  not_if { File.exists?("/var/www/html/mt/mt-config.cgi") }
end

template "mt.run" do
  path "/var/www/html/mt/mt.run"
  source "mt.run.erb"
  owner node['user']
  group node['user']
  mode 0700
  not_if { File.exists?("/var/www/html/mt/mt.run") }
end

service "supervisord" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

cron "mt" do
  minute "*/5"
  user "vagrant"
  command "cd /var/www/html/mt; ./tools/run-periodic-tasks"
  action :create
end
