# Use pecl to install module
module_name = "mongo"

execute "install_php_#{module_name}_module" do
  command "pecl install #{module_name}"
  action :run
end

case node[:platform]
  when "centos","redhat","fedora","amazon"
    config_dir = "/etc/php.d/#{module_name}.ini"
  when "debian","ubuntu"
    if ::File.exists?("/etc/php5/conf.d"
      config_dir = "/etc/php5/conf.d/#{module_name}.ini"
    end

    if ::File.exists?("/etc/php5/mods-available")
      config_dir = "/etc/php5/mods-available/#{module_name}.ini"
    end
end

# Create template
template "#{config_dir}/#{module_name}.ini" do
  source "php_module.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(
    :module_name => "#{module_name}"
  )
  notifies :restart, resources(:service => "apache2")
end


# Place enable the module if required and restart apache
case node[:platform]
when "debian","ubuntu"
  execute "enable_#{module_name}" do
    user "root"
    command "php5enmod #{module_name} && service apache2 restart"
    only_if { ::File.exist?("/etc/php5/mods-available/#{module_name}.ini")}
  end
end