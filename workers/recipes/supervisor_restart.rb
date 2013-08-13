#
# Stop and shutdown supervisor followed by a restart
#
node[:deploy].each do |application, deploy|
  script "restart_supervisor" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH
    supervisorctl stop all
    supervisorctl shutdown
    supervisord
    EOH
  end
end 
