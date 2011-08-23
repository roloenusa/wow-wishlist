class BoundsController < ApplicationController
  before_filter :authenticate
  
  def create
    @item = Item.find(params[:bound][:item_id])
    
    params[:bound][:persona].include?('User') ? persona = User.find_by_id(params[:bound][:persona_id]) : persona = Relationship.find_by_id(params[:bound][:persona_id])
    persona.bind!(@item)
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js
    end
  end
  
  def destroy
    @item = Bound.find(params[:id]).item
    
    params[:bound][:persona].include?('User') ? persona = User.find_by_id(params[:bound][:persona_id]) : persona = Relationship.find_by_id(params[:bound][:persona_id])
    persona.unbind!(@item)
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js
    end
  end
end