node[:deploy].each do |application, deploy|

  node[:custom_env][application.to_s][:cron_jobs].each do |cron_name, cron_values|
    cron "#{cron_name.to_s}" do
      hour    "#{cron_values[:hour]}"
      minute  "#{cron_values[:minute]}"
      weekday "#{cron_values[:weekday]}"
      command "#{cron_values[:command]}"
    end
  end
end
