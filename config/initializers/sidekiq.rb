Sidekiq.configure_server do |config|
  uri =  ENV["REDISTOGO_URL"] || "redis://localhost:6379/"
  config.redis = { url: uri }
end

Sidekiq.configure_client do |config|
  uri =  ENV["REDISTOGO_URL"] || "redis://localhost:6379/"
  config.redis = { url: uri }
end