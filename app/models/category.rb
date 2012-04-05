class Category < ActiveRecord::Base
  has_many :category_weibos, :dependent => :destroy 
  has_many :weibo_infos, :through => :category_weibos
    
  def total_categories
    Category.count
  end
  
  def total_root_categories
    root_categories.size
  end
  
  def scenery_spots_in_a_parent(parent_id)
    sceneries_in_a_parent(parent_id).size
  end 
  
  def self.root_categories
    categories = Category.all
    roots = []
    categories.each do |category|
      if category.parent_id == 0 && category.id != 1 # when category.id = 1, category.name = "其它"
        roots << category
      end
    end
    roots << Category.find_by_id(1)
    return roots
  end
  
  def sceneries_in_a_parent(parent_id)
    categories = Category.all
    subCategories = []
    categories.each do |category|
      if category.parent_id == parent_id
        subCategories << category
      end
    end
    subCategories
  end 
  
  #search------------
  def self.search(query)
    if query 
      find(:all, :conditions => ['name LIKE ?', "%#{query}%"]) 
    else 
      find(:all) 
    end
    
  end
  #-------------------
  
end
