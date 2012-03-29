class CreateWeiboInfos < ActiveRecord::Migration
  def self.up
    create_table :weibo_infos do |t|
      t.integer :weibo_id
      t.text :text
      t.string :original_create_at
      t.string :thumbnail_pic_url
      t.string :original_pic_url
      t.integer :weibo_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :weibo_infos
  end
end
