node[:deploy].each do |application, deploy|

  node[:custom_env][application.to_s][:cron_jobs].each do |cron_values|
    value_minute = cron_values[:minute]   rescue '*'
    value_hour   = cron_values[:hour]     rescue '*'
    value_day    = cron_values[:day]      rescue '*'
    value_month  = cron_values[:month]    rescue '*'
    value_weekday= cron_values[:weekday]  rescue '*'

    cron "#{cron_values[:name]}" do
      minute  value_minute.to_s
      hour    value_hour.to_s
      day     value_day.to_s
      month   value_month.to_s
      weekday value_weekday.to_s
      command "#{cron_values[:command]}"
    end
  end
end
