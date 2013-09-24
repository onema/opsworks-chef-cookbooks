node[:deploy].each do |application, deploy|
  
  template "#{deploy[:deploy_to]}/current/#{node[:custom_env][application.to_s][:path_to_vars]}/environment_variables.php" do
    source "environment_variables.php.erb"
    owner deploy[:user] 
    group deploy[:group]
    mode "0666"

    variables( 
        :env => (node[:custom_env] rescue nil), 
        :environment => (node[:custom_env][application.to_s][:environment] rescue nil),
        :application => "#{application}" 
    )

    only_if do
     File.directory?("#{deploy[:deploy_to]}/current/#{node[:custom_env][application.to_s][:path_to_vars]}")
    end
  end
end
