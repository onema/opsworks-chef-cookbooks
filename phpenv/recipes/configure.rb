node[:deploy].each do |application, deploy|
  
  template "#{deploy[:deploy_to]}/current/public/.htaccess" do
    source ".htaccess.erb"
    owner deploy[:user]
    group deploy[:group]
    mode "0660"
    variables :env => node[:custom_env][application]

    only_if { File.exists?("#{deploy[:deploy_to]}/current/public") }
  end

end