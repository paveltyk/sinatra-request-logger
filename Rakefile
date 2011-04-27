require './config/initializers/active_record'

namespace :db do
  desc "migrate your database"
  task :migrate do
    migrations_path = File.expand_path(File.join(File.dirname(__FILE__), 'db', 'migrate'))
    puts migrations_path
    ActiveRecord::Migrator.migrate(migrations_path, ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
  end
end

