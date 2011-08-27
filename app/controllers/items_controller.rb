class ItemsController < ApplicationController
  
  def show
    @item = Item.find_or_create(params[:id]).prepare!
    @title = "Item | #{@item.name}"
  end
  
  def index
    @title = "Items"
    @items = Item.order("id DESC").paginate(:page => params[:page], :per_page => 10)
  end
  
  def search
    if @item = Item.find_or_create(params[:id].to_i)
      redirect_to @item
    elsif @item = Item.find_by_name(params[:id])
      redirect_to @item
    else
      flash[:error] = "We were unable to find [#{params[:id]}] in our database or Battle.net."
      flash[:notice] = "If you entered a name, please try the item id instead!"
      redirect_to items_path
    end
  end
end
