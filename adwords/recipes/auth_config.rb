node[:deploy].each do |application, deploy|
  
  template "#{deploy[:deploy_to]}/current/#{node[:custom_env][application.to_s][:adwords][:path_to_auth]}/auth.ini" do
    source "auth.ini.erb"
    owner deploy[:user] 
    group deploy[:group]
    mode "0660"

    variables( 
        :developer_token => (node[:custom_env][application.to_s][:adwords][:developer_token] rescue nil),
        :user_agent => (node[:custom_env][application.to_s][:adwords][:user_agent] rescue nil),
        :client_id => (node[:custom_env][application.to_s][:adwords][:client_id] rescue nil),
        :client_secret => (node[:custom_env][application.to_s][:adwords][:client_secret] rescue nil),
        :refresh_token => (node[:custom_env][application.to_s][:adwords][:refresh_token] rescue nil)
    )

    only_if do
     File.directory?("#{deploy[:deploy_to]}/current/#{node[:custom_env][application.to_s][:adwords][:path_to_auth]}")
    end
  end
end
