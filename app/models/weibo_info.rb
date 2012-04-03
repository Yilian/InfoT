require 'weibo'
require 'crack'

# 微博应用的授权码
Weibo::Config.api_key = "4178706590"
Weibo::Config.api_secret = "0a4b74b632fb7f41f001aa5c23b60b87"

class WeiboInfo < ActiveRecord::Base
  has_many :category_weibos, :dependent => :destroy
  belongs_to :weibo_user
  
  @queue = "weibo"
  
  #自动下载微博信息接口
  def self.perform
    puts "Start"
    puts Time.now
    
    info = OauthInfo.find_by_id(1)           
    client = Weibo::OAuth.new(Weibo::Config.api_key, Weibo::Config.api_secret)      
    client.authorize_from_access(info.atoken, info.asecret)
    @baseEntry = Weibo::Base.new(client)
    
    # puts "Category.count: #{Category.count}"
    
    categories = Category.all
    categories.each do |category|
      next if category.parent_id == 0
      puts "CategoryID: #{category.id}"
      puts "CategoryEach:+#{Time.now}"
      search_weibo = @baseEntry.status_search("#{category.name}",{'count' => 8})
           
      search_weibo.each do |weibo|       
        # puts "getting info"        
        if weibo.retweeted_status && weibo.retweeted_status.text.include?("#{category.name}")
          # 存储微博相关信息
          # set_weiboInfo(weibo, category)
          # 如果该微博已存在，则不保存该微博
          if WeiboInfo.where(:weibo_id => weibo.id).first == nil
            # puts "set weibo info"
            # 获取微博的点击量
            count_data = @baseEntry.counts( :ids => weibo.id.to_s )
            count_data.each do |data| 
              @quantity = data.comments + data.rt     
              @comments = data.comments
              @reposts = data.rt    
            end            
            # 存储发表微博的用户信息
            if WeiboUser.where(:original_id => weibo.user.id).first
              @user = WeiboUser.where(:original_id => weibo.user.id).first
            else
              # puts "set user info"
              @user = WeiboUser.new( :original_id => weibo.user.id,\
                                     :screen_name => weibo.user.screen_name,\
                                     :profile_img_url => weibo.user.profile_image_url )
              @user.save
            end
            # 存储微博相关信息
            @weiboInfo = WeiboInfo.new( :weibo_id => weibo.id,\
                                        :text => weibo.text,\
                                        :original_create_at => weibo.created_at,\
                                        :thumbnail_pic_url => weibo.thumbnail_pic,\
                                        :original_pic_url => weibo.original_pic,\
                                        :weibo_user_id => @user.id,\
                                        :retweeted_id => weibo.retweeted_status.id,\
                                        :comments => @comments,\
                                        :reposts => @reposts )
            @weiboInfo.save                
            # 设置微博信息的分类
            # puts "set categoryWeibo info"
            CategoryWeibo.new(:weibo_info_id => @weiboInfo.id,\
                              :category_id => category.id,\
                              :quantity => @quantity).save
            category.total += @quantity
            category.save
          end# end inner if                  
        
          # 存储被转发的微博的信息
          # set_original_weiboInfo(weibo.retweeted_status, category)
          # 如果该微博已存在，则不保存该微博
          if WeiboInfo.where(:weibo_id => weibo.retweeted_status.id).first == nil
            # puts "set weibo info"
            # 获取微博的点击量
            count_data = @baseEntry.counts( :ids => weibo.retweeted_status.id.to_s )
            count_data.each do |data| 
              @quantity = data.comments + data.rt     
              @comments = data.comments
              @reposts = data.rt    
            end
            # 存储发表微博的用户信息
            if WeiboUser.where(:original_id => weibo.retweeted_status.user.id).first
              @user = WeiboUser.where(:original_id => weibo.retweeted_status.user.id).first
            else
              # puts "set user info"
              @user = WeiboUser.new( :original_id => weibo.retweeted_status.user.id,\
                                     :screen_name => weibo.retweeted_status.user.screen_name,\
                                     :profile_img_url => weibo.retweeted_status.user.profile_image_url )
              @user.save
            end               
            # 存储被转发的微博的信息
            @weiboInfo = WeiboInfo.new( :weibo_id => weibo.retweeted_status.id,\
                           :text => weibo.retweeted_status.text,\
                           :original_create_at => weibo.retweeted_status.created_at,\
                           :thumbnail_pic_url => weibo.retweeted_status.thumbnail_pic,\
                           :original_pic_url => weibo.retweeted_status.original_pic,\
                           :weibo_user_id => @user.id,\
                           :comments => @comments,\
                           :reposts => @reposts)
            @weiboInfo.save
                             
            # 设置微博信息的分类
            # puts "set categoryWeibo info"
            CategoryWeibo.new(:weibo_info_id => @weiboInfo.id,\
                              :category_id => category.id,\
                              :quantity => @quantity ).save
            category.total += @quantity
            category.save
          end# end inner if        
        else
          # puts "start getting info"
          # 存储微博相关信息
          # set_original_weiboInfo(weibo, category)
          # 如果该微博已存在，则不保存该微博
          if WeiboInfo.where(:weibo_id => weibo.id).first == nil
            # puts "set weibo info"
            # 获取微博的点击量
            count_data = @baseEntry.counts( :ids => weibo.id.to_s )
            count_data.each do |data| 
              @quantity = data.comments + data.rt     
              @comments = data.comments
              @reposts = data.rt    
            end
            # 存储发表微博的用户信息
            if WeiboUser.where(:original_id => weibo.user.id).first
              @user = WeiboUser.where(:original_id => weibo.user.id).first
            else
              # puts "set user info"
              @user = WeiboUser.new( :original_id => weibo.user.id,\
                                     :screen_name => weibo.user.screen_name,\
                                     :profile_img_url => weibo.user.profile_image_url )
              @user.save
            end               
             # 存储微博相关信息
            @weiboInfo = WeiboInfo.new( :weibo_id => weibo.id,\
                                        :text => weibo.text,\
                                        :original_create_at => weibo.created_at,\
                                        :thumbnail_pic_url => weibo.thumbnail_pic,\
                                        :original_pic_url => weibo.original_pic,\
                                        :weibo_user_id => @user.id,\
                                        :comments => @comments,\
                                        :reposts => @reposts )
            @weiboInfo.save
          
            # 设置微博信息的分类
            # puts "set categoryWeibo info"
            CategoryWeibo.new(:weibo_info_id => @weiboInfo.id,\
                              :category_id => category.id,\
                              :quantity => @quantity ).save
            category.total += @quantity
            category.save
          end# end inner if 
        end # end if
      end# end weibo_each
      puts "CategoryEachEnd:+#{Time.now}" 
    end# end each
    puts Time.now
    puts "Done"
  end
   
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
      search_weibo.each do |weibo|
        if weibo.retweeted_status && weibo.retweeted_status.text.include?("#{category.name}")
          # 存储微博相关信息
          set_weiboInfo(weibo, category)       
          # 存储被转发的微博的信息
          set_original_weiboInfo(weibo.retweeted_status, category)
        else
          # 存储微博相关信息
          set_original_weiboInfo(weibo, category)          
        end # end if      
      end# end weibo_each       
    
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
  
  # 存储微博信息
  def set_weiboInfo(weibo, category)
    # 如果该微博已存在，则不保存该微博
    if WeiboInfo.where(:weibo_id => weibo.id).first
      return 
    else
      get_count_data(weibo.id)
      set_userInfo(weibo) 
      @weiboInfo = WeiboInfo.new( :weibo_id => weibo.id,\
                                  :text => weibo.text,\
                                  :original_create_at => weibo.created_at,\
                                  :thumbnail_pic_url => weibo.thumbnail_pic,\
                                  :original_pic_url => weibo.original_pic,\
                                  :weibo_user_id => @user.id,\
                                  :retweeted_id => weibo.retweeted_status.id,\
                                  :comments => @comments,\
                                  :reposts => @reposts )
      @weiboInfo.save          
      set_weiboCategory(weibo.id, category.id)
      category.total += @quantity
      category.save                  
    end # end if
  end
  
  # 存储原创的微博信息
  def set_original_weiboInfo(weibo, category)
    if WeiboInfo.where(:weibo_id => weibo.id).first
      return 
    else
      get_count_data(weibo.id)
      set_userInfo(weibo)
      @weiboInfo = WeiboInfo.new( :weibo_id => weibo.id,\
                                  :text => weibo.text,\
                                  :original_create_at => weibo.created_at,\
                                  :thumbnail_pic_url => weibo.thumbnail_pic,\
                                  :original_pic_url => weibo.original_pic,\
                                  :weibo_user_id => @user.id,\
                                  :comments => @comments,\
                                  :reposts => @reposts )
      @weiboInfo.save 
      set_weiboCategory(weibo.id, category.id)
      category.total += @quantity
      category.save
    end # end if
  end
                   
  
  # 存储发表微博的用户信息
  def set_userInfo(weibo)
    if WeiboUser.where(:original_id => weibo.user.id).first
      @user = WeiboUser.where(:original_id => weibo.user.id).first
    else
      @user = WeiboUser.new( :original_id => weibo.user.id,\
                             :screen_name => weibo.user.screen_name,\
                             :profile_img_url => weibo.user.profile_image_url )
      @user.save
    end   
  end
  
  def get_count_data(weiboID)
    count_data = @baseEntry.counts( :ids => weiboID.to_s )
    count_data.each do |data| 
      @quantity = data.comments + data.rt     
      @comments = data.comments
      @reposts = data.rt    
    end
  end
  
  # 设置微博信息的分类
  def set_weiboCategory(weiboId, categoryId)
    CategoryWeibo.new(:weibo_info_id => @weiboInfo.id,\
                      :category_id => categoryId,\
                      :quantity => @quantity ).save
  end
     
end

