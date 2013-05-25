node[:deploy].each do |application, deploy|

  template "#{deploy[:deploy_to]}/current/app/config/parameters.yml" do
    source "parameters.yml.erb"
    mode 0755
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
      :db => (deploy[:database][:database] rescue nil),
      :table => (node[:phpapp][:dbtable] rescue nil)
      :mailer_user => (node[:custom_env][application.to_s][:mailer_user] rescue nil)
      :mailer_password => (node[:custom_env][application.to_s][:mailer_password] rescue nil)
    )

   only_if do
     File.directory?("#{deploy[:deploy_to]}/current/app/config")
   end
  end
end