require 'will_paginate/array'

class WeiboInfosController < ApplicationController
  # GET /weibo_infos
  # GET /weibo_infos.xml
  def index

     #weibo = WeiboInfo.new
     #weibo.collect_weibo_by_categories
    # @weibo_infos = WeiboInfo.all
  
    # @weibo_infos = WeiboInfo.paginate(:page=>params[:page], :order=>'created_at desc',
    #  :per_page => 10)
    # weibo = WeiboInfo.where("retweeted_id>?",0).order("reposts desc").limit(200)

    weibo = Analysis.get_hot_in_all
    #weibo = Analysis.get_new_in_all    
    #weibo = Analysis.get_hot_in_range(1)
    @weibo_infos = weibo.paginate(:page=>params[:page],:per_page => 10)    

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @weibo_infos }
    end
  end

  # GET /weibo_infos/1
  # GET /weibo_infos/1.xml
  def show
    @weibo_info = WeiboInfo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @weibo_info }
    end
  end

  # GET /weibo_infos/new
  # GET /weibo_infos/new.xml
  def new
    @weibo_info = WeiboInfo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @weibo_info }
    end
  end

  # GET /weibo_infos/1/edit
  def edit
    @weibo_info = WeiboInfo.find(params[:id])
  end

  # POST /weibo_infos
  # POST /weibo_infos.xml
  def create
    @weibo_info = WeiboInfo.new(params[:weibo_info])

    respond_to do |format|
      if @weibo_info.save
        format.html { redirect_to(@weibo_info, :notice => 'Weibo info was successfully created.') }
        format.xml  { render :xml => @weibo_info, :status => :created, :location => @weibo_info }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @weibo_info.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /weibo_infos/1
  # PUT /weibo_infos/1.xml
  def update
    @weibo_info = WeiboInfo.find(params[:id])

    respond_to do |format|
      if @weibo_info.update_attributes(params[:weibo_info])
        format.html { redirect_to(@weibo_info, :notice => 'Weibo info was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @weibo_info.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /weibo_infos/1
  # DELETE /weibo_infos/1.xml
  def destroy
    @weibo_info = WeiboInfo.find(params[:id])
    @weibo_info.destroy

    respond_to do |format|
      format.html { redirect_to(weibo_infos_url) }
      format.xml  { head :ok }
    end
  end
end
