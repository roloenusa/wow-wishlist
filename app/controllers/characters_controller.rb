class CharactersController < ApplicationController

  def show
    @character = Character.find(params[:id])
    @title = "#{@character.realm} | #{@character.name}"
  end
  
  def new
  end
end
