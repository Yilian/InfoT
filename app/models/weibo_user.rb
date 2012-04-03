class WeiboUser < ActiveRecord::Base
  has_many :weibo_infos, :dependent => :destroy
end
