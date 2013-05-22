node[:deploy].each do |app_name, deploy|

  template "#{deploy[:deploy_to]}/current/app/config/parameters.yml" do
    source "parameters.yml.erb"
    mode 0755
    group deploy

    if platform?("ubuntu")
      owner "root"
   elsif platform?("amazon")
      owner "root"
    end

    variables(
      :host => (deploy[:database][:host] rescue nil),
      :user => (deploy[:database][:username] rescue nil),
      :password => (deploy[:database][:password] rescue nil),
      :db => (deploy[:database][:database] rescue nil),
      :table => (node[:phpapp][:dbtable] rescue nil)
    )

   only_if do
     File.directory?("#{deploy[:deploy_to]}/current/app/config")
   end
  end
end