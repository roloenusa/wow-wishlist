class ItemsController < ApplicationController
  
  def show
    @item = Item.find(params[:id]).prepare!
    @title = "Item | #{@item.name}"
  end
end
