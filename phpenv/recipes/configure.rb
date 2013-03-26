node[:deploy].each do |application, deploy|
  
  template "#{deploy[:deploy_to]}/current/public/.htaccess" do
    source "htaccess.erb"
    group deploy[:group]
    mode "0660"

    if platform?("ubuntu")
      owner "www-data"
    elsif platform?("amazon")
      owner "apache"
    end

    variables( :env => node[:custom_env][application])

    only_if do
     File.directory?("#{deploy[:deploy_to]}/current/public")
    end
  end
end