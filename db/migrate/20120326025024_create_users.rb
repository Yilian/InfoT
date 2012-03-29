class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer :original_id
      t.string :screen_name
      t.string :profile_img_url

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
