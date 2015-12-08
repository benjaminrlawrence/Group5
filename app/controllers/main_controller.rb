class MainController < ApplicationController

  def index
    if user_signed_in?
      session[:current_user_id] = current_user.id
      @last = Query.where(:user_id => current_user.id).limit(5).order('created_at desc')
    else
      session[:current_user_id] = nil
      @last = nil
    end
  end

  def admin
  end

  def search
  end

  def query

    if user_signed_in?

      search = Query.new
      search.created_at = DateTime.now
      search.search_query = params[:query][:keyword]
      search.query_type = params[:query][:result_type]
      search.user_id = current_user.id
      search.search_limit = params[:query][:count].present? ? params[:query][:count] : 0
      if params[:query][:search_date].present?
        search.search_date = Date.strptime(params[:query][:search_date], '%m/%d/%Y').strftime("%Y-%m-%d")
      end
      search.save

      redirect_to :action => "user_result", :id => search.id
    else
      cookies[:general] = params[:query][:keyword]
	    cookies[:entities] = params[:query][:entities]
      cookies[:count] = params[:query][:count]
      cookies[:result_type] = params[:query][:result_type]
      cookies[:until] = Date.strptime(params[:query][:search_date], '%m/%d/%Y').strftime("%Y-%m-%d")

      redirect_to :action => "result"

    end
  end

  def result
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "E58XYQmJzwu03GJ8o3YGDbQJu"
      config.consumer_secret     = "qrhRkdp7IMg7ZdDKibFjkxGTFWe11HhHx0aupEAnSCN7KoIXqI"
      config.access_token        = "2512534718-1dHuDxdtZphrkoKA8TJqAsvoc23kxBhRmXJ42BF"
      config.access_token_secret = "5wnW2BhxjPLWYefCSVsvqdfRYKewuSHsZEZhaB7drJ2zF"
    end
	if cookies[:entities]
		if cookies[:result_type]
			@tweets = client.search(cookies[:general], :lang => "en", :include_entities => true, :result_type => cookies[:result_type]).take(cookies[:count].to_i)
		else
			@tweets = client.search(cookies[:general], :lang => "en", :until => cookies[:until]).take(cookies[:count].to_i)
		end
	else
		if cookies[:result_type]
			@tweets = client.search(cookies[:general], :lang => "en", :result_type => cookies[:result_type]).take(cookies[:count].to_i)
		else
			@tweets = client.search(cookies[:general], :lang => "en", :until => cookies[:until]).take(cookies[:count].to_i)
		end
	end
		
	  #@tweets = client.search(cookies[:general], :since=> => cookies[:since], :include_entities=>cookies[:entities], :count=>cookies[:num_results].to_i)
    #@tweets = client.search(cookies[:general], :lang => "en", :result_type => cookies[:result_type]).take(cookies[:count].to_i)
  end

  def user_result
    @query = Query.find(params[:id])
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "E58XYQmJzwu03GJ8o3YGDbQJu"
      config.consumer_secret     = "qrhRkdp7IMg7ZdDKibFjkxGTFWe11HhHx0aupEAnSCN7KoIXqI"
      config.access_token        = "2512534718-1dHuDxdtZphrkoKA8TJqAsvoc23kxBhRmXJ42BF"
      config.access_token_secret = "5wnW2BhxjPLWYefCSVsvqdfRYKewuSHsZEZhaB7drJ2zF"
    end
    if !@query.search_date.empty?
      # until is currently not working going back to default
      # @tweets = client.search(@query.search_query, :lang => "en", :since => @query.search_date, :until => @query.search_date, :result_type => @query.query_type).take(@query.search_limit)
      @tweets = client.search(@query.search_query, :lang => "en", :result_type => @query.query_type).take(@query.search_limit)
    else
      @tweets = client.search(@query.search_query, :lang => "en", :result_type => @query.query_type).take(@query.search_limit)
    end
    render 'result'
  end

end
