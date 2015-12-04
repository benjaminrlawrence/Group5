class MainController < ApplicationController

  def index
  end

  def admin
  end

  def search

    if user_signed_in?

      general = :type_general
      hashtag = :type_hashtag
      user_search = :type_twitter_user
      tagged_search = :type_tagged_twitter_user
      num_results = :number_results
      recent = :recent
      since = :search_date


      search = Query.create()
      user_id = session[:current_user_id]
      redirect_to :action => "user_result", :id => 1
    else
      cookies[:general] = params[:query][:type_general]

      cookies[:hashtag] = params[:query][:type_hashtag]
      cookies[:user_search] = params[:query][:type_twitter_user]
      cookies[:tagged_search] = params[:query][:type_tagged_twitter_user]
      cookies[:num_results] = params[:query][:number_results]
      cookies[:recent] = params[:query][:recent]
      cookies[:since] = params[:query][:search_date]

      redirect_to :action => "result"

    end
  end

  def result
    @queries = Query.all
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "E58XYQmJzwu03GJ8o3YGDbQJu"
      config.consumer_secret     = "qrhRkdp7IMg7ZdDKibFjkxGTFWe11HhHx0aupEAnSCN7KoIXqI"
      config.access_token        = "2512534718-1dHuDxdtZphrkoKA8TJqAsvoc23kxBhRmXJ42BF"
      config.access_token_secret = "5wnW2BhxjPLWYefCSVsvqdfRYKewuSHsZEZhaB7drJ2zF"
    end
   @tweets = client.search(cookies[:general], :result_type => "recent").take(cookies[:num_results].to_i)
  end

  def user_result
    @queries = Query.all
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "E58XYQmJzwu03GJ8o3YGDbQJu"
      config.consumer_secret     = "qrhRkdp7IMg7ZdDKibFjkxGTFWe11HhHx0aupEAnSCN7KoIXqI"
      config.access_token        = "2512534718-1dHuDxdtZphrkoKA8TJqAsvoc23kxBhRmXJ42BF"
      config.access_token_secret = "5wnW2BhxjPLWYefCSVsvqdfRYKewuSHsZEZhaB7drJ2zF"
    end
    @tweets = client.search("to:justinbieber marry me", :result_type => "recent").take(5)
  end

end
