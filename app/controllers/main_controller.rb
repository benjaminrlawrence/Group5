class MainController < ApplicationController

  def index
    if user_signed_in?
      session[:current_user_id] = current_user.id
      @last = Query.find_by_user_id(current_user.id)

    end
    #@last = Query.find(1);
  end

  def admin
  end

  def search
  end

  def query

    if user_signed_in?

      cookies[:general] = params[:query][:keyword]
      cookies[:entities] = params[:query][:entities]
      cookies[:num_results] = params[:query][:number_results]
      cookies[:recent] = params[:query][:recent]
      cookies[:since] = params[:query][:search_date]

      user_id = current_user.id

      search = Query.new
      search.created_at = DateTime.now
      search.search_query = params[:query][:keyword]
      search.query_type = 'General'
      search.user_id = user_id
      search.searched_limit = params[:query][:number_results]
      search.searched_date = params[:query][:search_date]
      search.save

      redirect_to :action => "result"
    else
      cookies[:general] = params[:query][:keyword]
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
