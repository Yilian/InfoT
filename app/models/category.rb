class Category < ActiveRecord::Base
  has_many :category_weibos, :dependent => :destroy 
  has_many :weibo_infos, :through => :category_weibos
    
  def total_categories
    Category.count
  end
  
  def total_root_categories
    count = 0
    @categories = Category.all
    @categories.each do |category|
      if category.parent_id == 0
        count += 1
      end
    end
    count
  end
  
  def scenery_spots_in_a_parent(parent_id)
    count = 0
    @categories.each do |category|
      if category.parent_id == parent_id
        count += 1
      end
    end
    count
  end 
  
end
