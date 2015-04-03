#
# Taken from:
# http://docs.aws.amazon.com/opsworks/latest/userguide/gettingstarted.walkthrough.photoapp.3.html
#
node[:deploy].each do |application, deploy|
   execute "bower_install" do

        user deploy[:user]
        command "bower install --allow-root"
        cwd "#{deploy[:deploy_to]}/current"
        only_if do :: File::exists?('./bower.json') end
   end
end
