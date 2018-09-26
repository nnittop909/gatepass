#!/usr/bin/env puma
environment ENV['RAILS_ENV'] || 'production'
daemonize true
pidfile "/var/www/gatepass/shared/tmp/pids/puma.pid"
stdout_redirect "/var/www/gatepass/shared/tmp/log/stdout", "/var/www/gatepass/shared/tmp/log/stderr"
threads 0, 16
bind "unix:///var/www/gatepass/shared/tmp/sockets/puma.sock"
