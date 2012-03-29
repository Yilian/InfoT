require 'weibo'
require 'crack'

# 微博应用的授权码
Weibo::Config.api_key = "4178706590"
Weibo::Config.api_secret = "0a4b74b632fb7f41f001aa5c23b60b87"

class OauthInfosController < ApplicationController
  # GET /oauth_infos
  # GET /oauth_infos.xml
  
  def index
    @oauth_info = OauthInfo.find_by_id(1)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @oauth_infos }
    end
  end


  # 连接获取授权，获取授权后，转到授权信息主页
  # 获取授权，需在新浪的授权页输入： username： weibolunwen@sina.com   password: kkylylysott123
  def new
    oauth = Weibo::OAuth.new(Weibo::Config.api_key, Weibo::Config.api_secret)  
    request_token = oauth.consumer.get_request_token
    session[:rtoken], session[:rsecret] = request_token.token, request_token.secret
    redirect_to "#{request_token.authorize_url}&oauth_callback=http://#{request.env["HTTP_HOST"]}/callback"   
  end
  
  # 获取访问授权码
  def callback
    oauth = Weibo::OAuth.new(Weibo::Config.api_key, Weibo::Config.api_secret) 
    oauth.authorize_from_request(session[:rtoken], session[:rsecret], params[:oauth_verifier])
    session[:rtoken], session[:rsecret] = nil, nil
    session[:atoken], session[:asecret] = oauth.access_token.token, oauth.access_token.secret
    
    if OauthInfo.all.size == 0
      create
    else
      update
    end
  end

  # 创建并保存新访问授权码
  def create
    @oauth_info = OauthInfo.new(params[:oauth_info])
    @oauth_info.atoken = session[:atoken]
    @oauth_info.asecret = session[:asecret]
    
    respond_to do |format|
      if @oauth_info.save
        format.html { redirect_to(oauth_infos_url, :notice => 'A new Oauth_info was successfully gotten.') }
        format.xml  { render :xml => @oauth_info, :status => :created, :location => @oauth_info }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @oauth_info.errors, :status => :unprocessable_entity }
      end
    end
  end

  # 保存并更新访问授权码
  def update
    @oauth_info = OauthInfo.find_by_id(1)
    @oauth_info.atoken = session[:atoken]
    @oauth_info.asecret = session[:asecret]
    
    respond_to do |format|
      if @oauth_info.update_attributes(params[:oauth_info])
        format.html { redirect_to(oauth_infos_url, :notice => 'A new Oauth_info was successfully gotten.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @oauth_info.errors, :status => :unprocessable_entity }
      end
    end
  end

  
end
