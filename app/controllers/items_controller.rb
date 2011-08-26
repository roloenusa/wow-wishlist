class ItemsController < ApplicationController
  
  def show
    @item = Item.find_or_create(params[:id]).prepare!
    @title = "Item | #{@item.name}"
  end
  
  def index
    @title = "Items"
    @items = Item.order("id DESC").paginate(:page => params[:page], :per_page => 5)
  end
end
