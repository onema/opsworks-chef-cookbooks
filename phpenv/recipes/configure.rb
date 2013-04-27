node[:deploy].each do |application, deploy|
  
  template "#{deploy[:deploy_to]}/current/public/.htaccess" do
    source "htaccess.erb"
    owner deploy[:user] 
    group deploy[:group]
    mode "0660"

    node[:custom_env].each do |key, values|
        if key.to_s == application.to_s
            variables( :env => values, :application => "#{application}" )
        end
    end

    only_if do
     File.directory?("#{deploy[:deploy_to]}/current/public")
    end
  end
end