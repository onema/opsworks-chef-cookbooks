script "acl_setup" do
  interpreter "bash"
  user "root"
  cwd "/"
  code <<-EOH
  apt-get install acl
  echo "UUID=07aebd28-24e3-cf19-e37d-1af9a23a45d4    /srv/www    ext4   defaults,acl   0   2" >> /etc/fstab
  mount -o remount,acl /srv/www 
  EOH
end