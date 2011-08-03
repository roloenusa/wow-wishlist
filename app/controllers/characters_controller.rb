class CharactersController < ApplicationController

  def show
    @character = Character.find(params[:id])
    @title = "#{@character.realm} | #{@character.name}"
  end
  
  def index
    region = params[:region]
    realm = params[:realm]
    character = params[:character]
  end
  
  def search
    @title = "Search"
    region = params[:region]
    realm = params[:realms]
    name = params[:name]
    @character = Character.find(:first, :conditions => ["realm = ? and name = ?", realm, name])
    
    if @character.nil?
    
    else
      redirect_to(character_path(@character))
    end
  end
end
