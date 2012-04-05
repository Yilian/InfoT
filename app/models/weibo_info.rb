require 'weibo'
require 'crack'


class WeiboInfo < ActiveRecord::Base
  has_many :category_weibos, :dependent => :destroy
  belongs_to :weibo_user
  
  #search------------
  def self.search(query)
    
    if query 
      # @weibos = find(:all, :conditions => ['text LIKE ?', "%#{query}%"])
      find(:all, :conditions => ['text LIKE ?', "%#{query}%"])  
    else 
      # @weibos = find(:all)
      find(:all)  
    end   
    # return weibo with user
=begin
    results = []
    @weibos.each do |weibo|
      results << [weibo, weibo.weibo_user]
    end 
    return results  
=end    
  end
  #-------------------
  
  def retweeted_weibo
    if retweeted_id != 0
      WeiboInfo.where(:weibo_id => retweeted_id).first
    end
  end
     
end

