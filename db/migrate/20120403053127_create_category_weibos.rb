class CreateCategoryWeibos < ActiveRecord::Migration
  def self.up
    create_table :category_weibos do |t|
      t.integer :category_id
      t.integer :weibo_info_id
      t.integer :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :category_weibos
  end
end
