#
# Uses values pheanstalk config values set in the custom JSON of the Stack. 
#
node[:deploy].each do |application, deploy|

  template "#{deploy[:deploy_to]}/current/fuel/app/config/pheanstalk.php" do
    source "pheanstalk.php.erb"
    mode 0644
    group deploy[:group]

    if platform?("ubuntu")
      owner "www-data"
    elsif platform?("amazon")
      owner "apache"
    end

    variables(
      :host => (node[:custom_env][application.to_s][:pheanstalk][:host] rescue nil),
      :port => (node[:custom_env][application.to_s][:pheanstalk][:port] rescue nil)
    )

   only_if do
     File.directory?("#{deploy[:deploy_to]}/current/fuel/app/config")
   end
  end
end