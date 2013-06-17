node[:deploy].each do |application, deploy|
  
  template "#{deploy[:deploy_to]}/current/public/.htaccess" do
    source "htaccess.erb"
    owner deploy[:user] 
    group deploy[:group]
    mode "0660"

    variables( 
        :env => (node[:custom_env] rescue nil), 
        :environment => (node[:custom_env][application.to_s][:environment] rescue nil),
        :application => "#{application}" 
    )

    only_if do
     File.directory?("#{deploy[:deploy_to]}/current/public")
    end
  end
end