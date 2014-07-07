# Use pecl to install module
execute 'install_php_mongo_module' do
  command "pecl install mongo"
  action :run
end

template 'mongo.ini' do
  case node[:platform]
  when 'centos','redhat','fedora','amazon'
    path "/etc/php.d/mongo.ini"
  when 'debian','ubuntu'
    path "/etc/php5/conf.d/mongo.ini"
        only_if { ::File.exist?("/etc/php5/conf.d")}

    path "/etc/php5/mods-available/redis.ini"
        only_if { ::File.exist?("/etc/php5/mods-available")}
  end
  source "php_module.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(
    :module_name => "mongo"
  )
  notifies :restart, resources(:service => 'apache2')
end

case node[:platform]
when 'debian','ubuntu'
  user 'root'
  execute "enable_redis" do
    command "php5enmod mongo && service apache restart"
    only_if { ::File.exist?("/etc/php5/mods-available")}
  end
end
