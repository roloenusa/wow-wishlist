class ItemsController < ApplicationController
  
  def show
    @item = Item.find_or_create(params[:id]).prepare!
    @title = "Item | #{@item.name}"
  end
end
