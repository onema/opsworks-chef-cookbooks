#
# Doctrine MongoDB schema update.
#
node[:deploy].each do |application, deploy|
  script "run_migration" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH
    php app/console doctrine:mongodb:schema:update 
    EOH
  end
end
