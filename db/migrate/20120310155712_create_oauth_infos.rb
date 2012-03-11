class CreateOauthInfos < ActiveRecord::Migration
  def self.up
    create_table :oauth_infos do |t|
      t.string :atoken
      t.string :asecret

      t.timestamps
    end
  end

  def self.down
    drop_table :oauth_infos
  end
end
