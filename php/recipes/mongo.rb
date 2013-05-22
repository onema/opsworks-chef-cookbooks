node[:deploy].each do |application, deploy|
  script "install_php_mongo" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH
    pecl install mongo
    EOH
  end
end 
