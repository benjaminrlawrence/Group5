require 'twitter'

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "E58XYQmJzwu03GJ8o3YGDbQJu"
  config.consumer_secret     = "qrhRkdp7IMg7ZdDKibFjkxGTFWe11HhHx0aupEAnSCN7KoIXqI"
  config.access_token        = "2512534718-1dHuDxdtZphrkoKA8TJqAsvoc23kxBhRmXJ42BF"
  config.access_token_secret = "5wnW2BhxjPLWYefCSVsvqdfRYKewuSHsZEZhaB7drJ2zF"
end

