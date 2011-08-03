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
end
