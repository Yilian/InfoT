
class Analysis 
  DAY = 86400 # 一天等于86400秒
  MONTH = 30 * DAY
  WEEK = 7 * DAY
  #*****************************************************************
  #                           推荐景点
  #*****************************************************************
  # 总推荐景点10个
  def self.recommend_category_in_all
    categories = Category.where("parent_id>?",1).order('total desc').limit(10)
  end
  
  # 某时间段内推荐景点10个
  def self.recommend_category_in_range(days, weeks=0, months=0)
    range = Time.now - ( days*DAY + weeks*WEEK + months*MONTH)
    # do somethinga
  end
  
  
  #*****************************************************************
  #                           最新
  #*****************************************************************
  #返回所有微博中最新的500条微博
  def self.get_new_in_all_limited
    weibos = WeiboInfo.find(:all, :order=>'created_at desc', :limit => 500 )
    return weibos
  end
  
  #返回某景点的微博中最新的500条微博
  def self.get_new_in_category_limited(category)
    categoryWeibos = CategoryWeibo.where(:category_id => category.id).order('created_at desc').limit(500)
    
    weibos = []
    categoryWeibos.each do |cw|
      weibos << cw.weibo_info
    end
    return weibos
  end
  
  
  #*****************************************************************
  #                           最热
  #*****************************************************************
  #返回所有微博中最热的500条微博
  def self.get_hot_in_all
    #categoryWeibos = CategoryWeibo.order('quantity desc').all
    categoryWeibos = CategoryWeibo.find(:all, :order=>'quantity desc', :limit => 500 )
    weibos = []
    categoryWeibos.each do |cw|
      weibos << cw.weibo_info
    end 
    return weibos
  end
  
  #返回一定时间内所有微博中最热的500条微博
  def self.get_hot_in_range(days, weeks=0, months=0)
    range = Time.now - ( days*DAY + weeks*WEEK + months*MONTH)
    categoryWeibos = CategoryWeibo.where("created_at>=?",range).order('quantity desc').limit(500)
    weibos = []
    categoryWeibos.each do |cw|
      weibos << WeiboInfo.where("id = '#{cw.weibo_info_id}'").first
    end #end each
    return weibos
  end
  
     
  #返回某景点微博中最热的500条微博
  def self.get_hot_in_category(category)
    categoryWeibos = CategoryWeibo.where(:category_id => category.id).order('quantity desc').limit(500)
    
    weibos = []
    categoryWeibos.each do |cw|
      weibos << WeiboInfo.where(:id => cw.weibo_info_id).first
    end
    return weibos 
  end
  
  #返回某景点一定时间内微博中最热的500条微博
  def self.get_hot_in_category_byRange(category, days, weeks=0, months=0)
    range = Time.now - ( days*DAY + weeks*WEEK + months*MONTH)
    categoryWeibos = CategoryWeibo.where(["category_id=? and created_at>=?",category.id,range]).order('quantity desc').limit(500)
    weibos = []
    categoryWeibos.each do |cw|
      weibos << cw.weibo_info
    end #end each
    return weibos 
  end
   
  
=begin  
  # 删除了Count数据表
  def self.sort_weibo_by_count(weibos)
    weibo_quantity = Array.new   
    #获取每个微博的评论数+转发数之和quantity，将两者以对应关系存入二维数组weibo_quantity
    weibos.each do |weibo|
      count = Count.select("quantity").where(:weibo_id => weibo.weibo_id).first
      weibo_quantity << [weibo,count.quantity]
    end    
    # 调用ruby内二维数组的排序方法对quantity进行由降序排列
    weibo_quantity.sort!{|x,y| y[1] <=> x[1]}   
    # 获取排序后的微博数组
    weibos.clear
    0.upto(weibo_quantity.size - 1) do |i|
      weibos << weibo_quantity[i][0]
    end
    return weibos, weibo_quantity
  end
=end  
  
end