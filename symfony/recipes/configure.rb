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

  # Place environment variables in the .htaccess file in the web-root 
  template "#{deploy[:deploy_to]}/current/web/.htaccess" do
    source "htaccess.erb"
    owner deploy[:user] 
    group deploy[:group]
    mode "0660"

    variables( 
        :env => (node[:custom_env] rescue nil), 
        :application => "#{application}" 
    )

    only_if do
     File.directory?("#{deploy[:deploy_to]}/current/web")
    end
  end
  
  
  include_recipe 'composer::install'

  include_recipe 'symfony::paramconfig'

end