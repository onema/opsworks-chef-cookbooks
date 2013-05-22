script "acl_setup" do
  interpreter "bash"
  user "root"
  cwd "/"
  code <<-EOH
  echo "UUID=07aebd28-24e3-cf19-e37d-1af9a23a45d4    /srv/www    ext4   defaults,acl   0   2" >> /etc/fstab
  mount -o remount /srv/www
  EOH
end