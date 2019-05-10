#读取redis配置文件
redis_config = YAML::load_file("#{Rails.root}/config/redis.yml")
#环境
env = Rails.env
#配置
hash = {
  host: redis_config[env]['host'],
  port: redis_config[env]['port']
}
#初始化
$redis = Redis.new(hash)
