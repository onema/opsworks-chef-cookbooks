#
# Uses values db config values set in the custom JSON of the Stack. 
#
node[:deploy].each do |application, deploy|

  template "#{deploy[:deploy_to]}/current/fuel/app/config/ses.php" do
    source "ses.php.erb"
    mode 0644
    group deploy[:group]

    if platform?("ubuntu")
      owner "www-data"
    elsif platform?("amazon")
      owner "apache"
    end

    variables(
      :access_key => (node[:custom_env][application.to_s][:ses][:access_key] rescue nil),
      :secret_key => (node[:custom_env][application.to_s][:ses][:secret_key] rescue nil)
    )

   only_if do
     File.directory?("#{deploy[:deploy_to]}/current/fuel/app/config")
   end
  end
end