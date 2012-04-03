require 'resque'
=begin
rails_root = ENV['RAILS_ROOT'] || File.dirname(__FILE__) + '/../..' 
rails_env = ENV['RAILS_ENV'] || 'development'

resque_config = YAML.load_file(rails_root + '/config/resque.yml') 
Resque.redis = resque_config[rails_env]

Resque.redis.namespace = "webtails:resque"
=end

Dir[File.join(Rails.root, 'app', 'jobs', '*.rb')].each { |file| require file }

config = YAML::load(File.open("#{Rails.root}/config/redis.yml"))[Rails.env]
#Resque.redis = Redis.new(:host => config['host'], :port => config['port'])
Resque.redis = Redis.new(:host => "127.0.0.1", :port => 6379)
