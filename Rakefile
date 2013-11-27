require "bundler/gem_tasks"

namespace :assets do
  desc "Compiles all assets"
  task :compile do
    puts "Compiling assets"
    require 'sprockets'
    assets = Sprockets::Environment.new
    assets.append_path 'assets/javascripts'
    assets.append_path 'assets/stylesheets'
    assets['application.js'].write_to('public/application.js')
    assets['application.css'].write_to('public/application.css')
  end
end
