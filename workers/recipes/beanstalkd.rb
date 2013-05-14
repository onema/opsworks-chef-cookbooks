#
# Taken from:
# http://docs.aws.amazon.com/opsworks/latest/userguide/gettingstarted.walkthrough.photoapp.3.html
#
node[:deploy].each do |application, deploy|
  script "start_beanstalkd" do
    interpreter "bash"
    user "root"
    cwd "/"
    code <<-EOH
    beanstalkd -d -l 127.0.0.1 -p 11300
    EOH
  end
end 
