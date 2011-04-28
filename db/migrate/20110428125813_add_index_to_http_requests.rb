class AddIndexToHttpRequests < ActiveRecord::Migration
  def self.up
    add_index :http_requests, :created_at
  end
  def self.down
    remove_index :http_requests, :created_at
  end
end

