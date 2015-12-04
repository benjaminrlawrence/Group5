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
  end
end
