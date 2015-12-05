class MainController < ApplicationController

  def index
  end

  def admin
  end

  def search

    if user_signed_in?

		cookies[:general] = params[:query][:type_general]
		cookies[:entities] = params[:query][:entities]
		cookies[:num_results] = params[:query][:number_results]
		cookies[:recent] = params[:query][:recent]
		cookies[:since] = params[:query][:search_date]


      search = Query.create()
      user_id = session[:current_user_id]
      redirect_to :action => "user_result", :id => 1
    else
      cookies[:general] = params[:query][:type_general]
	    cookies[:entities] = params[:query][:entities]
      cookies[:num_results] = params[:query][:number_results]
      cookies[:recent] = params[:query][:recent]
      cookies[:until] = params[:query][:search_date]

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
	if (cookies[:entities] == '1')
		if (cookies[:recent] == '1')
			@tweets = client.search(cookies[:general], :result_type => "recent").take(cookies[:num_results].to_i)
		else
			@tweets = client.search(cookies[:general], :until => cookies[:until]).take(cookies[:num_results].to_i)
		end
	else
		if (cookies[:recent] == '1')
			@tweets = client.search(cookies[:general], :result_type => "recent").take(cookies[:num_results].to_i)
		else
			@tweets = client.search(cookies[:general], :until => cookies[:until]).take(cookies[:num_results].to_i)
		end
	end
		
	# @tweets = client.search(cookies[:general], :since=> => cookies[:since], :include_entities=>cookies[:entities], :count=>cookies[:num_results].to_i)
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
