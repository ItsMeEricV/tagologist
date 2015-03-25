#!/usr/bin/env puma

#port        ENV['PORT']     || 3000

environment ENV['RACK_ENV'] || 'production'

daemonize true

pidfile 'tmp/pids/puma.pid'
state_path 'tmp/pids/puma.state'

# quiet
threads 0, 16
bind "unix:///srv/tagologist_website/shared/tmp/sockets/puma.sock"