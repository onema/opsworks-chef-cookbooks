node[:deploy].each do |application, deploy|

  node[:custom_env][application.to_s][:cron_jobs].each do |cron_values|
    minute = cron_values[:minute]   rescue '*'
    hour   = cron_values[:hour]     rescue '*'
    day    = cron_values[:day]      rescue '*'
    month  = cron_values[:month]    rescue '*'
    weekday= cron_values[:weekday]  rescue '*'

    cron "#{cron_values[:name]}" do
      minute  "#{minute}"
      hour    "#{hour}"
      day     "#{day}"
      month   "#{month}"
      weekday "#{weekday}"
      command "#{command}"
    end
  end
end
