#
#
node[:deploy].each do |application, deploy|
   execute "brunch_build" do
        command "brunch build"
        cwd "#{deploy[:deploy_to]}/current"
   end
end
