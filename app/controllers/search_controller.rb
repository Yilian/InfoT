require 'will_paginate/array'
class SearchController < ApplicationController
=begin  
  # search by category
  def index
    if params[:q]
      # @results = WeiboInfo.search(params[:q])
      category = Category.search(params[:q])
      result = []
      category.each do |c|
        c.weibo_infos.each do |weibo|
          result << weibo
        end
      end
      @results = result.paginate(:page=>params[:page],:per_page => 10) 
    end
    render :layout => false
  end
=end

  # search by weibo_infos
  def index
    if params[:q]
      result = WeiboInfo.search(params[:q])    
      @results = result.paginate(:page=>params[:page],:per_page => 10) 
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @results }
    end
  end
  
end
