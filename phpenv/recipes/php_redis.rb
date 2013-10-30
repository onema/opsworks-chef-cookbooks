execute 'install_php_redis' do
  command "pecl install redis"
  action :run
end

template 'redis.ini' do
  case node[:platform]
  when 'centos','redhat','fedora','amazon'
    path "/etc/php.d/redis.ini"
  when 'debian','ubuntu'
    path "/etc/php5/conf.d/redis.ini"
  end
  source 'redis.ini.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, resources(:service => 'apache2')
end