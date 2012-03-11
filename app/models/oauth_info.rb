require 'weibo'
require 'crack'

# 微博应用的授权码
Weibo::Config.api_key = "4178706590"
Weibo::Config.api_secret = "0a4b74b632fb7f41f001aa5c23b60b87"

class OauthInfo < ActiveRecord::Base
  
  attr_reader :client
  
  def create_oauth_client 
    info = OauthInfo.find_by_id(1)           
    @client = Weibo::OAuth.new(Weibo::Config.api_key, Weibo::Config.api_secret)      
    @client.authorize_from_access(info.atoken, info.asecret)
  end
  
end
