require 'resque'

Resque.enqueue(WeiboInfo)
=begin
class Jobs
  def start
    Resque.enqueue(WeiboInfo)
  end
end
=end