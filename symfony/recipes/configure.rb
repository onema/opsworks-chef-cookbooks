# see for more info:
# http://symfony.com/doc/2.2/book/installation.html
# https://help.ubuntu.com/community/FilePermissionsACLs

node[:deploy].each do |application, deploy|

  # Set ACL rules to give proper permission to cache and logs
  script "update_acl" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH
    mkdir -p app/cache app/logs
    mount -o remount,acl /srv/www 
    setfacl -R -m u:www-data:rwX -m u:ubuntu:rwX app/cache/ app/logs/
    setfacl -dR -m u:www-data:rwx -m u:ubuntu:rwx app/cache/ app/logs/
    EOH
  end

  # Create the parameters.yml file.
  include_recipe 'symfony::paramconfig'

  # Install dependencies using composer install
  include_recipe 'composer::install'

  # Clear and warm-up Symfony cache if warmup_cache option is defined in the application configuration
  if node[:custom_env][application.to_s].has_key?("warmup_cache")
      execute 'clear_symfony_cache_prod' do
        user    "root"
        cwd     "#{deploy[:deploy_to]}/current"
        command "php app/console cache:clear --env=prod --no-debug"
        action :run
      end
  end

end
