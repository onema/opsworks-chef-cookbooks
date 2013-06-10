

#
# Add memory swap: This should be used in instances with low RAM to prevent 
# "out of memory" issues.
#
script "memory_swap" do
  interpreter "bash"
  user "root"
  cwd "#{deploy[:deploy_to]}"
  code <<-EOH
  /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=2048
  /sbin/mkswap /var/swap.1
  /sbin/swapon /var/swap.1
  EOH
end
