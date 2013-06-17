#
# Get the database information of a MySQL layer to generate the db.php config file
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
      :dbname => (deploy[:database][:database] rescue nil),
      :host => (deploy[:database][:host] rescue nil),
      :user => (deploy[:database][:username] rescue nil),
      :password => (deploy[:database][:password] rescue nil),
      :port => "3306"
    )

   only_if do
     File.directory?("#{deploy[:deploy_to]}/current/fuel/app/config/#{node[:custom_env][application.to_s][:environment]}")
   end
  end
end