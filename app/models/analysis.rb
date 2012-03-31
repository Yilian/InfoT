
class Analysis 
  DAY = 86400 # 一天等于86400秒
  MONTH = 30 * DAY
  WEEK = 7 * DAY
  
  
  #返回所有微博中最热的200条微博
  def self.get_hot_in_all
    counts = Count.find(:all, :order=>'quantity desc', :limit => 200 )
    weibos = []
    counts.each do |count|
      weibos << WeiboInfo.where("weibo_id = '#{count.weibo_id}'").first
    end #end each
    return weibos
  end
  
  #返回一定时间内所有微博中最热的200条微博
  def self.get_hot_in_range(days, weeks=0, months=0)
    range = Time.now - ( days*DAY + weeks*WEEK + months*MONTH)
    counts = Count.where("created_at>=?",range).order('quantity desc').limit(200)
    weibos = []
    counts.each do |count|
      weibos << WeiboInfo.where("weibo_id = '#{count.weibo_id}'").first
    end #end each
    return weibos
  end
  
  
  
  #返回某景点微博中最热的200条微博
  def self.get_hot_in_category(category)
    weibos = category.weibos(category.id)
    return sort_weibo_by_count(weibos) 
  end
  
  #返回某景点一定时间内微博中最热的200条微博
  def self.get_hot_in_category_byRange(category, days, weeks=0, months=0)
    range = Time.now - ( days*DAY + weeks*WEEK + months*MONTH)
    weibos = category.weibos_in_a_range(category.id, range)
    return sort_weibo_by_count(weibos) 
  end
  
  
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
  
  
end