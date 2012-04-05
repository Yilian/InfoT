require 'will_paginate/array'
class HomeController < ApplicationController 
  
  def get_recommend_categories
    @recommends = Analysis.recommend_category_in_all
  end
  
  def get_root_categories
    @categories = Category.root_categories
  end
  
  def index
    @weibo_infos = WeiboInfo.paginate(:page=>params[:page], :order=>'created_at desc',
      :per_page => 10)
    get_recommend_categories 
    get_root_categories
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @weibo_infos }
    end  
  end
  
  
  def new
    weibo = Analysis.get_hot_in_all
    @weibo_infos = weibo.paginate(:page=>params[:page],:per_page => 10)  
    get_recommend_categories
    get_root_categories  

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @weibo_infos }
    end  
  end
  
end
