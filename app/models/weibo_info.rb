require 'weibo'
require 'crack'

# 微博应用的授权码
Weibo::Config.api_key = "4178706590"
Weibo::Config.api_secret = "0a4b74b632fb7f41f001aa5c23b60b87"

class WeiboInfo < ActiveRecord::Base
   
  # 根据分类景点搜索微博信息
  def collect_weibo_by_categories
    
    info = OauthInfo.find_by_id(1)           
    client = Weibo::OAuth.new(Weibo::Config.api_key, Weibo::Config.api_secret)      
    client.authorize_from_access(info.atoken, info.asecret)
    @baseEntry = Weibo::Base.new(client)
    
    categories = Category.all
    categories.each do |category|
      next if category.parent_id == 0
      search_weibo = @baseEntry.status_search("#{category.name}",{'count' => 1})
      #search_weibo = @baseEntry.status_search("七星岩",{'count' => 1})
=begin
      if search_weibo.retweeted_status
        WeiboInfo.new( :weibo_id => search_weibo.id,\
                     :text => search_weibo.text,\
                     :original_create_at => search_weibo.create_at,\
                     :thumbnail_pic_url => search_weibo.thumbnail_pic,\
                     :original_pic_url => search_weibo.original_pic,\
                     :weibo_user_id => search_weibo.user.id,\
                     :retweeted_id => search_weibo.retweeted_status.id ).save
        set_count_data(search_weibo.id)
        
        WeiboInfo.new( :weibo_id => search_weibo.retweeted_status.id,\
                     :text => search_weibo.retweeted_status.text,\
                     :original_create_at => search_weibo.retweeted_status.create_at,\
                     :thumbnail_pic_url => search_weibo.retweeted_status.thumbnail_pic,\
                     :original_pic_url => search_weibo.retweeted_status.original_pic,\
                     :weibo_user_id => search_weibo.retweeted_status.user.id ).save
        set_count_data(search_weibo.retweeted_status.id)
      else
        WeiboInfo.new( :weibo_id => search_weibo.id,\
                     :text => search_weibo.text,\
                     :original_create_at => search_weibo.create_at,\
                     :thumbnail_pic_url => search_weibo.thumbnail_pic,\
                     :original_pic_url => search_weibo.original_pic,\
                     :weibo_user_id => search_weibo.user.id).save
        set_count_data(search_weibo.id)
      end                    
=end    
      search_weibo.each do |weibo|
        if weibo.retweeted_status
          # 获取微博相关信息
          set_weiboInfo(weibo, category)
        
          # 获取被转发的微博的信息
          set_original_weiboInfo(weibo.retweeted_status, category)       
        else
          # 获取微博相关信息
          set_original_weiboInfo(weibo, category)
        end # end if
      end# end weibo_each
       
    end# end each
    
  end # end get_weibo_by_categories
  
  
  private
  def classify_again( category, info )
    case category.name
    when "其它"
      classify_others_by_categories(info)
    else
      classify_categories_by_others(info)
    end # end case
  end
  
  # 将其它类下的微博信息，再次分类为具体的景点信息
  def classify_others_by_categories(info)
    
  end
  
  # 将具体的景点信息，再次分类为其它类下的具体信息
  def classify_categories_by_others(info)
    
  end
  
  # 获取微博信息
  def set_weiboInfo(weibo, category)
    # 如果该微博已存在，则不保存该微博
    if WeiboInfo.where(:weibo_id => weibo.id).first
      return false
    else
      @total = 0
      WeiboInfo.new( :weibo_id => weibo.id,\
                     :text => weibo.text,\
                     :original_create_at => weibo.created_at,\
                     :thumbnail_pic_url => weibo.thumbnail_pic,\
                     :original_pic_url => weibo.original_pic,\
                     :weibo_user_id => weibo.user.id,\
                     :retweeted_id => weibo.retweeted_status.id ).save
      set_userInfo(weibo)
      set_count_data(weibo.id)
      set_weiboCategory(weibo.id, category.id)
      category.total += @total
      category.save                  
    end # end if
    return true
  end
  
  # 获取原创的微博信息
  def set_original_weiboInfo(weibo, category)
    if WeiboInfo.where(:weibo_id => weibo.id).first
      return false
    else
      @total = 0
      WeiboInfo.new( :weibo_id => weibo.id,\
                     :text => weibo.text,\
                     :original_create_at => weibo.created_at,\
                     :thumbnail_pic_url => weibo.thumbnail_pic,\
                     :original_pic_url => weibo.original_pic,\
                     :weibo_user_id => weibo.user.id ).save
      set_userInfo(weibo)
      set_count_data(weibo.id)
      set_weiboCategory(weibo.id, category.id)
      category.total += @total
      category.save
    end # end if
    return true
  end
                   
    
  # 获取微博的点击量
  def set_count_data(weibo_id)
    count_data = @baseEntry.counts( :ids => weibo_id.to_s )
    count_data.each do |data| 
      @total = data.comments + data.rt     
      Count.new( :weibo_id => weibo_id,\
                 :comments => data.comments,\
                 :reposts => data.rt,\
                 :quantity => @total ).save     
    end
  end
  
  # 获取发表微博的用户信息
  def set_userInfo(weibo)
    if User.where(:original_id => weibo.user.id).first
      return
    else
      User.new( :original_id => weibo.user.id,\
              :screen_name => weibo.user.screen_name,\
              :profile_img_url => weibo.user.profile_image_url ).save
    end   
  end
  
  # 设置微博信息的分类
  def set_weiboCategory(weiboId, categoryId)
    CategoryWeibo.new(:weibo_id => weiboId,\
                      :category_id => categoryId).save
  end
     
end

