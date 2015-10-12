uri = URI.parse(ENV.fetch("REDISTOGO_URL", "redis://localhost:6379/"))
REDIS = Redis.new(:url => uri)
