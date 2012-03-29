class AddRetweetedIdToWeiboInfo < ActiveRecord::Migration
  def self.up
    add_column :weibo_infos, :retweeted_id, :integer, :default => 0
  end

  def self.down
    remove_column :weibo_infos, :retweeted_id
  end
end
