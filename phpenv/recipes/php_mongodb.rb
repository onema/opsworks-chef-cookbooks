execute 'install_php_mongo_driver' do
  command "pecl install mongo"
  action :run
end

template 'mongo.ini' do
  case node[:platform]
  when 'centos','redhat','fedora','amazon'
    path "/etc/php.d/mongo.ini"
  when 'debian','ubuntu'
    path "/etc/php5/conf.d/mongo.ini"
        not_if { ::File.exist?("/etc/php5/conf.d")}

    path "/etc/php5/mods-available/mongo.ini"
        not_if { ::File.exist?("/etc/php5/mods-available")}
  end
  source 'mongo.ini.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, resources(:service => 'apache2')
end

when 'debian','ubuntu'
  execute "enable_mongo" do
    command "php5enmod mongo"
    not_if { ::File.exist?("/etc/php5/mods-available")}
  end
end
