# Use pecl to install module
execute 'install_php_mongo_module' do
  command "pecl install mongo"
  action :run
end

# Find out where to place the ini file
case node[:platform]
when 'centos','redhat','fedora','amazon'
  path_to_ini = "/etc/php.d"

when 'debian','ubuntu'
  if ::File.exist?("/etc/php5/mods-available")
    path_to_ini = "/etc/php5/mods-available"
  else
    path_to_ini = "/etc/php5/conf.d"
  end
end

# Use template resource to set the ini file in the correct location
template "#{path_to_ini}/mongo.ini" do
  source "php_module.ini.erb"
  owner root
  group root
  mode "0644"
  variables(
    :module_name => "mongo"
  )
  only_if do
    File.directory?("#{path_to_ini}")
  end
  notifies :restart, resources(:service => 'apache2')
end

# enable module and restart apache
case node[:platform]
when 'debian','ubuntu'
  script "enable_php_mongo_driver" do
    interpreter "bash"
    user "root"

    code <<-EOH
      php5enmod mongo
      service apache restart
    EOH
    only_if do
      File.directory?("/etc/php5/mods-available")
    end
  end
end
