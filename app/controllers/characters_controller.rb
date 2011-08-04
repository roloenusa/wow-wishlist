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
    realm = params[:realm]
    name = params[:name]
    
    @character = Character.find_or_retrieve(region, realm, name)
    
    if !@character.nil?
      render 'show'
    else
      flash[:error] = "We couldn't find your character... Did you spell the name right?"
    end
  end
end
