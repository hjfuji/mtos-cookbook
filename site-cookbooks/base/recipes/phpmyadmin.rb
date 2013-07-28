git "/var/www/html/phpmyadmin" do
  repository "git://github.com/phpmyadmin/phpmyadmin.git"
  reference "STABLE"
  action :checkout
  user node['user']
  group node['user']
  not_if { File.exists?("/var/www/html/phpmyadmin/index.php") }
end

directory "/var/www/html/phpmyadmin/locale" do
  owner node['user']
  group node['user']
  mode 00755
  action :create
end

directory "/var/www/html/phpmyadmin/locale/ja" do
  owner node['user']
  group node['user']
  mode 00755
  action :create
end

directory "/var/www/html/phpmyadmin/locale/ja/LC_MESSAGES" do
  owner node['user']
  group node['user']
  mode 00755
  action :create
end

cookbook_file "/var/www/html/phpmyadmin/locale/ja/LC_MESSAGES/phpmyadmin.mo" do
  mode 00644
  not_if { File.exists?("/var/www/html/phpmyadmin/locale/ja/LC_MESSAGES/phpmyadmin.mo") }
end

cookbook_file "/var/www/html/phpmyadmin/config.inc.php" do
  mode 00644
  not_if { File.exists?("/var/www/html/phpmyadmin/config.inc.php") }
end
