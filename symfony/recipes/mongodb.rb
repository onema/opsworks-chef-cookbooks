# install the mongodb pecl
#php_pear "mongo" do
#  action :install
#end

#node[:deploy].each do |application, deploy|
#  script "install_php_mongodb" do
#    interpreter "bash"
#    user "root"
#    cwd "/"
#    code <<-EOH
#    pecl install mongo
#    EOH
#  end
#end 

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
  end
  source 'mongo.ini.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, resources(:service => 'apache2')
end