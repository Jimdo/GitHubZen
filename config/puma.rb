#!/usr/bin/env puma

threads ENV['WEB_THREADS_MIN'] || 8, ENV['WEB_THREADS_MIN'] || 32
workers ENV['WEB_WORKER'] || 3
environment ENV['RACK_ENV'] || 'production'
bind "tcp://0.0.0.0:#{ENV['PORT'] || 9292}"
preload_app!
