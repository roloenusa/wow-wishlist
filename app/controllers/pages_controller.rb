class PagesController < ApplicationController
  def home
    @title = "Home"
  end

  def contact
  end
  
  def search
    @title = "Search"
    @region = [:us, :eu]
  end
end
