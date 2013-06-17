node[:deploy].each do |application, deploy|

  template "#{deploy[:deploy_to]}/current/app/config/parameters.yml" do
    source "parameters.yml.erb"
    mode 0644
    group "root"

    if platform?("ubuntu")
      owner "deploy"
   elsif platform?("amazon")
      owner "deploy"
    end

    variables(
      :host => (deploy[:database][:host] rescue nil),
      :user => (deploy[:database][:username] rescue nil),
      :password => (deploy[:database][:password] rescue nil),
      :dbname => (deploy[:database][:dbname] rescue nil),
      :parameters => (node[:custom_env]  rescue nil), 
      :application => ("#{application}"  rescue nil) 
    )

   only_if do
     File.directory?("#{deploy[:deploy_to]}/current/app/config")
   end
  end
end