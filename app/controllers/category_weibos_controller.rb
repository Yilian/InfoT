class CategoryWeibosController < ApplicationController
  # GET /category_weibos
  # GET /category_weibos.xml
  def index
    @category_weibos = CategoryWeibo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @category_weibos }
    end
  end

  # GET /category_weibos/1
  # GET /category_weibos/1.xml
  def show
    @category_weibo = CategoryWeibo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category_weibo }
    end
  end

  # GET /category_weibos/new
  # GET /category_weibos/new.xml
  def new
    @category_weibo = CategoryWeibo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @category_weibo }
    end
  end

  # GET /category_weibos/1/edit
  def edit
    @category_weibo = CategoryWeibo.find(params[:id])
  end

  # POST /category_weibos
  # POST /category_weibos.xml
  def create
    @category_weibo = CategoryWeibo.new(params[:category_weibo])

    respond_to do |format|
      if @category_weibo.save
        format.html { redirect_to(@category_weibo, :notice => 'Category weibo was successfully created.') }
        format.xml  { render :xml => @category_weibo, :status => :created, :location => @category_weibo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category_weibo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /category_weibos/1
  # PUT /category_weibos/1.xml
  def update
    @category_weibo = CategoryWeibo.find(params[:id])

    respond_to do |format|
      if @category_weibo.update_attributes(params[:category_weibo])
        format.html { redirect_to(@category_weibo, :notice => 'Category weibo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category_weibo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /category_weibos/1
  # DELETE /category_weibos/1.xml
  def destroy
    @category_weibo = CategoryWeibo.find(params[:id])
    @category_weibo.destroy

    respond_to do |format|
      format.html { redirect_to(category_weibos_url) }
      format.xml  { head :ok }
    end
  end
end
