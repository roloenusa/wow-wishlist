class PagesController < ApplicationController
  before_filter :admin_user,  :only => [:admin, :destroy]
  
  def home
    @title = "Home"
  end

  def contact
  end
  
  def search
    @title = "Search"
    @region = [:us, :eu]
  end
  
  def admin
    @title = "Admin Panel"
    @users = User.order("id DESC").paginate(:page => params[:page_user], :per_page => 20)
    @items = Item.order("id DESC").paginate(:page => params[:page_item], :per_page => 20)
    @characters = Character.order("id DESC").paginate(:page => params[:page_character], :per_page => 20)
  end
end
