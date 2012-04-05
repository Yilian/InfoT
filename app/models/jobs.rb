require 'resque'

Resque.enqueue(CollectWeibo)

class Jobs
  #def start
  #  Resque.enqueue(CollectWeibo)
  #end
end
