class AddTotalToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories, :total, :integer, :default => 0
  end

  def self.down
    remove_column :categories, :total
  end
end
