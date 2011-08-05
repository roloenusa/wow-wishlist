class CharactersController < ApplicationController
  
  def show
    @character = Character.find(params[:id])
    @title = "#{@character.realm.name} | #{@character.name}"
  end
  
  def index
    region = params[:region]
    realm = params[:realm]
    character = params[:character]
  end
  
  def search
    @title = "Search"
    if @character = Character.find_or_retrieve(params[:region], params[:realm], params[:name])
      redirect_to character_path(@character)
    else
      flash.now[:error] = "#{params}"
    end
  end
end
