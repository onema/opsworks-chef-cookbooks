# Use pecl to install module
execute "install_php_redis_module" do
  command "pecl install redis"
  action :run
end

template "redis.ini" do
  case node[:platform]
  when "centos","redhat","fedora","amazon"
    path "/etc/php.d/redis.ini"
  when "debian","ubuntu"
    path "/etc/php5/conf.d/redis.ini"
        only_if { ::File.exist?("/etc/php5/conf.d")}

    path "/etc/php5/mods-available/redis.ini"
        only_if { ::File.exist?("/etc/php5/mods-available")}
  end
  source "php_module.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(
    :module_name => "redis"
  )
  notifies :restart, resources(:service => "apache2")
end

case node[:platform]
when "debian","ubuntu"
  user "root"
  execute "enable_redis" do
    command "php5enmod reids && service apache restart"
    only_if { ::File.exist?("/etc/php5/mods-available")}
  end
end
