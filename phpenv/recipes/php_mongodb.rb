# Install a pecl module
::Chef::Resource.send(:include, Phpenv::Helper)
pecl_install("mongo")
