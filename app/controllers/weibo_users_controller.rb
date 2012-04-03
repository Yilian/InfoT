class WeiboUsersController < ApplicationController
  # GET /weibo_users
  # GET /weibo_users.xml
  def index
    @weibo_users = WeiboUser.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @weibo_users }
    end
  end

  # GET /weibo_users/1
  # GET /weibo_users/1.xml
  def show
    @weibo_user = WeiboUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @weibo_user }
    end
  end

  # GET /weibo_users/new
  # GET /weibo_users/new.xml
  def new
    @weibo_user = WeiboUser.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @weibo_user }
    end
  end

  # GET /weibo_users/1/edit
  def edit
    @weibo_user = WeiboUser.find(params[:id])
  end

  # POST /weibo_users
  # POST /weibo_users.xml
  def create
    @weibo_user = WeiboUser.new(params[:weibo_user])

    respond_to do |format|
      if @weibo_user.save
        format.html { redirect_to(@weibo_user, :notice => 'Weibo user was successfully created.') }
        format.xml  { render :xml => @weibo_user, :status => :created, :location => @weibo_user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @weibo_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /weibo_users/1
  # PUT /weibo_users/1.xml
  def update
    @weibo_user = WeiboUser.find(params[:id])

    respond_to do |format|
      if @weibo_user.update_attributes(params[:weibo_user])
        format.html { redirect_to(@weibo_user, :notice => 'Weibo user was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @weibo_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /weibo_users/1
  # DELETE /weibo_users/1.xml
  def destroy
    @weibo_user = WeiboUser.find(params[:id])
    @weibo_user.destroy

    respond_to do |format|
      format.html { redirect_to(weibo_users_url) }
      format.xml  { head :ok }
    end
  end
end
