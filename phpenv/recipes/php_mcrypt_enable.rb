# Enable mcrypt module. Ubuntu 14.04 ONLY
module_name = "mcrypt"

# Place enable the module if required and restart apache
case node[:platform]
when "debian","ubuntu"
  user "root"
  execute "enable_#{module_name}" do
    command "php5enmod #{module_name} && service apache restart"
    only_if { ::File.exist?("/etc/php5/mods-available/#{module_name}")}
  end
end