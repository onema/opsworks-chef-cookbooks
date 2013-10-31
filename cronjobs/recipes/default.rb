node[:deploy].each do |application, deploy|

  node[:custom_env][application.to_s][:cron_jobs].each do |cron_values|
#    value_minute = cron_values[:minute]   rescue '*'
#    value_hour   = cron_values[:hour]     rescue '*'
#    value_day    = cron_values[:day]      rescue '*'
#    value_month  = cron_values[:month]    rescue '*'
#    value_weekday= cron_values[:weekday]  rescue '*'

    cron "#{cron_values[:name]}" do
      minute  "#{cron_values[:minute]}"
      hour    "#{cron_values[:hour]}"
      day     "#{cron_values[:day]}"
      month   "#{cron_values[:month]}"
      weekday "#{cron_values[:weekday]}"
      command "#{cron_values[:command]}"
    end
  end
end
