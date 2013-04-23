node[:deploy].each do |application, deploy|
  
  template "#{deploy[:deploy_to]}/current/public/.htaccess" do
    source "htaccess.erb"
    owner deploy[:user] 
    group deploy[:group]
    mode "0660"

    puts node[:opsworks][:application]
    puts application[:name]

    variables( :env => node[:custom_env] )

    only_if do
     File.directory?("#{deploy[:deploy_to]}/current/public")
    end
  end
end