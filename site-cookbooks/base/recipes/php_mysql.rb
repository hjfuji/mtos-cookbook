%w{
  mysql mysql-devel mysql-server mysql-client
  php php-mbstring php-mysql php-mcrypt php-pecl-xdebug
}.each do |pkg|
  yum_package pkg do
    options "--enablerepo=remi"
    action [ :install, :upgrade ]
  end
end

service "mysqld" do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end
