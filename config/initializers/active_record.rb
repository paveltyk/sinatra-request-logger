require 'active_record'
require 'mysql2'

dbconfig_file_path = File.expand_path(File.join(File.dirname(__FILE__), '..', 'database.yml'))
dbconfig = YAML::load File.open(dbconfig_file_path)
ActiveRecord::Base.establish_connection(dbconfig['production'].merge('adapter' => 'mysql2'))

