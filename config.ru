$:.unshift(File.expand_path('../lib', __FILE__))
require 'henshukumo'

run Sinatra::Application

# vim:ft=ruby
