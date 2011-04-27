class CreateHttpRequests < ActiveRecord::Migration
  def self.up
    create_table :http_requests do |t|
      t.string :uri_string

      t.timestamps
    end
  end
  def self.down
    drop_table :http_requests
  end
end

