#
# Uses values db config values set in the custom JSON of the Stack. 
#
node[:deploy].each do |application, deploy|

  template "#{deploy[:deploy_to]}/current/fuel/app/config/#{node[:custom_env][application.to_s][:environment]}/db.php" do
    source "db.php.erb"
    mode 0644
    group deploy[:group]

    if platform?("ubuntu")
      owner "www-data"
    elsif platform?("amazon")
      owner "apache"
    end

    variables(
      :dbname => (node[:custom_env][application.to_s][:database][:dbname] rescue nil),
      :host => (node[:custom_env][application.to_s][:database][:host] rescue nil),
      :user => (node[:custom_env][application.to_s][:database][:user] rescue nil),
      :password => (node[:custom_env][application.to_s][:database][:password] rescue nil),
      :port => (node[:custom_env][application.to_s][:database][:port] rescue nil)
    )

   only_if do
     File.directory?("#{deploy[:deploy_to]}/current/fuel/app/config/#{node[:custom_env][application.to_s][:environment]}")
   end
  end
end