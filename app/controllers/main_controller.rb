class MainController < ApplicationController
  def index
  end

  def admin
  end

  def search
    query = Query.create()
    redirect_to :action => "result"
  end

  def result
  end
end
