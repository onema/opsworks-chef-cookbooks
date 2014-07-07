# Install a pecl module
Chef::Resource::User.send(:include, Phpenv::Helper)
pecl_install("redis")
