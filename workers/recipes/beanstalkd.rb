#
# Manage access through security gropus as this will give access to any IP Address
#
node[:deploy].each do |application, deploy|
  script "start_beanstalkd" do
    interpreter "bash"
    user "root"
    cwd "/"
    code <<-EOH
    beanstalkd -d -l 0.0.0.0 -p 11300
    EOH
  end
end 
