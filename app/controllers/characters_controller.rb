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
  
  def new
    @title = "New"
    
    render 'search'
  end
  
  
  def search
    @title = "Search"
    
    @character = Character.find_or_create(params[:region], params[:realm], params[:name])
    if @character.nil?
      flash[:error] = "We were unable to find #{params[:realm]}/#{params[:name]} in Battle.net"
      redirect_to new_character_path
    else
      redirect_to @character
    end
  end
end
