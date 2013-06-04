node[:deploy].each do |application, deploy|

  template "#{deploy[:deploy_to]}/current/fuel/app/config/#{node[:application][:environment]}/db.php" do
    source "db.php.erb"
    mode 0660
    group deploy[:group]

    if platform?("ubuntu")
      owner "www-data"
    elsif platform?("amazon")
      owner "apache"
    end

    variables(
      :dbname => (node[:application][:database][:dbname] rescue nil),
      :host => (node[:application][:database][:host] rescue nil),
      :user => (node[:application][:database][:username] rescue nil),
      :password => (node[:application][:database][:password] rescue nil),
      :port => (node[:application][:database][:port] rescue nil)
    )

   only_if do
     File.directory?("#{deploy[:deploy_to]}/current/fuel/app/config/{node[:environment]}")
   end
  end
end