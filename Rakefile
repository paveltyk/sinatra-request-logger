require 'rubygems' if RUBY_VERSION < "1.9"
require 'bundler'

Bundler.require

require './config/initializers/active_record'
require './config/initializers/mongoid'

Dir['./models/**/*.rb'].each { |f| require f }

namespace :db do
  desc "migrate your database"
  task :migrate do
    migrations_path = File.expand_path(File.join(File.dirname(__FILE__), 'db', 'migrate'))
    puts migrations_path
    ActiveRecord::Migrator.migrate(migrations_path, ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
  end
end

namespace :mongoid do
  # gets a list of the mongoid models defined in the app/models directory
  def get_mongoid_models
    documents = []
    Dir.glob("./models/**/*.rb").sort.each do |file|
      model_path = file[0..-4].split('/')[2..-1]
      begin
        klass = model_path.map(&:classify).join('::').constantize
        if klass.ancestors.include?(Mongoid::Document) && !klass.embedded
          documents << klass
        end
      rescue => e
        # Just for non-mongoid objects that dont have the embedded
        # attribute at the class level.
      end
    end
    documents
  end

  def index_children(children)
    children.each do |model|
      Logger.new($stdout).info("Generating indexes for #{model}")
      model.create_indexes
      index_children(model.descendants)
    end
  end

  desc 'Create the indexes defined on your mongoid models'
  task :create_indexes do
    index_children(get_mongoid_models)
  end
end

