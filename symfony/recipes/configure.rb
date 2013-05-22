# see for more info:
# http://symfony.com/doc/2.2/book/installation.html
# https://help.ubuntu.com/community/FilePermissionsACLs

node[:deploy].each do |application, deploy|
  
  template "#{deploy[:deploy_to]}/current/web/.htaccess" do
    source "htaccess.erb"
    owner deploy[:user] 
    group deploy[:group]
    mode "0660"

    variables( :env => node[:custom_env], :application => "#{application}" )

    only_if do
     File.directory?("#{deploy[:deploy_to]}/current/web")
    end
  end
  
  script "update_acl" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH
    echo "UUID=07aebd28-24e3-cf19-e37d-1af9a23a45d4    /srv/www    ext4   defaults,acl   0   2" >> /etc/fstab
    mount -o remount /srv/www
    
    mkdir -p app/cache app/logs
    setfacl -R -m u:www-data:rwX -m u:ubuntu:rwX app/cache/ app/logs/
    setfacl -dR -m u:www-data:rwx -m u:ubuntu:rwx app/cache/ app/logs/
    EOH
  end
end