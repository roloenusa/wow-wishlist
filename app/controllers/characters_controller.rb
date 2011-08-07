class CharactersController < ApplicationController
  
  def show
    if @character = Character.find_by_id(params[:id])
      @title = "#{@character.realm.name} | #{@character.name}"
    else
      render 'search'
    end
  end
  
  def index
    @title = "Characters"
    @characters = Character.order("id DESC").limit(10)
  end
  
  def new
    @title = "New"
    render 'search'
  end
  
  def update
    @character = Character.find(params[:id])
    
    if @character.update_from_battlenet
      flash[:success] = "We have updated #{@character.name} from Battle.net!"
      redirect_to @character
    else
      name = @character.name
      @character.delete
      flash.now[:error] = "We could not find #{name} at Battle.net!"
      render 'search'
    end
      
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
