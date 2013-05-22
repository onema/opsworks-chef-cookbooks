# install the mongodb pecl
#php_pear "mongo" do
#  action :install
#end

node[:deploy].each do |application, deploy|
  script "install_php_mongodb" do
    interpreter "bash"
    user "root"
    cwd "/"
    code <<-EOH
    pecl install mongo
    EOH
  end
end 
