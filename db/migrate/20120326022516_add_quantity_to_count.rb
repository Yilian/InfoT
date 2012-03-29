class AddQuantityToCount < ActiveRecord::Migration
  def self.up
    add_column :counts, :quantity, :integer
  end

  def self.down
    remove_column :counts, :quantity
  end
end
