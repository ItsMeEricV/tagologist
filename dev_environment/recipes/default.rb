#
# Cookbook Name:: rails-config
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

rbenv_ruby '2.1.5' do
  global true
end

rbenv_gem "bundler" do
  ruby_version '2.1.5'
end