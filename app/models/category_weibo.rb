class CategoryWeibo < ActiveRecord::Base
  belongs_to :category
  belongs_to :weibo_info
end
