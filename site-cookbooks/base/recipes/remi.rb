include_recipe "yum::epel"

yum_key node['yum']['remi']['key'] do
  url  node['yum']['remi']['key_url']
  action :add
end

yum_repository "remi" do
  description "Les RPM de remi pour Enterprise Linux #{node['platform_version']} - $basearch"
  key node['yum']['remi']['key']
  mirrorlist node['yum']['remi']['url']
  failovermethod "priority"
  includepkgs node['yum']['remi']['includepkgs']
  exclude node['yum']['remi']['exclude']
  enabled 0
  action :create
end
