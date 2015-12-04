class MainController < ApplicationController
  def index
  end

  def admin
  end

  def search

    @query = Query.create()
    redirect_to :action => "result", :id => 1
  end

  def result
    @queries = Query.all
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "E58XYQmJzwu03GJ8o3YGDbQJu"
      config.consumer_secret     = "qrhRkdp7IMg7ZdDKibFjkxGTFWe11HhHx0aupEAnSCN7KoIXqI"
      config.access_token        = "2512534718-1dHuDxdtZphrkoKA8TJqAsvoc23kxBhRmXJ42BF"
      config.access_token_secret = "5wnW2BhxjPLWYefCSVsvqdfRYKewuSHsZEZhaB7drJ2zF"
    end
   @tweets = client.search("to:justinbieber marry me", :result_type => "recent").take(3)
  end
end
