class Category < ActiveRecord::Base
    
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
  
  def weibos_in_a_category(categoryID)
    categoryWeibos = CategoryWeibo.find(:all, :conditions => " category_id = '#{categoryID}'")
    
    weibos = []
    categoryWeibos.each do |cw|
      weibo = WeiboInfo.where(:weibo_id => cw.weibo_id).first
      weibos << weibo
    end
    return weibos
  end
   
end
