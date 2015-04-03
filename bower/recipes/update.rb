#
# Taken from:
# http://docs.aws.amazon.com/opsworks/latest/userguide/gettingstarted.walkthrough.photoapp.3.html
#
node[:deploy].each do |application, deploy|
   execute "bower_install" do
        command "bower update"
        cwd "#{deploy[:deploy_to]}/current"
   end
end
