class RelationshipsController < ApplicationController
  before_filter :authenticate
  
  def create
    @character = Character.find(params[:relationship][:character_id])
    current_user.claim!(@character)
    respond_to do |format|
      format.html { redirect_to @character }
      format.js
    end
  end
  
  def destroy
    @character = Relationship.find(params[:id]).character
    current_user.unclaim!(@character)
    respond_to do |format|
      format.html { redirect_to @character }
      format.js
    end
  end
end
