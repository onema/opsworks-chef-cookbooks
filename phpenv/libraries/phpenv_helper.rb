module Phpenv
  module Helper
    def self.pecl_install(module_name)

      # Use pecl to install module
      execute "install_php_#{module_name}_module" do
        command "pecl install #{module_name}"
        action :run
      end

      # Create template
      template "#{module_name}.ini" do
        case node[:platform]
        when "centos","redhat","fedora","amazon"
          path "/etc/php.d/#{module_name}.ini"
        when "debian","ubuntu"
          path "/etc/php5/conf.d/#{module_name}.ini"
              only_if { ::File.exist?("/etc/php5/conf.d")}

          path "/etc/php5/mods-available/#{module_name}.ini"
              only_if { ::File.exist?("/etc/php5/mods-available")}
        end
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
        user "root"
        execute "enable_#{module_name}" do
          command "php5enmod #{module_name} && service apache restart"
          only_if { ::File.exist?("/etc/php5/mods-available/#{module_name}")}
        end
      end
    end
  end
end
