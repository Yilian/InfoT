require "will_paginate/array"

class CountsController < ApplicationController
  # GET /counts
  # GET /counts.xml
  def index
    # 当counts为数据库对象时
    @counts = Count.paginate :page=>params[:page], :order=>'quantity desc',
      :per_page => 10
    
=begin
    # 当counts为数组时    
    counts = Count.find(:all,:order => "quantity desc")
     count = []
     counts.each do |c|
       count << c
     end
    @counts = count.paginate(:page=>params[:page],:per_page => 10) 
=end    
    # @ids = Count.select("weibo_id").where("quantity > 10").order("quantity desc")
   

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @counts }
    end
  end

  # GET /counts/1
  # GET /counts/1.xml
  def show
    @count = Count.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @count }
    end
  end

  # GET /counts/new
  # GET /counts/new.xml
  def new
    @count = Count.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @count }
    end
  end

  # GET /counts/1/edit
  def edit
    @count = Count.find(params[:id])
  end

  # POST /counts
  # POST /counts.xml
  def create
    @count = Count.new(params[:count])

    respond_to do |format|
      if @count.save
        format.html { redirect_to(@count, :notice => 'Count was successfully created.') }
        format.xml  { render :xml => @count, :status => :created, :location => @count }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @count.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /counts/1
  # PUT /counts/1.xml
  def update
    @count = Count.find(params[:id])

    respond_to do |format|
      if @count.update_attributes(params[:count])
        format.html { redirect_to(@count, :notice => 'Count was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @count.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /counts/1
  # DELETE /counts/1.xml
  def destroy
    @count = Count.find(params[:id])
    @count.destroy

    respond_to do |format|
      format.html { redirect_to(counts_url) }
      format.xml  { head :ok }
    end
  end
end
