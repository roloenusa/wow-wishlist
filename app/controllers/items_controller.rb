class ItemsController < ApplicationController
  
  def show
    @item = Item.find(params[:id])
    @title = "Item | #{@item.name}"
  end
end
