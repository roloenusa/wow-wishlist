class CharactersController < ApplicationController
  before_filter :admin_user, :only => [:destroy]
  def show
    if @character = Character.find_by_id(params[:id])
      @title = "#{@character.realm.name} | #{@character.name}"
      @character.create_inventory
      @relationship = current_user.claimed?(@character) if current_user
    else
      render 'search'
    end
  end
  
  def index
    @title = "Characters"
    @characters = Character.order("id DESC").limit(10)
  end
  
  def update
    @character = Character.find(params[:id])
    
    if @character.update_from_battlenet?
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
    
    params[:name].gsub!(/ /,'')
    realm = Realm.find_by_id(params[:realm][:id])
    
    @character = Character.find_or_create('us', realm.name, params[:name])
    if @character.nil?
      flash[:error] = "We were unable to find #{realm.name}/#{params[:name]} in Battle.net"
      redirect_to characters_path
    else
      redirect_to @character
    end
  end
  
  def destroy
    char = Character.find(params[:id])
    char.destroy
    flash[:success] = "Character #{char.name}/#{char.realm.name} destroyed."   
    redirect_to admin_path
  end
end
